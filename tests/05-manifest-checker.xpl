<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
	xmlns:p="http://www.w3.org/ns/xproc"
	xmlns:ccproc="http://www.corbas.co.uk/ns/xproc/steps"
	name="tester"
	xmlns:c="http://www.w3.org/ns/xproc-step"
	version="3.0">
	
	<p:documentation>Test processing of additional parameters.</p:documentation>
	
	<p:import href="http://xml.corbas.co.uk/xml/xproc-tools/xproc/load-sequence-from-file.xpl"/>
	
	<p:input port="manifest">
		<p:document href="manifests/03-manifest-metadata.xml"/>
	</p:input>

	<p:output port="result" serialization="map{'indent': true()}">
		<p:pipe port="result" step="load-manifest"/>
	</p:output>
	
	
	
	<ccproc:normalise-manifest name="load-manifest">
		<p:with-input port="source">
			<p:pipe port="manifest" step="tester"/>
		</p:with-input>
	</ccproc:normalise-manifest>
	

</p:declare-step>