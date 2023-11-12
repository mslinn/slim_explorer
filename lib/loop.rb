require 'cgi'
require 'date'
require 'listen'
require 'pathname'
require 'slim'
require 'time'

# Main loop
class SlimExplorer
  attr_reader :output_directory

  def initialize(
    output_directory: 'www',
    watched_directory: 'data',
    slim_template: 'template.slim',
    yaml_file: 'scope.yaml'
  )
    @slim_template = slim_template
    @yaml_file = yaml_file

    @output_directory = Pathname.new(File.expand_path(output_directory))
    @watched_directory = Pathname.new(File.expand_path(watched_directory))
    @fq_template = @watched_directory + slim_template
    @fq_scope = @watched_directory + yaml_file

    @with_env_vars = false
    @extra_properties = {}

    @when_generated = ''
  end

  def explore
    puts "Listening to changes to files in #{@watched_directory}."
    puts "index.html and raw.html in #{@output_directory} will be regenerated each time a file in the watched directory is changed."
    process_once
    listener = Listen.to(@watched_directory, force_polling: true, relative: true) do |modified|
      puts "  #{DateTime.now.iso8601}  #{modified.join(', ')} was changed."
      process_once
    end
    listener.start
    sleep
  end

  # Slim error messages can be unhelpful
  def friendly_message(error)
    if error.message == "undefined method `[]' for nil:NilClass"
      puts "The Slim Language template in #{@watched_directory}/#{@slim_template} references an undefined variable or has a syntax error"
    else
      puts error.message
    end
  end

  # Wrap HTML around Slim-generated content to aid the viewer
  # The page automagically reloads every 5 seconds
  def index_html(content)
    <<~HEREDOC
      <!doctype html>
      <html>
        <head>
          <meta charset="utf-8">
          <meta name="viewport" content="width=device-width, initial-scale=1">
          <title>Slim Explorer Output</title>
          <meta name="description" content="Slim Explorer output, regenerated on every change.">
          <meta name="author" content="Slim Explorer">
          <link rel="icon" href="favicon.png" type="image/png">
          <link rel="stylesheet" href="stylesheet.css?v=1.0">
          <meta http-equiv="refresh" content="5">
        </head>
        <body>
          <div class="divider">Generated #{@when_generated}</div>
          #{content}

          <div class="divider" style="margin-top: 1em;">Generated HTML Source</div>
          <pre>#{CGI.escapeHTML content}</pre>

          <div class="divider" style="margin-top: 1em;">Slim Template</div>
          <pre>#{CGI.escapeHTML File.read(@fq_template)}</pre>

          <div class="divider" style="margin-top: 1em;">YAML data</div>
          <pre>#{CGI.escapeHTML File.read(@fq_scope)}</pre>
        </body>
      </html>
    HEREDOC
  end

  # See https://www.ruby-toolbox.com/projects/tilt
  def process_once
    template = Slim::Template.new(@fq_template, { 'pretty': true })
    scope = Env.from_file(@fq_scope)
    scope.include_env_vars_as_properties if @with_env_vars
    scope.add_properties(@extra_properties)
    begin
      contents = template.render(scope)
      write_file('raw.html', contents)

      @when_generated = DateTime.now.iso8601
      write_file('index.html', index_html(contents))
    rescue StandardError => e
      friendly_message(e)
    end
  end

  def with_env_vars
    @with_env_vars = true
    self
  end

  def with_properties(hash)
    @extra_properties = hash
    self
  end

  def write_file(file_name, contents)
    # Writes a file with the given name and contents in @output_directory.
    File.open(@output_directory + file_name, 'w') do |fo|
      fo.write(contents)
    end
  end
end
