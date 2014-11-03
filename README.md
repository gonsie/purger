# Unified ROSS-Gates Emission Routine
  This project contains ply-based parsers for [Liberty](http://www.opensourceliberty.org/opensourceliberty.html) gate libraries and Verilog netlists.
  These parses emit code which augments the existing [ROSS Gates Model](http://github.com/gonsie/gates).
  Note that these are not tested for the general Liberty and Verilog specifications, and as such they may only work for a subset of libraries.
  
## Dependencies

   [Python Lex-Yacc by dabeaz](https://github.com/dabeaz/ply).

## Running
   The parsers can be run from `production.sh`. The scripts generate code in the `current` directory.

## Todo
   - gate functions should take input, output, and current_state vectors
   - ablity to print stats for gates/library

## Branches
  - Master: this represents the branch currently integrated with the [ROSS/gates](https://github.com/gonsie/gates) project
  - sql: utilizes an SQL database to store the object model
  - py_classes: utilizes python classes to store the object model
