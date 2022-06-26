<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
	xmlns:p="http://www.w3.org/ns/xproc"
	xmlns:ccproc="http://www.corbas.co.uk/ns/xproc/steps" 
	xmlns:c="http://www.w3.org/ns/xproc-step"
	version="3.0"
	name="test">
	
	<p:documentation>This test has been deprecated.</p:documentation>
	
	<p:import href="../xproc/split-document.xpl"/>
	
	<p:input port="source">
		<p:document href="data/test-04.xml"/>
	</p:input>
	
	<p:output port="result">
		<p:pipe port="result" step="count-results"/>
	</p:output>
	
	
	<ccproc:split-document name="split-test">
		<p:with-input port="source">
			<p:pipe port="source" step="test"/>
		</p:with-input>
		<p:with-option name="match" select="'//para'"/>
	</ccproc:split-document>
	
	<p:count name="count-results">
		<p:with-input port="source">
			<p:pipe port="result" step="split-test"/>
		</p:with-input>
	</p:count>
	
	
</p:declare-step>