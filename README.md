# Slim Language Explorer

[Slim](https://github.com/slim-template/slim#configuring-slim) is a cool way to generate a potentially complex HTML block with a minimum of characters.
Most often, Slim is thought of as an alternative to Ruby on Rail's ERB, however it is useful in a broad range of contexts.

When you are trying to figure out how to express HTML in Slim, however, you inevitably rerun the generation process over and over.
This git project consists of a small Ruby program that launches Slim, whenever a file is modified, created or deleted within the project.
This allows you to edit the Slim 'program', and view its output each time you save it.


## Slim Language REPL

In some sense, this is a REPL for the Slim Language.

  1) Start a bash shell and type: `./slim_explorer`.
The contents of <code>template.slim</code> are evaluated and displayed using the keys and values stored in file `scope.yaml`.
  3) Use the editor of your choice to modify any file, including <code>template.slim</code>
  4) The contents of <code>template.slim</code> are re-evaluated and re-displayed each time a file in this project directory tree is saved, created or deleted.

... this continues until you interrupt the process.

If you modify the source code, the program must be restarted.


## Live Reload
The `scope` hash / dictionary / key-value store / associative array is reloaded whenever the contents of `scope.yaml` change.


## Installation
```shell
$ bundle install
```

## Running Slim Language Explorer
```shell
$ ./slim_explorer
```
