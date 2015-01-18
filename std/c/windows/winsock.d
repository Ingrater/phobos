/*
    Written by Christopher E. Miller
    Placed into public domain.
*/

// @@@DEPRECATED_2017-06@@@

/++
    $(RED Deprecated. Use $(D core.sys.windows.winsock2) instead. This module
          will be removed in June 2017.)
  +/
deprecated("Import core.sys.windows.winsock2 instead")
module std.c.windows.winsock;
pragma(sharedlibrary, "std");

version (Windows):
public import core.sys.windows.winsock2;
