<?xml version="1.0" encoding="UTF-8"?>
<!-- 
   Purpose:
     Stylesheet to cleaned up XHTML
     This may be convenient to only maintain _one_ CSS file which can
     be applied for both XSLT 1.0 and XSLT 2.0 produced XHTML output.   
   
   Input:
     XHTML code created by the XSLT 1.0 DocBook stylesheets
   Output:
     XHTML code which (should) be identical as it would be created by
     the XSLT 2.0 stylesheets
-->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:exsl="http://exslt.org/common"
  xmlns:h="http://www.w3.org/1999/xhtml"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="exsl h">

  <xsl:import href="copy.xsl"/>
  <xsl:preserve-space elements="h:pre"/>
  <xsl:output method="xml" doctype-system="about:legacy-compat" 
    encoding="UTF-8" omit-xml-declaration="no" indent="yes"/>
  
  <xsl:include href="../html/piwik.xsl"/>
  
  <xsl:template match="h:body">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
      <xsl:call-template name="generate.piwik"/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="h:meta[@http-equiv='Content-Type']">
     <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
  </xsl:template>
  
  <!-- ================================================ -->
  <!-- Remove or otherwise leave out elements and attributes -->
  <xsl:template match="h:div">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="h:span[@class='emphasis']">
    <xsl:apply-templates/>
  </xsl:template>
  
  <xsl:template match="h:div/@xml:lang">
    <xsl:attribute name="lang">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </xsl:template>
  
  <xsl:template match="h:div[@class='revhistory']/h:table/@border">
    <xsl:attribute name="border">0</xsl:attribute>
  </xsl:template>
  
  <xsl:template match="@class">
    <xsl:choose>
      <xsl:when test="starts-with(., 'sgmltag')">
        <xsl:attribute name="class">
          <xsl:text>tag-</xsl:text>
          <xsl:value-of select="substring-after(., 'sgmltag-')"/>
        </xsl:attribute>
      </xsl:when>
      <xsl:when test=". = 'citetitle'"/>
      <xsl:when test=". = 'link'"/>
      <xsl:when test=". = 'listitem'"/>
      <xsl:when test=". = 'title'"/>
      <xsl:when test=". = 'subtitle'"/>
      <xsl:when test=". = 'xref'"/>
      <xsl:otherwise>
        <xsl:copy-of select="."/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>
  
  <xsl:template match="@xml:lang">
    <xsl:attribute name="lang">
      <xsl:value-of select="."/>
    </xsl:attribute>
  </xsl:template>
  <!-- Remove obsolete elements and attributes -->
  <xsl:template match="h:table/h:h1"/>
  <xsl:template match="/h:html/@version"/>
  <xsl:template match="h:br"/>
  <xsl:template match="h:div/@title"/>
  <xsl:template match="h:a/@title"/>
  <xsl:template match="h:a/@target"/>
  <xsl:template match="h:blockquote/@title"/>
  <xsl:template match="h:p/@title"/>
  <xsl:template match="h:p[@class='legalnotice-title']"/>

  <xsl:template match="h:ul/@class"/>
  
  <!-- Remove any id on headers as they are added to <section> -->
  <xsl:template match="h:h2[@class='title']/@id"/>
  <xsl:template match="h:h3[@class='title']/@id"/>
  <xsl:template match="h:h4[@class='title']/@id"/>
  <xsl:template match="h:h5[@class='title']/@id"/>
  <xsl:template match="h:h6[@class='title']/@id"/>
  
  <!-- Remove empty anchors -->
  <xsl:template match="h:a[. = '']"/>
  
  <!-- ================================================ -->
  <xsl:template name="create-article">    
    <article>
      <xsl:apply-templates select="@*"/>
      <header class="{@class}-titlepage">
        <xsl:apply-templates select="h:div[@class='titlepage']"/>        
      </header>
      <xsl:apply-templates select="*[not(self::h:div[@class='titlepage'])]"/>  
    </article>
  </xsl:template>
  
  <xsl:template name="create-section">
    <xsl:variable name="id" select="(.//h:h1|.//h:h2|.//h:h3|.//h:h4|.//h:h5|.//h:h6)[@class='title'][1]/@id"/>    
    <section class="section">
      <xsl:if test="string($id) != ''">
      <xsl:attribute name="id">
        <xsl:value-of select="$id"/>
      </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="@*"/>
      <div class="{@class}-titlepage">
        <xsl:apply-templates select="h:div[@class='titlepage']"/>        
      </div>
      <xsl:apply-templates select="*[not(self::h:div[@class='titlepage'])]"/>
    </section>
  </xsl:template>
  
  <xsl:template name="create-personname">
    <xsl:param name="class" select="@class"/>
    <div class="{$class}">
      <h3>
        <span class="personname">
          <xsl:for-each select="h:h3/h:span">
            <xsl:copy-of select="."/>
            <xsl:text> </xsl:text>
          </xsl:for-each>
        </span>
      </h3>
    </div>
  </xsl:template>  
  
  <xsl:template match="h:div[@class='abstract']|
                       h:div[contains(@class, 'note')]|
                       h:div[starts-with(@class, 'list-of-')]">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="h:div[@class='html5']">
    <xsl:copy-of select="."/>
  </xsl:template>
  
  <xsl:template match="h:div[@class='blockquote-title']">
    <h3><xsl:apply-templates/></h3>
  </xsl:template>
  
  <xsl:template match="h:div[@class='legalnotice']">
    <xsl:copy>
      <xsl:apply-templates select="@class|@xml:lang"/>
      <xsl:if test="h:a/@id">
        <xsl:apply-templates select="h:a/@id"/>
      </xsl:if>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="h:div[@class='sidebar']">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <header class="sidebar-titlepage">
        <xsl:apply-templates select="h:div[@class='titlepage']" />
      </header>
      <div class="sidebar-content">
        <xsl:apply-templates select="h:table" />
      </div>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="h:div[@class='sidebar-title']">
    <h3><xsl:apply-templates/></h3>
  </xsl:template>
  
  <!-- Main structures -->
  <xsl:template match="h:section">
    <xsl:variable name="id" select="(.//h:h1|.//h:h2|.//h:h3|.//h:h4|.//h:h5|.//h:h6)[@class='title'][1]/@id"/> 
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:if test="not(@id) and $id != ''">
        <xsl:attribute name="id"><xsl:value-of select="$id"/></xsl:attribute>
      </xsl:if>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>

  <xsl:template match="h:h3[ancestor::h:section[@class='chapter']]">
    <div class="chapter-titlepage">
      <h2><xsl:apply-templates/></h2>
    </div>
  </xsl:template>
  <xsl:template match="h:h3[ancestor::h:section[@class='preface']]">
    <div class="preface-titlepage">
      <h2><xsl:apply-templates/></h2>
    </div>
  </xsl:template>
  <xsl:template match="h:h2[ancestor::h:section[@class='section']]">
    <div class="section-titlepage">
      <h3><xsl:apply-templates/></h3>
    </div>
  </xsl:template>
  <xsl:template match="h:h3[ancestor::h:section[@class='section']]">
    <div class="section-titlepage">
      <h4><xsl:apply-templates/></h4>
    </div>
  </xsl:template>
  <xsl:template match="h:h4[ancestor::h:section[@class='section']]">
    <div class="section-titlepage">
      <h5><xsl:apply-templates/></h5>
    </div>
  </xsl:template>
  
  <xsl:template match="h:div[@class='appendix']">
    <xsl:call-template name="create-article"/>
  </xsl:template>
  <xsl:template match="h:div[@class='book']">
    <xsl:call-template name="create-article"/>
  </xsl:template>
  <xsl:template match="h:div[@class='chapter']">
    <xsl:call-template name="create-article"/>
  </xsl:template>
  <xsl:template match="h:section[@class='appendix']">
    <xsl:call-template name="create-article"/>
  </xsl:template>
  <xsl:template match="h:section[@class='chapter']">
    <xsl:call-template name="create-article"/>
  </xsl:template>
  <xsl:template match="h:section[@class='preface']">
    <xsl:call-template name="create-article"/>
  </xsl:template>
  <xsl:template match="h:div[@class='preface']">
    <xsl:call-template name="create-article"/>
  </xsl:template>
  <xsl:template match="h:div[@class='section']">
    <xsl:call-template name="create-section"/>
  </xsl:template>
  <xsl:template match="h:div[@class='titlepage']">
    <xsl:apply-templates/>
  </xsl:template>    
    
  <!-- TOCs -->
  <xsl:template match="h:div[@class='toc']">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="h:ul">
    <xsl:copy>
        <xsl:if test="ancestor::h:div[@class='toc' or starts-with(@class,'list-of-')]">
          <xsl:attribute name="class">toc</xsl:attribute>
        </xsl:if>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="h:div[@class='toc']/h:dl">
    <dl class="toc">
      <xsl:apply-templates/>
    </dl>
  </xsl:template>

  <xsl:template match="h:div[starts-with(@class, 'list-of-')]/h:dl">
    <dl class="toc">
      <xsl:apply-templates/>
    </dl>
  </xsl:template>  
  <xsl:template match="h:div[@class='toc-title']">
    <p><b><xsl:apply-templates/></b></p>
  </xsl:template>
  
  <!-- Block Structures -->
  <xsl:template name="create-div-wrapper">
    <xsl:param name="class" select="@class"/>
    <div class="{$class}-wrapper"><!-- id=node-id() -->
      <xsl:choose>
        <xsl:when test="h:a[. = ''] and not(@id)">
          <xsl:attribute name="id">
            <xsl:value-of select="h:a/@id"/>
          </xsl:attribute>
        </xsl:when>
        <xsl:otherwise>
          <xsl:apply-templates select="@*"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:apply-templates select="h:div[@class=concat($class, '-title')]"/>
      <xsl:apply-templates select="h:div[@class=concat($class,'-contents')]"/>
    </div>
  </xsl:template>
  <xsl:template match="h:div[@class='informaltable']">
    <xsl:call-template name="create-div-wrapper"/>
  </xsl:template>
  <xsl:template match="h:div[@class='example']">
    <xsl:call-template name="create-div-wrapper"/>
  </xsl:template>
  <xsl:template match="h:div[@class='figure']">
    <xsl:call-template name="create-div-wrapper"/>
  </xsl:template>
  <xsl:template match="h:div[@class='example-title']">
    <div class="title">
      <xsl:apply-templates/>
    </div>
  </xsl:template>  
  <xsl:template match="h:div[@class='example-contents']">
    <div class="example">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  <xsl:template match="h:div[@class='figure-title']">
    <div class="title">
      <xsl:apply-templates/>
    </div>
  </xsl:template>  
  <xsl:template match="h:div[@class='figure-contents']">
    <div class="figure">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  <xsl:template match="h:div[@class='table']">
    <figure class="table-wrapper">
      <xsl:if test="h:a/@id">
        <xsl:attribute name="id">
          <xsl:value-of select="h:a/@id"/>
        </xsl:attribute>
      </xsl:if>
      <xsl:apply-templates select="h:div[@class='table-title']"/>
      <xsl:apply-templates select="h:div[@class='table-contents']"/>
    </figure>
  </xsl:template>
  
  <xsl:template match="h:div[@class='table-title']">
    <div class="title">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  <xsl:template match="h:div[@class='table-contents']">
    <div class="table">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <xsl:template match="h:div[@class='mediaobject']">
    <div>
      <xsl:attribute name="class">
        <xsl:value-of select="@class"/>
        <xsl:if test="@align = 'center'"> centerimg</xsl:if>        
      </xsl:attribute>
      <xsl:copy-of select="@title"/>
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  
  <xsl:template match="h:div[@class='programlisting']|h:div[@class='screen']">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:choose>
        <xsl:when test="h:pre"><xsl:apply-templates/></xsl:when>
        <xsl:otherwise>
          <pre>
            <xsl:apply-templates select="@*[local-name()!='class']|node()"/>
          </pre>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="h:div[@class='itemizedlist' or
                             @class='variablelist' or 
                             @class='orderedlist']">
    <xsl:copy>
      <xsl:apply-templates select="@*|node()"/>
    </xsl:copy>
  </xsl:template>  
  <xsl:template match="h:div[@class='itemizedlist-title']">
    <div class="title">
      <xsl:apply-templates/>
    </div>
  </xsl:template>
  <xsl:template match="h:dt[h:a]">
    <xsl:copy>
      <xsl:attribute name="id"><xsl:value-of select="h:a/@id"/></xsl:attribute>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  
  <xsl:template match="h:div[@class='revhistory']">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  <!--<xsl:template match="h:div[@class='revhistory']/h:table[not(h:tbody)]">
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <tbody>
        <xsl:apply-templates/>
      </tbody>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="h:div[@class='revhistory']/h:table/h:tr[count(h:td)=3]">
    <xsl:message>h:tr[count(h:td)=3]</xsl:message>
    <xsl:copy>
      <xsl:attribute name="class">revision</xsl:attribute>
      <xsl:apply-templates select="@*"/>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>
  <xsl:template
    match="h:div[@class='revhistory']/h:table/h:tr[position()>1 and count(h:td)!=3]">
    <xsl:message>h:tr[count(h:td) &lt;> 3]</xsl:message>
    <xsl:copy>
      <xsl:apply-templates select="@*"/>
      <xsl:attribute name="class">revdescription</xsl:attribute>
      <xsl:apply-templates/>
    </xsl:copy>
  </xsl:template>-->
  <!-- -->
  <xsl:template match="h:p[h:span[@class='formalpara-title']]">
    <div class="formalpara">
      <p><xsl:apply-templates/></p>
    </div>
  </xsl:template>
  <xsl:template match="h:span[@class='formalpara-title']">
    <b><xsl:apply-templates/></b>
  </xsl:template>
  
  <!-- Remove the outer span for quotes -->
  <xsl:template match="h:span[@class='quote'][not(h:span[@class='quote'])]">
    <xsl:apply-templates/>
  </xsl:template>
  
  <!-- Authors and other -->
  <xsl:template match="h:div[@class='author']">
    <xsl:call-template name="create-personname"/>
  </xsl:template>
  <xsl:template match="h:div[@class='editor']">
    <xsl:call-template name="create-personname"/>
  </xsl:template>
  <xsl:template match="h:div[@class='othercredit']">
    <xsl:call-template name="create-personname"/>
  </xsl:template>
  
  
  <!-- Links -->
  <xsl:template match="h:a[@class]">
    <xsl:copy>
      <xsl:apply-templates select="@*[local-name() != 'class']"/>
      <xsl:apply-templates/>  
    </xsl:copy>
  </xsl:template>
  
</xsl:stylesheet>