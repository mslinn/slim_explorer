# frozen_string_literal: true

require 'listen'
require 'slim'

# Main loop
# See https://www.ruby-toolbox.com/projects/tilt
class SlimExplorer
  def initialize(watched_directory: 'data', slim_template: 'template.slim', yaml_file: 'scope.yaml')
    @watched_directory = watched_directory
    @slim_template = slim_template
    @yaml_file = yaml_file
    @with_env_vars = false
    @extra_properties = {}
  end

  def friendly_message(error)
    if error.message == "undefined method `[]' for nil:NilClass"
      puts "The slim template in #{@watched_directory}/#{@slim_template} references an undefined variable or has a syntax error"
    else
      puts error.message
    end
  end

  def process_once
    fq_template = "#{@watched_directory}/#{@slim_template}"
    fq_scope = "#{@watched_directory}/#{@yaml_file}"
    template = Slim::Template.new(fq_template, { 'pretty': true })
    scope = Env.from_file(fq_scope)
    scope.include_env_vars_as_properties if @with_env_vars
    scope.add_properties(@extra_properties)
    begin
      File.open('output.html', 'w') do |fo|
        fo.write(template.render(scope))
      end
    rescue StandardError => e
      friendly_message(e)
    end
  end

  def explore
    fq_dir = File.expand_path(@watched_directory)
    puts "Listening to changes to files in #{fq_dir}"
    puts 'output.html will be regenerated each time a file is changed.'
    process_once
    listener = Listen.to(fq_dir) do
      process_once
    end
    listener.start
    sleep
  end

  def with_env_vars
    @with_env_vars = true
    self
  end

  def with_properties(hash)
    @extra_properties = hash
    self
  end
end
