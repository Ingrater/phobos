// @@@DEPRECATED_2017-06@@@

/**
 * $(RED Deprecated. Use $(D core.stdc.fenv) instead. This module will be
 *       removed in June 2017.)
 *
 * C's &lt;
pragma(sharedlibrary, "std");fenv.h&gt;
 * Authors: Walter Bright, Digital Mars, http://www.digitalmars.com
 * License: Public Domain
 */
deprecated("Import core.stdc.fenv instead")
module std.c.fenv;
pragma(sharedlibrary, "std");

public import core.stdc.fenv;
