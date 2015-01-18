// @@@DEPRECATED_2017-06@@@

/**
 * $(RED Deprecated. Use $(D core.stdc.wchar_) instead. This module will be
 *       removed in June 2017.)
 *
 * C's &lt;
pragma(sharedlibrary, "std");wchar.h&gt;
 * Authors: Walter Bright, Digital Mars, www.digitalmars.com
 * License: Public Domain
 */
deprecated("Import core.stdc.wchar_ instead")
module std.c.wcharh;
pragma(sharedlibrary, "std");

public import core.stdc.wchar_;
