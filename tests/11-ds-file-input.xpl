<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
  xmlns:p="http://www.w3.org/ns/xproc"
  xmlns:ccproc="http://www.corbas.co.uk/ns/xproc/steps"
  name="tester"
  xmlns:c="http://www.w3.org/ns/xproc-step"
  version="3.0">

  <p:documentation>Load a simple directory of xml files. This pipeline will fail, as it points at a file, not a directory.</p:documentation>

  <p:import href="http://xml.corbas.co.uk/xml/xproc-tools/xproc/directory-source.xpl"/>

  <p:output port="result" sequence="true" serialization="map{'indent': true()}">
    <p:pipe port="result" step="loader"/>
  </p:output>
  

  <ccproc:directory-source name="loader" fail-on-error="true">
    <p:with-option name="path" select="resolve-uri('data/dir-source/01/file01.xml')"/>
  </ccproc:directory-source>


</p:declare-step>
