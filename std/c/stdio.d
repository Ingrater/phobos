// @@@DEPRECATED_2017-06@@@

/**
 * $(RED Deprecated. Use $(D core.stdc.stdio) instead. This module will be
 *       removed in June 2017.)
 *
 * C's &lt;
pragma(sharedlibrary, "std");stdio.h&gt; for the D programming language
 * Authors: Walter Bright, Digital Mars, http://www.digitalmars.com
 * License: Public Domain
 */
deprecated("Import core.stdc.stdio instead")
module std.c.stdio;
pragma(sharedlibrary, "std");

public import core.stdc.stdio;
