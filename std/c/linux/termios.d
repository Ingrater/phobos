// @@@DEPRECATED_2017-06@@@


/++
    $(RED Deprecated. Use $(D core.sys.posix.termios) instead. This module will
          be removed in June 2017.)
  +/
deprecated("Import core.sys.posix.termios instead")
module std.c.linux.termios;
pragma(sharedlibrary, "std");

version (linux):
public import core.sys.posix.termios;
