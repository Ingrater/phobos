// @@@DEPRECATED_2017-06@@@

/**
 * $(RED Deprecated. Use $(D core.stdc.stddef) instead. This module will be
 *       removed in June 2017.)
 *
 * C's &lt;
pragma(sharedlibrary, "std");stddef.h&gt;
 * Authors: Walter Bright, Digital Mars, http://www.digitalmars.com
 * License: Public Domain
 */
deprecated("Import core.stdc.stddef instead")
module std.c.stddef;
pragma(sharedlibrary, "std");

public import core.stdc.stddef;
