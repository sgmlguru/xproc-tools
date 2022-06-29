<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
    name="recdir"
    type="sg:recdir"
    version="3.0"
    xmlns:sg="http://www.sgmlguru.org/ns/steps"
    xmlns:map="http://www.w3.org/2005/xpath-functions/map"
    xmlns:sgproc="http://www.sgmlguru.org/ns/xproc/steps"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:p="http://www.w3.org/ns/xproc">
    
    <p:documentation>This lists two files in $dir but leaves out the one with the .xxx suffix</p:documentation>
    
    <p:import href="http://xml.corbas.co.uk/xml/xproc-tools/xproc/recursive-directory-list.xpl"/>
    
    <p:output port="result" serialization="map{'input': true()}"/>
    
    <p:option name="dir" select="'data/dir-source/01/'"/>
    
    <p:option name="exclude-filter" select="'\.xxx'"/>
    
    <sgproc:recursive-directory-list path="{resolve-uri($dir)}" exclude-filter="{$exclude-filter}"/>
    
</p:declare-step>
