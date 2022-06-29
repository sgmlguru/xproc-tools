<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
	xmlns:p="http://www.w3.org/ns/xproc"
	xmlns:ccproc="http://www.corbas.co.uk/ns/xproc/steps"
	name="tester"
	xmlns:c="http://www.w3.org/ns/xproc-step"
	version="3.0">
	
	<p:documentation>Test that parameters from the manifest are applied
		to the stylesheet.</p:documentation>
	
	<p:import href="http://xml.corbas.co.uk/xml/xproc-tools/xproc/load-sequence-from-file.xpl"/>
	<p:import href="http://xml.corbas.co.uk/xml/xproc-tools/xproc/threaded-xslt.xpl"/>
	
	<p:input port="manifest">
		<p:document href="manifests/08-manifest-threaded-check.xml"/>
	</p:input>
	
	<p:input port="source">
		<p:document href="data/test-03.xml"/>
	</p:input>
	
	<p:option name="parameters" select="map{'bar-param': 'as-param'}"/>
	
	<p:output port="result" serialization="map{'indent': true()}">
		<p:pipe port="result" step="threader"/>
	</p:output>
	
	
	
	<ccproc:load-sequence-from-file name="loader">
		<p:with-input port="source">
			<p:pipe port="manifest" step="tester"/>
		</p:with-input>
	</ccproc:load-sequence-from-file>
	
	<ccproc:threaded-xslt name="threader">
		<p:with-input port="stylesheets">
			<p:pipe port="result" step="loader"/>
		</p:with-input>
		<p:with-input port="source">
			<p:pipe port="source" step="tester"/>
		</p:with-input>
		<p:with-option name="parameters" select="$parameters"/>
		
	</ccproc:threaded-xslt>
	


</p:declare-step>