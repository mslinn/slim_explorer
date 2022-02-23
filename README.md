# Slim Language Explorer

[Slim](https://github.com/slim-template/slim#configuring-slim) is a cool way to generate a potentially complex HTML block with a minimum of characters.
Most often, Slim is thought of as an alternative to Ruby on Rail's ERB, however it is useful in a broad range of contexts.

When you are trying to figure out how to express HTML in Slim, however, you inevitably rerun the generation process over and over.
This git project consists of a small Ruby program that launches Slim, whenever a file is modified, created or deleted within the project.
This allows you to edit the Slim 'program', and view its output each time you save it.


## Slim Language REPL

In some sense, this is a REPL for the Slim Language.

  1) Start a bash shell and type: `./slim_explorer`
  2) The contents of <code>template.slim</code> are evaluated and displayed.
  3) Use the editor of your choice to modify any file, including <code>template.slim</code>
  4) The contents of <code>template.slim</code> are re-evaluated and re-displayed.

... this continues until you interrupt the process.


## Installation
```shell
$ bundle install
```

## Running Slim Language Explorer
```shell
$ ./slim_explorer
```
