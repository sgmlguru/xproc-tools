<?xml version="1.0" encoding="UTF-8"?>
<p:declare-step
    xmlns:p="http://www.w3.org/ns/xproc"
    xmlns:sgproc="http://www.sgmlguru.org/ns/xproc/steps"
    xmlns:c="http://www.w3.org/ns/xproc-step"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    type="sgproc:recursive-directory-list"
    name="recursive-directory-list"
    version="3.0">
    
    <p:documentation xmlns="http://www.w3.org/1999/xhtml">
        <p>Recursively explore directory listings. The include and exclude filters are only applied
            to file names and not to directories. The filters are implemented as regular expressions
            not glob patterns. This seems more useful than the standard approach. We've implemented
            this by handling the pattern matches in xslt rather than in the
            <code>p:directory-list</code> step. The patterns are not required to match the whole
            path name.</p>
    </p:documentation>
    
    
    <p:output port="result" serialization="map{'indent': true()}">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <p>The result of the step is a <code>c:directory</code> element as defined for the
                <code>p:directory-list</code> step. However, all child directories are processed
                and expanded as well.</p>
        </p:documentation>
    </p:output>
    
    <p:option name="path" required="true">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <p>The path option defines the path to be searched.</p>
        </p:documentation>
    </p:option>
    
    <p:option name="include-filter" as="xs:string*" required="false">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <p>The <code>include-filter</code> option allows an option <em>regular expression</em>
                to be applied to either the file name or path name (depending on the value of
                <code>match-path</code> option). If the the match is successful, the file is
                retained unless excluded by the <code>exclude-filter</code> option.</p>
            <p>Directory names are not filtered and are always processed.</p>
        </p:documentation>
    </p:option>
    
    <p:option name="exclude-filter" as="xs:string*" required="false">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <p>The <code>exclude-filter</code> option allows an option <em>regular expression</em>
                to be applied to either the file name or path name (depending on the value of
                <code>match-path</code> option). If the the match is successful, the file is
                excluded from the results. The <code>exclude-filter</code> is applied after the
                <code>include-filter</code></p>
            <p>Directory names are not filtered and are always processed.</p>
        </p:documentation>
    </p:option>
    
    <!-- NOTE: REMOVED IN 3.0 -->
    <!--<p:option name="match-path" select="'false'">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <p>The <code>match-path</code> option determines whether or not the
                <code>include-filter</code> and <code>exclude-filter</code> options should apply
                to the whole path or just the file name. If set to <strong>true</strong> (case is
                insignificant) the file name will be combined with the path before the regular
                expressions are applied. If set to any other value then only the file name is
                tested.</p>
        </p:documentation>
    </p:option>-->
    
    <p:option name="depth" select="'unbounded'">
        <p:documentation xmlns="http://www.w3.org/1999/xhtml">
            <p>The <code>depth</code> option allows the depth of recursion to be restricted. The
                depth counter is decremented by one for each recursion. If it ever drops to zero,
                recursion will stop. The default value is <strong>-1</strong> so recursion will
                never stop. At least one directory listing level will always be generated</p>
        </p:documentation>
    </p:option>
    
    <p:option name="resolve" select="'false'">
        <p:documentation  xmlns="http://www.w3.org/1999/xhtml">
            <p>The <code>resolve</code> options sets whether or not the <code>uri</code>
                attribute is created for a directory or file. If set to <strong>true</strong> then
                an additional attribute — <code>uri</code> — is set. This attribute contains
                the resolved uri for any file or directory</p>
        </p:documentation>
    </p:option>
    
    <p:directory-list
        name="ls"
        path="{$path}"
        max-depth="{$depth}">
        <p:with-option name="exclude-filter" select="$exclude-filter"/>
        <p:with-option name="include-filter" select="$include-filter"/>
    </p:directory-list>
    
    <p:xslt name="uri" version="3.0">
        <p:with-input port="stylesheet">
            <xsl:stylesheet version="3.0"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:c="http://www.w3.org/ns/xproc-step">
                
                <xsl:output indent="true"/>
                
                <xsl:template match="/">
                    <xsl:apply-templates select="node()"/>
                </xsl:template>
                
                <xsl:template match="node() | @*">
                    <xsl:copy>
                        <xsl:apply-templates select="node() | @*"/>
                    </xsl:copy>
                </xsl:template>
                
                <xsl:template match="c:file">
                    <xsl:copy>
                        <xsl:attribute
                            name="uri"
                            select="
                            ancestor-or-self::*/@xml:base => string-join()
                            "/>
                        <xsl:apply-templates select="node() | @*"/>
                    </xsl:copy>
                </xsl:template>
            </xsl:stylesheet>
        </p:with-input>
    </p:xslt>
    
</p:declare-step>