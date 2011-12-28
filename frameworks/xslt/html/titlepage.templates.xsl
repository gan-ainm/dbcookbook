<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:d="http://docbook.org/ns/docbook"
  xmlns:xlink="http://www.w3.org/1999/xlink"
  xmlns="http://www.w3.org/1999/xhtml"
  exclude-result-prefixes="d xlink">
  
  
  <xsl:template name="book.titlepage.recto">
    <xsl:apply-templates mode="book.titlepage.recto.auto.mode"
      select="(title|bookinfo/title|info/title)[1]"/>
    <xsl:apply-templates mode="book.titlepage.recto.auto.mode"
      select="(subtitle|bookinfo/subtitle|info/subtitle)[1]"/>

    <xsl:apply-templates mode="book.titlepage.recto.auto.mode"
      select="(info/author|bookinfo/author)[1]"/>
    <xsl:apply-templates mode="book.titlepage.recto.auto.mode"
      select="(info/pubdate|bookinfo/pubdate)[1]"/>
    <xsl:apply-templates mode="book.titlepage.recto.auto.mode"
      select="(info/releaseinfo|bookinfo/releaseinfo)[1]"/>
    <xsl:apply-templates mode="book.titlepage.recto.auto.mode"
      select="(info/legalnotice|bookinfo/legalnotice)[1]"/>
    <xsl:apply-templates mode="book.titlepage.recto.auto.mode"
      select="(info/cover|bookinfo/cover)[1]"/>
    <xsl:apply-templates mode="book.titlepage.recto.auto.mode"
      select="(info/revhistory|bookinfo/revhistory)[1]"/>
    <xsl:apply-templates mode="book.titlepage.recto.auto.mode"
      select="(info/abstract|bookinfo/abstract)[1]"/>
    <!--<xsl:apply-templates mode="book.titlepage.recto.auto.mode"
      select="(info/annotation[@xml:id='draft']|bookinfo/annotation[@xml:id='draft'])[1]"/>-->
  </xsl:template>
  
  <xsl:template match="cover" mode="book.titlepage.recto.auto.mode">
    <xsl:apply-templates mode="book.titlepage.recto.auto.mode"/>
  </xsl:template>
  <xsl:template match="note" mode="book.titlepage.recto.auto.mode">
    <div class="note admonition">
      <xsl:apply-templates mode="book.titlepage.recto.auto.mode"/>
    </div>
  </xsl:template>
  <xsl:template match="note/*" mode="book.titlepage.recto.auto.mode">
    <!-- Fallback to default mode -->
    <xsl:apply-templates select="."/>
  </xsl:template>
  <xsl:template match="note/title" mode="book.titlepage.recto.auto.mode"
    priority="1">
    <h3>
      <xsl:apply-templates/>
    </h3>    
  </xsl:template>
    
  <xsl:template match="othercredit" mode="book.titlepage.recto.auto.mode"/>
  
  <!-- Chapter Titlepages -->
  <xsl:template name="chapter.titlepage.recto">
    <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode"
      select="(title|chapterinfo/title|info/title)[1]"/>
    <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode"
      select="(subtitle|chapterinfo/subtitle|info/subtitle)[1]"/>
    
    <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" 
      select="(info/authorgroup|chapterinfo/authorgroup)[1]"/>
    <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" 
      select="(info/author|chapterinfo/author)[1]"/>
    <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" 
      select="(info/releaseinfo|chapterinfo/releaseinfo)[1]"/>
    <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" 
      select="(info/abstract|chapterinfo/abstract)[1]"/>
    <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" 
      select="(info/revhistory|chapterinfo/revhistory)[1]"/>
    <xsl:apply-templates mode="chapter.titlepage.recto.auto.mode" 
      select="(info/biblioid|chapterinfo/biblioid)[1]"/>
  </xsl:template>
  
  <xsl:template match="biblioid[@class='other' and @otherclass='ticket']" 
    mode="chapter.titlepage.recto.auto.mode">
    <xsl:variable name="ticketnr" select="normalize-space(.)"/>
    <div class="ticket">
      <xsl:value-of select="concat('See also Ticket#', $ticketnr, ': ')"/>
      <a href="{concat($ticket.url, $ticketnr, '/')}" title="Ticket#{$ticketnr}">
        <xsl:value-of select="concat($ticket.url, $ticketnr, '/')"/>
      </a>
    </div>
  </xsl:template>  
    
</xsl:stylesheet>