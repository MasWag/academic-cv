<?xml version="1.0" encoding="UTF-8"?>
<!--
   DBLP2SATySFi.xsl
   Copyright (C) 2018 Masaki Waga

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software Foundation,
   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301  USA

    USAGE
      saxon -xslt:fromRaw.xsl MasakiWaga.raw.xml
    NOTE
      I tested this xslt code using saxson
-->
<xsl:stylesheet version="1.0"
  xmlns:spaceex="http://www-verimag.imag.fr/xml-namespaces/sspaceex"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:output method="text" encoding="UTF-8" indent="no"/>

<xsl:template match="/dblpperson">
  let bibliography = [
    <xsl:apply-templates select="./r" />
  ]
</xsl:template>
<xsl:template match="r">
  <xsl:copy>
    <xsl:apply-templates select="inproceedings[not(contains(@publtype, 'informal'))]" />
    <xsl:apply-templates select='article[not(contains(@publtype, "informal"))]' />
  </xsl:copy>
</xsl:template>

<xsl:template match="inproceedings">
  (InProceedings(|
    author = {|<xsl:apply-templates select="./author" />|};
    title = {<xsl:value-of select="normalize-space(./title)" />};
    booktitle = {<xsl:value-of select="normalize-space(./booktitle)" />};
    series = None; <!-- TODO: Perhaps this is available in crossref -->
    volume = None; <!-- TODO: Perhaps this is available in crossref -->
    number = None; <!-- TODO: Perhaps this is available in crossref -->
    pages = (<xsl:value-of select="translate(normalize-space(./pages),'-',',')" />);
    year = <xsl:value-of select="normalize-space(./year)" />;
  |));
</xsl:template>
<xsl:template match="article">
  (Article(|
    author = {|<xsl:apply-templates select="./author" />|};
    title = {<xsl:value-of select="normalize-space(./title)" />};
    journal = {<xsl:value-of select="normalize-space(./journal)" />};
    volume = <xsl:if test="./volume">Some(<xsl:value-of select="normalize-space(./volume)" />)</xsl:if><xsl:if test="not(./volume)">None</xsl:if>;
    number = <xsl:if test="./number">Some({<xsl:value-of select="normalize-space(./number)" />})</xsl:if><xsl:if test="not(./number)">None</xsl:if>;
    pages = (<xsl:value-of select="translate(normalize-space(./pages),'-',',')" /><xsl:if test="not(./pages)">0,0</xsl:if>);
    year = <xsl:value-of select="normalize-space(./year)" />;
  |));
</xsl:template>
<xsl:template match="author">
  <xsl:apply-templates />
  <xsl:if test="position()!=last()">, </xsl:if>
</xsl:template>
<xsl:template match="editor">
  <xsl:apply-templates />
  <xsl:if test="position()!=last()">, </xsl:if>
</xsl:template>

</xsl:stylesheet>
