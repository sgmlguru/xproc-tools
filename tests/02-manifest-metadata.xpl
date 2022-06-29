<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
	xmlns:p="http://www.w3.org/ns/xproc"
	xmlns:ccproc="http://www.corbas.co.uk/ns/xproc/steps"
	name="tester"
	xmlns:c="http://www.w3.org/ns/xproc-step"
	version="3.0">
	
	<p:documentation>Test the addition of params to files loaded from a manifest. </p:documentation>
	
	<p:import href="http://xml.corbas.co.uk/xml/xproc-tools/xproc/load-sequence-from-file.xpl"/>
	
	<p:input port="manifest">
		<p:document href="manifests/02-manifest-metadata.xml"/>
	</p:input>

	<p:output port="result" serialization="map{'indent': true()}">
		<p:pipe port="result" step="wrapper"/>
	</p:output>
	
	<ccproc:load-sequence-from-file name="loader">
		<p:with-input port="source">
			<p:pipe port="manifest" step="tester"/>
		</p:with-input>
	</ccproc:load-sequence-from-file>
	
	<p:wrap-sequence wrapper="c:result" name="wrapper">
		<p:with-input port="source">
			<p:pipe port="result" step="loader"/>
		</p:with-input>
	</p:wrap-sequence>
	

</p:declare-step>