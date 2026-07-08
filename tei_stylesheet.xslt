<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei">
    
    <xsl:output method="html" encoding="UTF-8" indent="yes"/>
    
    <!-- Root Template -->
    <xsl:template match="/">
        <html lang="en">
            <head>
                <meta charset="UTF-8"/>
                <title>
                    <xsl:value-of select="//tei:titleStmt/tei:title"/>
                </title>
                <style>
                    @page {
                        size: A4;
                        margin: 20mm 15mm;
                        background-color: #fdfbf7;
                    }
                    body {
                        font-family: 'Garamond', 'Georgia', serif;
                        color: #2b2b2b;
                        line-height: 1.5;
                        margin: 0;
                        padding: 0;
                        background-color: #fdfbf7;
                    }
                    *, *::before, *::after {
                        box-sizing: border-box;
                    }
                    .header-container {
                        border-bottom: 2px solid #8b0000;
                        padding-bottom: 15px;
                        margin-bottom: 30px;
                    }
                    h1 {
                        color: #8b0000;
                        font-size: 20pt;
                        margin: 0 0 5px 0;
                        text-align: center;
                    }
                    .meta-info {
                        text-align: center;
                        font-size: 10pt;
                        color: #555;
                        font-style: italic;
                    }
                    .section-title {
                        color: #8b0000;
                        font-size: 12pt;
                        text-transform: uppercase;
                        letter-spacing: 1px;
                        border-bottom: 1px solid #ddd;
                        padding-bottom: 3px;
                        margin-top: 25px;
                        margin-bottom: 12px;
                        page-break-after: avoid;
                    }
                    table {
                        width: 100%;
                        border-collapse: collapse;
                        margin-bottom: 20px;
                        font-size: 9.5pt;
                        page-break-inside: auto;
                    }
                    tr {
                        page-break-inside: avoid;
                        page-break-after: auto;
                    }
                    th {
                        background-color: #8b0000;
                        color: white;
                        font-weight: bold;
                        text-align: left;
                        padding: 8px 10px;
                        border: 1px solid #8b0000;
                    }
                    td {
                        padding: 6px 10px;
                        border: 1px solid #e0dad0;
                        vertical-align: top;
                    }
                    tr:nth-child(even) {
                        background-color: #f5f0e6;
                    }
                    .text-rendering {
                        background-color: #fff;
                        border: 1px solid #e0dad0;
                        padding: 25px;
                        margin-top: 20px;
                        border-radius: 4px;
                        box-shadow: 0 1px 3px rgba(0,0,0,0.05);
                    }
                    .title-page-box {
                        border: 1px dashed #8b0000;
                        padding: 15px;
                        margin-bottom: 20px;
                        background-color: #fffcf8;
                        page-break-inside: avoid;
                    }
                    .tei-p {
                        margin-bottom: 1em;
                        text-align: justify;
                    }
                    .tei-lb {
                        display: block;
                    }
                    /* Dynamic Rendition Styles matching the TEI tagsDecl */
                    .rend-center { text-align: center; }
                    .rend-justify { text-align: justify; }
                    .rend-red { color: #b30000; }
                    .rend-green { color: #006633; }
                    .rend-black { color: #000000; }
                    .rend-size-max { font-size: 18pt; font-weight: bold; }
                    .rend-size-med { font-size: 12pt; font-weight: bold; }
                    .rend-size-min { font-size: 10pt; }
                    .rend-f-garamond { font-family: 'Garamond', serif; }
                    .rend-f-fraktur { font-family: 'Courier New', monospace; font-style: italic; font-weight: bold; }
                    .rend-f-boeklin { font-family: 'Georgia', serif; font-variant: small-caps; }
                    .rend-f-bodoni { font-family: 'Times New Roman', serif; letter-spacing: 0.5px; }
                    
                    .page-num {
                        text-align: center;
                        color: #b30000;
                        font-weight: bold;
                        margin: 15px 0;
                        font-size: 9pt;
                        page-break-after: avoid;
                    }
                </style>
            </head>
            <body>
                <div class="header-container">
                    <h1><xsl:value-of select="//tei:titleStmt/tei:title"/></h1>
                    <div class="meta-info">
                        Author: <xsl:value-of select="//tei:titleStmt/tei:author"/> | 
                        Encoded by: <xsl:value-of select="//tei:titleStmt/tei:respStmt/tei:name"/> (<xsl:value-of select="//tei:titleStmt/tei:editionStmt/tei:edition"/>)
                    </div>
                </div>

                <!-- Section 1: Bibliography Metadata -->
                <div class="section-title">Source Bibliography (Witnesses)</div>
                <table>
                    <thead>
                        <tr>
                            <th style="width: 8%;">ID</th>
                            <th style="width: 8%;">Lang</th>
                            <th style="width: 30%;">Title</th>
                            <th style="width: 25%;">Publisher &amp; Place</th>
                            <th style="width: 10%;">Date</th>
                            <th style="width: 19%;">ISBN / Identifiers</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each select="//tei:sourceDesc/tei:listBibl/tei:bibl">
                            <tr>
                                <td><strong><xsl:value-of select="@xml:id"/></strong></td>
                                <<td><xsl:value-of select="@xml:lang"/></td>
                                <td><em><xsl:value-of select="tei:title"/></em></td>
                                <td>
                                    <xsl:value-of select="tei:publisher/@ref"/> 
                                    <xsl:if select="tei:pubPlace">
                                        (<xsl:value-of select="tei:pubPlace/@ref"/>)
                                    </xsl:if>
                                </td>
                                <td><xsl:value-of select="tei:date"/></td>
                                <td>
                                    <span style="font-size:8.5pt;">
                                        ISBN: <xsl:value-of select="tei:idno[@type='ISBN']"/>
                                    </span>
                                </td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>

                <!-- Section 2: Named Entities Index -->
                <div class="section-title">Named Entities Index (Persons &amp; Characters)</div>
                <table>
                    <thead>
                        <tr>
                            <th style="width: 15%;">ID</th>
                            <th style="width: 25%;">Name</th>
                            <th style="width: 60%;">Description / Biographical Note</th>
                        </tr>
                    </thead>
                    <tbody>
                        <xsl:for-each select="//tei:particDesc/tei:listPerson/tei:person">
                            <tr>
                                <td><code>#<xsl:value-of select="@xml:id"/></code></td>
                                <td><strong><xsl:value-of select="tei:persName[1]"/></strong></td>
                                <td><xsl:value-of select="tei:note"/></td>
                            </tr>
                        </xsl:for-each>
                    </tbody>
                </table>

                <!-- Section 3: Diplomatic Text Rendering -->
                <div class="section-title">Document Text &amp; Front Matter</div>
                <div class="text-rendering">
                    <!-- Front Title Pages -->
                    <xsl:for-each select="//tei:front/tei:titlePage">
                        <div class="title-page-box">
                            <div style="text-align:right; font-size:8.5pt; color:#888; margin-bottom:10px;">
                                [Title Page Witness: <xsl:value-of select="@corresp"/> (<xsl:value-of select="@xml:lang"/>)]
                            </div>
                            <div class="rend-center">
                                <xsl:apply-templates select="*"/>
                            </div>
                        </div>
                    </xsl:for-each>

                    <!-- Body Text Content -->
                    <div style="margin-top: 30px;">
                        <xsl:apply-templates select="//tei:body/tei:div"/>
                    </div>
                </div>
            </body>
        </html>
    </xsl:template>

    <!-- Custom rules for elements that map directly into styled spans/blocks -->
    <xsl:template match="tei:docAuthor">
        <div class="rend-red rend-f-garamond rend-center rend-size-med" style="margin-bottom: 10px;">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="tei:docTitle">
        <div style="margin: 15px 0;"><xsl:apply-templates/></div>
    </xsl:template>

    <xsl:template match="tei:titlePart[@type='main']">
        <div class="rend-green rend-f-fraktur rend-size-max rend-center" style="line-height:1.2; margin-bottom:10px;">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="tei:titlePart[@type='sub']">
        <div class="rend-red rend-f-garamond rend-center rend-size-min" style="margin-bottom:10px;">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="tei:byline">
        <div class="rend-red rend-center rend-size-min" style="margin: 10px 0; font-style: italic;">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="tei:docImprint">
        <div class="rend-red rend-center rend-size-min" style="margin-top: 15px; font-weight: bold;">
            <xsl:apply-templates/>
        </div>
    </xsl:template>

    <xsl:template match="tei:p">
        <p class="tei-p">
            <xsl:choose>
                <xsl:when test="contains(@rendition, '#green') and contains(@rendition, '#justify')">
                    <xsl:attribute name="class">tei-p rend-green rend-justify rend-size-min rend-f-garamond</xsl:attribute>
                </xsl:when>
                <xsl:when test="contains(@rendition, '#red')">
                    <xsl:attribute name="class">tei-p rend-red rend-justify rend-size-min rend-f-garamond</xsl:attribute>
                </xsl:when>
                <xsl:when test="contains(@rendition, '#center')">
                    <xsl:attribute name="class">tei-p rend-center</xsl:attribute>
                </xsl:when>
            </xsl:choose>
            <xsl:apply-templates/>
        </p>
    </xsl:template>

    <xsl:template match="tei:pb">
        <div style="border-top: 1px dashed #b30000; margin: 20px 0; position: relative;">
            <span style="position: absolute; top: -10px; right: 10px; background: #fdfbf7; padding: 0 10px; font-size: 8pt; color: #b30000;">
                Page <xsl:value-of select="@n"/> (<xsl:value-of select="substring-after(@ed, '#')"/>)
            </span>
        </div>
    </xsl:template>

    <xsl:template match="tei:fw[@type='pageNum']">
        <div class="page-num">
            ~ <xsl:value-of select="tei:num"/> ~
        </div>
    </xsl:template>

    <xsl:template match="tei:title">
        <span class="rend-green rend-f-boeklin rend-size-med"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="tei:seg[@ana='#metanarration']">
        <span style="background-color: #fff5e6; border-left: 3px solid #d97706; padding-left: 5px; display: block; font-style: italic;">
            <xsl:apply-templates/>
        </span>
    </xsl:template>

    <xsl:template match="tei:persName | tei:objectName">
        <strong style="color: #444;"><xsl:apply-templates/></strong>
    </xsl:template>

    <xsl:template match="tei:lb">
        <br/>
    </xsl:template>

    <xsl:template match="tei:figure | tei:figDesc | tei:graphic">
        <!-- Rendered smoothly without missing resources -->
        <div style="font-size: 8.5pt; color: #666; font-style: italic; margin: 5px 0; text-align: center;">
            <xsl:value-of select="tei:figDesc"/> <xsl:value-of select="tei:ab"/>
        </div>
    </xsl:template>

</xsl:stylesheet>