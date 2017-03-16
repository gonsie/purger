# Parser Unified ROSS-Gates Emission Routine
  This project contains ply-based parsers for [Liberty](http://www.opensourceliberty.org/opensourceliberty.html) gate libraries and Verilog netlists.
  These parses emit code which augments the existing [ROSS Gates Model](http://github.com/gonsie/gates).
  Note that these are not tested for the general Liberty and Verilog specifications, and as such they may only work for a subset of libraries.

## Dependencies

   The [Python Lex-Yacc by dabeaz](https://github.com/dabeaz/ply) package is included through the use of a git-submodule.
   Init the ply submodule and install it through distutils:
   ```
   cd purger
   git submodule init
   git submodule update
   cd ply
   python setup.py install
   ```

## Running
   Look at `run_example.sh`.

## Branches
  - Master: this represents the branch currently integrated with the [ROSS/gates](https://github.com/gonsie/gates) project
  - sql: utilizes an SQL database to store the object model
  - py_classes: utilizes python classes to store the object model
