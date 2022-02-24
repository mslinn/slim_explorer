# Slim Language Explorer

[Slim](https://github.com/slim-template/slim#configuring-slim) is a cool way to generate a potentially complex HTML block with a minimum of characters.
Most often, Slim is thought of as an alternative to Ruby on Rail's ERB, however it is useful in a broad range of contexts.

When you are trying to figure out how to express HTML in Slim, however, you inevitably rerun the generation process over and over.
This git project consists of a small Ruby program that launches Slim, whenever a file is modified, created or deleted within the project.
This allows you to edit the Slim 'program', and view its output each time you save it.


## Slim Language REPL

In some sense, this is a REPL for the Slim Language.

  1) Start a bash shell and type: `./slim_explorer`.
The contents of <code>template.slim</code> are evaluated and displayed using the key/value store called `scope` in `slim_explorer`.
  3) Use the editor of your choice to modify any file, including <code>template.slim</code>
  4) The contents of <code>template.slim</code> are re-evaluated and re-displayed.
     If you modify the source code to slim_explorer, the program must be restarted.

... this continues until you interrupt the process.

## Limitation
The `scope` hash / dictionary / key-value store / associative array is not reinterpreted whenever those values are changed.
If that file was made external, perhaps stored as YAML, then whenever its value changed, the change event could trigger a reload of the data file. [Pull request, anyone?](https://github.com/mslinn/slim_explorer/issues/1)


## Installation
```shell
$ bundle install
```

## Running Slim Language Explorer
```shell
$ ./slim_explorer
```
