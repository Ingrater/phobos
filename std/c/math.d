// @@@DEPRECATED_2017-06@@@

/**
 * $(RED Deprecated. Use $(D core.stdc.math) instead. This module will be
 *       removed in June 2017.)
 *
 * C's &lt;
pragma(sharedlibrary, "std");math.h&gt;
 * Authors: Walter Bright, Digital Mars, www.digitalmars.com
 * License: Public Domain
 */
deprecated("Import core.stdc.math instead")
module std.c.math;
pragma(sharedlibrary, "std");

public import core.stdc.math;
