<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
	xmlns:p="http://www.w3.org/ns/xproc"
	xmlns:ccproc="http://www.corbas.co.uk/ns/xproc/steps"
	xmlns:c="http://www.w3.org/ns/xproc-step"
	name="test-script"
	version="3.0">
	
	<p:documentation>Simple test driver for the directory-listing module. Runs with resolve on and off. 
	Filters on xml and xpl documents</p:documentation>
	
	<p:import href="http://xml.corbas.co.uk/xml/xproc-tools/xproc/directory-list.xpl"/>
	
	<p:output port="result" serialization="map{'indent': true()}">
		<p:pipe port="result" step="merge-load"/>
	</p:output>
	
	<ccproc:directory-list
		path="."
		include-filter="\.x[mp]l"
		name="base-listing"/>
	<ccproc:directory-list
		path="."
		include-filter="\.x[mp]l"
		resolve="true"
		name="resolved-listing"/>
	
	
	<p:wrap-sequence name="merge-load" wrapper="c:result">
		<p:with-input port="source">
			<p:pipe port="result" step="base-listing"/>
			<p:pipe port="result" step="resolved-listing"/>
		</p:with-input>
	</p:wrap-sequence>
	
</p:declare-step>