# README

This fork of Nic Gibson's excellent XProc Tools is an attempt to update his tools, in particular the threaded XSLT functionality, to XProc 3.0. I've been using the tools for years in my work, and now that XProc 3.0 is nearing completion, it was time to bring these still extremely useful tools to the fold.

Most of the tests no longer worked in the 1.0 version either; paths had been updated and code added and removed. The tests now work, sans the 07 pipeline that points to a non-existent XProc step.


## Prerequisites and Notes

We note the following:

* The last call XProc 3.0 draft specifications are currently best supported by Achim Berndzen's [MorganaXProc-IIIse](https://www.xml-project.com/) processor, so it follows that the XProc 3.0 fork is tested against that processor, first and foremost. Norm Walsh's XML Calabash is coming, though, and I will make sure to test my XProc 3.0 against it, too.
* MorganaXProc-IIIse (version 0.9.14-beta at the time of this writing) prefers Saxon 10.3; version 10.2 will crash the test pipelines
* Some of Nic's XProc 1.0 steps are no longer needed:
	- The recursive directory listing steps is reimplemented using standard XProc 3.0, plus a little XSLT to add the `@uri` attribute to `c:file`.
	- The previously required Calabash extension steps are reimplemented using standard XProc 3.0, with the exception of an OS-specific step to find out the path separator being used that is not yet implemented in XProc 3.0.
* (XSLT) parameters in XProc 3.0 are key/value pairs expressed as *maps*, which forced me to change 1.0's `input` parameters to `option`s and rewrite the XSLT that adds manifest `meta` key/value pairs to the manifest item sequences to produce maps rather than `c:param-set`.


### Recursive Directory Listing Step

XProc 1.0's `directory-list` step did not have a recurse function built in for subdirectories, so Nic added this in `recursive-directory-list.xpl` for his XProc 1.0 tools. XProc 3.0 does have recursion capabilities, alongside most of the other features in Nic's step, so this fork uses 3.0's default step, for the most part. There are a few exceptions, however:

* Nic's step has an optional `@uri` attribute with the full resolved base-uri added to each `c:file` while XProc 3.0 does not. Therefore my new `recursive-directory-list` step reproduces this feature.
* Nic's step has an option `match-path` to optionally allow include and exclude filters to match the full path, not just the filename. This is no longer supported, as 3.0's filtering approach differs from 1.0's.
* As the fork's step is no longer the same as Nic's, the new step's namespace and associated prefix are different: `xmlns:sgproc="http://www.sgmlguru.org/ns/xproc/steps"`.


## oXygen XProc 3.0 Framework

As there is not yet an out-of-the-box XProc 3.0 framework for oXygen, I have added a `framework` folder containing, well, frameworks for XProc 1.0 and 3.0. Here's how it works:

* The MIME type for `.xpl` files is now `text/xml` rather than `text/xproc`, which means that they will be opened using the default XML editor.
* As XProc 1.0 validation was part of the XProc Editor mode, 1.0 pipelines are now validated using a Relax NG schema in the `framework/resources/rng` subfolder.
* Similarly, XProc 3.0 validation is als against a Relax NG schema in `framework/resources/rng`.
* What RNG is used for XProc validation depends on the `@version` attribute.

The `framework` folder will be removed once oXygen provides 1.0 and 3.0 support out of the box.



