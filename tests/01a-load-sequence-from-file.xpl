<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
	xmlns:p="http://www.w3.org/ns/xproc"
	xmlns:ccproc="http://www.corbas.co.uk/ns/xproc/steps"
	xmlns:c="http://www.w3.org/ns/xproc-step"
	xmlns:test="http://www.corbas.co.uk/ns/test"
	version="3.0"
	name="test-script">
	
	<p:documentation>Simple test driver for the load-sequence-from-file module. Tests loading of two simple documents.</p:documentation>
	
	<p:import href="../xproc/load-sequence-from-file.xpl"/>
	
	<p:input port="manifest">
		<p:document href="manifests/03-manifest-metadata.xml"/>
	</p:input>
	
	<p:output port="result" serialization="map{'indent': true()}">
		<p:pipe port="result" step="merge-load"/>
	</p:output>
	
	<ccproc:load-sequence-from-file name="load-manifest">
		<p:with-input port="source">
			<p:pipe port="manifest" step="test-script"/>
		</p:with-input>
	</ccproc:load-sequence-from-file>
	
	<p:wrap-sequence name="merge-load" wrapper="test:sequence">
		<p:with-input port="source">
			<p:pipe port="result" step="load-manifest"/>
		</p:with-input>
	</p:wrap-sequence>
	
</p:declare-step>