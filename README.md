# Slim Language Explorer

https://user-images.githubusercontent.com/485818/155521347-856ca755-cb89-4bc7-97ce-fa69d091cf7a.mp4

[Slim](https://github.com/slim-template/slim#configuring-slim) is a cool way to generate a potentially complex HTML block with a minimum of characters.
Most often, Slim is thought of as an alternative to Ruby on Rail's ERB, however it is useful in a broad range of contexts.

When you are trying to figure out how to express HTML in Slim, however, you inevitably rerun the generation process over and over.
This git project consists of a small Ruby program that launches Slim, whenever a file is modified, created or deleted within the project.
This allows you to edit the Slim 'program', and view its output each time you save it.


## Slim Language REPL

In some sense, this is a REPL for the Slim Language.

  1) Start a bash shell and type: `./slim_explorer`.
     The contents of `watched/template.slim` are evaluated and displayed using the keys and values stored in file `watched/scope.yaml`.
  3) Use the editor of your choice to modify any file in the `watched` directory.
  4) The contents of `watched/template.slim` are re-evaluated and re-displayed each time a file in the `watched` directory is saved, created or deleted.

... this continues until you interrupt the process.


## Live Reload
The `scope` hash / dictionary / key-value store / associative array is reloaded from `watched/scope.yaml` whenever the contents of the watched directory change.


## Installation
  1. [Install full Ruby](https://www.ruby-lang.org/en/documentation/installation/); this should include the development tools.
  2. Clone this git repo.
  3. Install dependent gems. From the cloned git repo directory, type:
     ```shell
     $ bundle install
     ```

## Running Slim Language Explorer
```shell
$ ./slim_explorer
```
