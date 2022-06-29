<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
    xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:ccproc="http://www.corbas.co.uk/ns/xproc/steps"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    name="tester"
    xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:fn="http://www.w3.org/2005/xpath-functions"
    version="3.0">
    
    <p:documentation>Run XSLT manifest. Output pairwise intermediate results with XSLT step URI and XSLT result.</p:documentation>
    
    <p:import href="http://xml.corbas.co.uk/xml/xproc-tools/xproc/load-sequence-from-file.xpl"/>
    <p:import href="http://xml.corbas.co.uk/xml/xproc-tools/xproc/threaded-xslt.xpl"/>
    
    <p:input port="manifest">
        <p:document href="manifests/03-manifest-metadata.xml"/>
    </p:input>
    
    <p:input port="source">
        <p:document href="data/test-03.xml"/>
    </p:input>
    
    <p:output port="result" serialization="map{'indent': true()}" sequence="true"/>
    
    
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
    </ccproc:threaded-xslt>
    
    <p:json-merge name="merged">
        <p:with-input select="document-uri(/)">
            <p:pipe step="loader" port="result"/>
        </p:with-input>
    </p:json-merge>
    
    <p:cast-content-type name="caster" content-type="application/xml"/>
    
    <p:filter name="filter" select="//*:string/text()"/>
    
    
    <p:pack>
        <p:with-input port="source" select=".">
            <p:pipe step="filter" port="result"/>
        </p:with-input>
        <p:with-input port="alternate" select=".">
            <p:pipe step="threader" port="intermediates"/>
        </p:with-input>
        <p:with-option name="wrapper" select="'wrap'"/>
    </p:pack>
    
    
</p:declare-step>
