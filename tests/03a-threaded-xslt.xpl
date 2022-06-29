<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
	xmlns:p="http://www.w3.org/ns/xproc"
	xmlns:ccproc="http://www.corbas.co.uk/ns/xproc/steps"
	name="tester"
	xmlns:c="http://www.w3.org/ns/xproc-step"
	version="3.0">

	<p:documentation>Test to produce the first XSLT in a sequence of XSLTs and associated metadata from a manifest.</p:documentation>
	
	<p:import href="http://xml.corbas.co.uk/xml/xproc-tools/xproc/load-sequence-from-file.xpl"/>
	<p:import href="http://xml.corbas.co.uk/xml/xproc-tools/xproc/threaded-xslt.xpl"/>

	<p:input port="manifest">
		<p:document href="manifests/03-manifest-metadata.xml"/>
	</p:input>

	<p:input port="source">
		<p:document href="data/test-03.xml"/>
	</p:input>

	<p:output port="result" serialization="map{'indent': true()}" sequence="true">
		<p:pipe port="matched" step="split"/>
	</p:output>

	
	<ccproc:load-sequence-from-file name="loader">
		<p:with-input port="source">
			<p:pipe port="manifest" step="tester"/>
		</p:with-input>
	</ccproc:load-sequence-from-file>
	
	<p:split-sequence
		name="split"
		test="position()=1">
		<p:with-input port="source">
			<p:pipe port="result" step="loader"/>
		</p:with-input>
	</p:split-sequence>

</p:declare-step>
