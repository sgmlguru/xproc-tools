<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet pre_0:bar-param="bar-value"
    pre_0:test-param="test-value-at-group"
    exclude-result-prefixes="xs xd"
    version="2.0"
    xmlns:pre_0="http://www.corbas.co.uk/ns/transforms/meta"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:xd="http://www.oxygenxml.com/ns/doc/xsl">
    <!-- test stylesheet for use with threaded-xslt.xpl -->
    <xsl:param name="bar-param">bar-param-default</xsl:param>
    <xsl:param name="test-param">test-param-default</xsl:param>
    <xsl:template match="@*|node()">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
        </xsl:copy>
    </xsl:template>
    <xsl:template match="/*">
        <xsl:copy>
            <xsl:apply-templates select="@*|node()"/>
            <test-01-done bar-param="{$bar-param}"
                test-param="{$test-param}"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>