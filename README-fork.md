# README

This fork of Nic Gibson's excellent XProc Tools is an attempt to update his tools, in particular the threaded XSLT functionality, to XProc 3.0. I've been using the tools for years in my work, and now that XProc 3.0 is nearing completion, it is time to bring these still extremely useful tools to the fold.

The first order of business is to merge the useful fix branches with develop to form a basis for XProc 3.0.


## Prerequisites and Notes

We note the following:

* The last call XProc 3.0 draft specifications are currently best supported by Achim Berndzen's [MorganaXProc-IIIse](https://www.xml-project.com/) processor, so it follows that the XProc 3.0 fork is tested against that processor, first and foremost. Norm Walsh's XML Calabash is coming, though, and I will make sure to test my XProc 3.0 against it, too.
* MorganaXProc-IIIse (version 0.9.14-beta at the time of this writing) prefers Saxon 10.3; version 10.2 will crash the test pipelines
* Some of Nic's XProc 1.0 libraries will no longer be needed:
	- The recursive directory listing steps can be reimplemented using standard XProc 3.0.
	- The required Calabash extension steps can all be reimplemented using standard XProc 3.0.


## oXygen XProc Frameworks

As there is not yet an out-of-the-box XProc 3.0 framework for oXygen, I have added a `framework` folder containing, well, frameworks for XProc 1.0 and 3.0. Here's how it works:

* The MIME type for `.xpl` files is now `text/xml` rather than `text/xproc`, which means that they will be opened using the default XML editor.
* As XProc 1.0 validation was part of the XProc Editor mode, 1.0 pipelines are now validated using a Relax NG schema in the `framework/resources/rng` subfolder.
* Similarly, XProc 3.0 validation is als against a Relax NG schema in `framework/resources/rng`.
* What RNG is used for XProc validation depends on the `@version` attribute.

The `framework` folder will be removed once oXygen provides 1.0 and 3.0 support out of the box.
