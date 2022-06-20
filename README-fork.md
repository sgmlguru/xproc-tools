# README

This fork of Nic Gibson's excellent XProc Tools is an attempt to update his tools, in particular the threaded XSLT functionality, to XProc 3.0. I've been using the tools for years in my work, and now that XProc 3.0 is nearing completion, it is time to bring these still extremely useful tools to the fold.

The first order of business is to merge the useful fix branches with develop to form a basis for XProc 3.0.


## Prerequisites and Notes

We note the following:

* The last call XProc 3.0 draft specifications are currently best supported by Achim Berndzen's [MorganaXProc-IIIse](https://www.xml-project.com/) processor, so it follows that the XProc 3.0 fork is tested against that processor, first and foremost. Norm Walsh's XML Calabash is coming, though, and I will make sure to test my XProc 3.0 against it, too.
* Some of Nic's XProc 1.0 libraries will no longer be needed:
	- The recursive directory listing steps can be reimplemented using standard XProc 3.0.
	- The required Calabash extension steps can all be reimplemented using standard XProc 3.0.
