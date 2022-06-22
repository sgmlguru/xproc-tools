<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:meta="http://www.corbas.co.uk/ns/transforms/meta"
  xmlns:c="http://www.w3.org/ns/xproc-step"
  version="3.0">
  
  <xsl:output method="adaptive"/>
  
  <xsl:template match="xsl:stylesheet">
    <xsl:map>
      <xsl:apply-templates select="@meta:*"/>
    </xsl:map>
  </xsl:template>
  
  <xsl:template match="@meta:*">
    <xsl:map-entry key="local-name()" select="string(.)"/>
  </xsl:template>
  
</xsl:stylesheet>
