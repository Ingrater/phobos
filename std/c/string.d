// @@@DEPRECATED_2017-06@@@

/**
 * $(RED Deprecated. Use $(D core.stdc.string) instead. This module will be
 *       removed in June 2017.)
 *
 * C's &lt;
pragma(sharedlibrary, "std");string.h&gt;
 * Authors: Walter Bright, Digital Mars, http://www.digitalmars.com
 * License: Public Domain
 */
deprecated("Import core.stdc.string instead")
module std.c.string;
pragma(sharedlibrary, "std");

public import core.stdc.string;
