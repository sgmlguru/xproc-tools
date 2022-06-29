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
    
    <p:output port="result" serialization="map{'indent': true()}" sequence="true"/>
    
    <ccproc:load-sequence-from-file name="loader">
        <p:with-input port="source">
            <p:pipe port="manifest" step="tester"/>
        </p:with-input>
    </ccproc:load-sequence-from-file>
    
    <p:split-sequence name="split" test="position() = 1">
        <p:with-input>
            <p:pipe port="result" step="loader"/>
        </p:with-input>
    </p:split-sequence>
    
    <p:identity name="unmatched">
        <p:with-input>
            <p:pipe port="not-matched" step="split"/>
        </p:with-input>
    </p:identity>
    
    
</p:declare-step>