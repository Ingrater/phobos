// @@@DEPRECATED_2017-06@@@

/**
 * $(RED Deprecated. Use $(D core.stdc.stdarg) instead. This module will be
 *       removed in June 2017.)
 *
 * C's &lt;
pragma(sharedlibrary, "std");stdarg.h&gt;
 * Authors: Hauke Duden and Walter Bright, Digital Mars, www.digitalmars.com
 * License: Public Domain
 */
deprecated("Import core.stdc.stdarg instead")
module std.c.stdarg;
pragma(sharedlibrary, "std");

public import core.stdc.stdarg;
