<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" 
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei">
    
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <xsl:template match="/">
        <html lang="en">
            <head>
                <meta charset="UTF-8"/>
                <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
                <title>
                    <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/>
                </title>
                <link rel="stylesheet" href="styles.css"/>
            </head>
            <body>
                <div class="container">
                    <header>
                        <h1><xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:title"/></h1>
                    </header>
                    
                    <!-- 1. Document Metadata and Project Description Section -->
                    <h2>Document Metadata and Project Description</h2>
                    <div class="metadata-section">
                        <div class="card">
                            <h4>Digital Edition Statement</h4>
                            <p><strong>Edition:</strong> <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:editionStmt/tei:edition"/></p>
                            <p><strong>Encoder:</strong> <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:respStmt/tei:name"/> (<xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:titleStmt/tei:respStmt/tei:resp"/>)</p>
                            <p>
                                <strong>Project Context:</strong> 
                                <xsl:for-each select="tei:TEI/tei:teiHeader/tei:encodingDesc/tei:projectDesc/tei:p/node()">
                                    <xsl:choose>
                                        <!-- Check if it is a name tag with a reference link -->
                                        <xsl:when test="self::tei:name[@ref or @sameAs]">
                                            <a href="{normalize-space(concat(@ref, @sameAs))}" target="_blank" class="project-link">
                                                <xsl:value-of select="."/>
                                            </a>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:copy-of select="."/>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:for-each>
                            </p>
                        </div>
                        
                        <!-- Taxonomy / Category Descriptions Card -->
                        <xsl:if test="tei:TEI/tei:teiHeader/tei:encodingDesc/tei:classDecl/tei:taxonomy/tei:category">
                            <div class="card">
                                <h4>Project Taxonomy &amp; Themes</h4>
                                <xsl:for-each select="tei:TEI/tei:teiHeader/tei:encodingDesc/tei:classDecl/tei:taxonomy/tei:category">
                                    <p>
                                        <strong>Theme (<xsl:value-of select="@xml:id"/>):</strong> 
                                        <xsl:value-of select="tei:catDesc"/>
                                    </p>
                                </xsl:for-each>
                            </div>
                        </xsl:if>
                        
                        <div class="card">
                            <h4>Distribution and Origin</h4>
                            <p><strong>Location:</strong> <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:address/tei:street"/>, <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:pubPlace"/></p>
                            <p><strong>Date / ISBN:</strong> <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:date"/> | <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:idno[@type='ISBN']"/></p>
                            <p><strong>Status:</strong> <xsl:value-of select="tei:TEI/tei:teiHeader/tei:fileDesc/tei:publicationStmt/tei:availability/tei:p"/></p>
                            <p><strong>Creation Info:</strong> <xsl:value-of select="tei:TEI/tei:teiHeader/tei:profileDesc/tei:creation"/></p>
                        </div>
                    </div>
                    
                    <!-- 2. Index of Entities and Authorities Section -->
                    <h2>Index of Entities and Authorities</h2>
                    
                    <h3>People Mentioned</h3>
                    <xsl:for-each select="tei:TEI/tei:teiHeader/tei:profileDesc/tei:particDesc/tei:listPerson/tei:person">
                        <div class="index-box">
                            <xsl:choose>
                                <xsl:when test="@sameAs">
                                    <a href="{@sameAs}" target="_blank" class="entity-link">
                                        <strong><xsl:value-of select="tei:persName"/></strong>
                                        <xsl:if test="tei:persName[@xml:lang='en']">
                                             (<xsl:value-of select="tei:persName[@xml:lang='en']"/>)
                                        </xsl:if>
                                    </a>
                                </xsl:when>
                                <xsl:otherwise>
                                    <strong><xsl:value-of select="tei:persName"/></strong>
                                </xsl:otherwise>
                            </xsl:choose>
                            <p><xsl:apply-templates select="tei:note"/></p>
                        </div>
                    </xsl:for-each>

                    <h3>Geographical Places</h3>
                    <xsl:for-each select="tei:TEI/tei:teiHeader/tei:profileDesc/tei:settingDesc/tei:listPlace/tei:place">
                        <div class="index-box">
                            <xsl:choose>
                                <xsl:when test="@sameAs">
                                    <a href="{@sameAs}" target="_blank" class="entity-link">
                                        <strong><xsl:value-of select="tei:placeName"/></strong>
                                    </a>
                                </xsl:when>
                                <xsl:otherwise>
                                    <strong><xsl:value-of select="tei:placeName"/></strong>
                                </xsl:otherwise>
                            </xsl:choose>
                        </div>
                    </xsl:for-each>

                    <h3>Classification Keywords</h3>
                    <div class="index-box">
                        <xsl:for-each select="tei:TEI/tei:teiHeader/tei:profileDesc/tei:textClass/tei:keywords/tei:term">
                            <span class="keyword-term-wrapper" style="margin-right: 15px; display: inline-block; padding: 5px 10px;">
                                <xsl:choose>
                                    <xsl:when test="@target">
                                        <a href="{@target}" target="_blank" class="keyword-link">
                                            # <xsl:value-of select="."/>
                                        </a>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        # <xsl:value-of select="."/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </span>
                        </xsl:for-each>
                    </div>
                    
                    <!-- 3. Main Document Text Body Section -->
                    <h2>Document Text Body</h2>
                    <div class="text-display">
                        <xsl:apply-templates select="tei:TEI/tei:text/tei:front/* | tei:TEI/tei:text/tei:body/*"/>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

    <!-- ===================================================================== -->
    <!--  INDEPENDENT TEMPLATES MAPPED TO TEI @RENDITION (WITH HASHTAG STRIP) -->
    <!-- ===================================================================== -->
    
    <!-- Template to look for and layout the Title Pages inside the Body text -->
    <xsl:template match="tei:titlePage">
        <div class="frontispiece-container">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <!-- Author block handler -->
    <xsl:template match="tei:docAuthor">
        <div class="author-block {translate(@rendition, '#', '')}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <!-- Document Title block wrapper -->
    <xsl:template match="tei:docTitle">
        <div class="title-block">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <!-- Specific internal title segments -->
    <xsl:template match="tei:titlePart">
        <xsl:choose>
            <xsl:when test="@type='main'">
                <span class="title-main {translate(@rendition, '#', '')}">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:when test="@type='sub'">
                <span class="title-sub {translate(@rendition, '#', '')}">
                    <xsl:apply-templates/>
                </span>
            </xsl:when>
            <xsl:otherwise>
                <span class="{translate(@rendition, '#', '')}">
                    <xsl:apply-templates/>
                </span>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <!-- Responsibility statements like translators/illustrators -->
    <xsl:template match="tei:respStmt">
        <div class="resp-block {translate(@rendition, '#', '')}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <!-- Publisher/Imprint metadata details at the bottom -->
    <xsl:template match="tei:docImprint">
        <div class="imprint-block {translate(@rendition, '#', '')}">
            <xsl:choose>
                <xsl:when test="tei:figure or .//tei:figure">
                    <xsl:apply-templates select="tei:publisher | tei:figure | tei:pubPlace | tei:date"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>

    <!-- Custom handler for publishers containing a logo figure to bypass transcriptions -->
    <xsl:template match="tei:publisher">
        <div class="publisher-wrapper {translate(@rendition, '#', '')}">
            <xsl:choose>
                <xsl:when test="tei:figure">
                    <xsl:apply-templates select="tei:figure"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>

    <!-- If a library stamp has an image, strictly render ONLY the image layout -->
    <xsl:template match="tei:note[@type='stamp'] | tei:ab[@type='stamp']">
        <div class="stamp-oval">
            <xsl:choose>
                <xsl:when test="tei:figure">
                    <xsl:apply-templates select="tei:figure"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:apply-templates/>
                </xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>

    <!-- Safe paragraph template: enables text-align: justify and applies rendition properties -->
    <xsl:template match="tei:p">
        <p class="paragraph-block {translate(@rendition, '#', '')}">
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <!-- Handle inline font/color shifts (<seg rendition="...">) safely -->
    <xsl:template match="tei:seg">
        <span class="{translate(@rendition, '#', '')}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- This template matches <title> elements that live inside a paragraph (<p>) -->
    <xsl:template match="tei:p/tei:title">
        <div class="body-inline-title {translate(@rendition, '#', '')}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <!-- Template rule ensuring any standalone <title> tags are always italicized -->
    <xsl:template match="tei:title">
        <i class="{translate(@rendition, '#', '')}">
            <xsl:apply-templates/>
        </i>
    </xsl:template>

    <!-- Handle line breaks cleanly across all frontispieces and text pages -->
    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>

    <!-- Handle byline blocks cleanly and apply their rendition properties -->
    <xsl:template match="tei:byline">
        <div class="byline-block {translate(@rendition, '#', '')}">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <!-- Handle inline highlighted spans (<hi>) inside text/subtitles safely -->
    <xsl:template match="tei:hi">
        <span class="{translate(@rendition, '#', '')}">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <!-- REVERSED ORNAMENTS TEMPLATE: Flower icon is now placed on the outside, leaf frames the inside number -->
    <xsl:template match="tei:fw[@type='pageNum']">
        <div class="page-number-ornament {translate(@rendition, '#', '')}">
            <span class="floral-icon left-side" style="color: #8b263e; margin-right: 8px; font-size: 1.2rem; vertical-align: middle;">✿❧</span>
            <span class="{translate(tei:num/@rendition, '#', '')}">
                <xsl:value-of select="tei:num"/>
            </span>
            <span class="floral-icon right-side" style="color: #8b263e; margin-left: 8px; font-size: 1.2rem; vertical-align: middle;">☙✿</span>
        </div>
    </xsl:template>

    <!-- Renders standard document illustrations containing a real graphic URL path -->
    <xsl:template match="tei:figure">
        <xsl:if test="tei:graphic">
            <div class="figure-wrapper {translate(@rendition, '#', '')}">
                <img src="{tei:graphic/@url}" alt="{tei:figDesc}" class="project-img" />
            </div>
        </xsl:if>
    </xsl:template>

    <!-- FIXED: Empty rule prevents the plain text "— Page [n] —" milestone markers from showing up -->
    <xsl:template match="tei:pb"/>
    
</xsl:stylesheet>