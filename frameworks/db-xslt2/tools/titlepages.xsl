<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns:t="http://docbook.org/xslt/ns/template"
                xmlns:xxx="http://example.com/"
                version="2.0">

<xsl:namespace-alias stylesheet-prefix="xxx" result-prefix="xsl"/>

<xsl:output method="xml" encoding="utf-8" indent="yes"
	    omit-xml-declaration="yes"/>

<xsl:template match="/">
  <xxx:stylesheet version="2.0" exclude-result-prefixes="db t">
    <xsl:namespace name="t" select="'http://docbook.org/xslt/ns/template'"/>
    <xsl:namespace name="db" select="'http://docbook.org/ns/docbook'"/>

    <xsl:text>&#10;</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:comment> * This file is generated automatically. Do not edit this file. </xsl:comment>
    <xsl:text>&#10;</xsl:text>
    <xsl:comment> ******************************************************************** </xsl:comment>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:comment> This file is part of the XSL DocBook Stylesheet distribution. </xsl:comment>
    <xsl:text>&#10;</xsl:text>
    <xsl:comment> See ../README or http://docbook.sf.net/release/xsl/current/ for </xsl:comment>
    <xsl:text>&#10;</xsl:text>
    <xsl:comment> copyright and other information. </xsl:comment>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:comment> ******************************************************************** </xsl:comment>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>&#10;</xsl:text>

    <xxx:variable name="titlepages.data" as="element(t:titlepages)">
      <xsl:copy-of select="/"/>
    </xxx:variable>

    <xsl:text>&#10;</xsl:text>
    <xsl:text>&#10;</xsl:text>

    <xxx:variable name="titlepages">
      <xxx:call-template name="t:user-titlepage-templates"/>
      <xxx:sequence select="$titlepages.data/*"/>
    </xxx:variable>

    <xsl:text>&#10;</xsl:text>
    <xsl:text>&#10;</xsl:text>
    <xsl:comment> ============================================================ </xsl:comment>
    <xsl:text>&#10;</xsl:text>
    <xsl:text>&#10;</xsl:text>

    <doc:template name="t:user-titlepage-templates"
                  xmlns:doc="http://nwalsh.com/xsl/documentation/1.0"
                  xmlns="http://docbook.org/ns/docbook">
      <refpurpose>Hook for user defined titlepage templates</refpurpose>

      <refdescription>
        <para>This template is a hook for customizers. Any titlepage templates
        defined in this template will be used in favor of the
        default titlepage templates.</para>
      </refdescription>

      <refreturn>
        <para>Any user-defined titepage templates.</para>
      </refreturn>
    </doc:template>

    <xxx:template name="t:user-titlepage-templates">
      <xsl:comment> nop </xsl:comment>
    </xxx:template>
  </xxx:stylesheet>
</xsl:template>

</xsl:stylesheet>
