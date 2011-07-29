<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
   <xsl:output method="xml" indent="yes" />

   <xsl:param name="suitename" />
   
   <xsl:variable name="cutterCount" select="count(//test)"/>
   <xsl:variable name="cutterFailureCount" select="count(//status[.='failure'])"/>  

   <xsl:template match="/">
      <testsuites>
         <xsl:attribute name="errors">0</xsl:attribute>
         <xsl:attribute name="failures">
          <xsl:value-of select="$cutterFailureCount"/>
         </xsl:attribute>
         <xsl:attribute name="tests">
          <xsl:value-of select="$cutterCount"/>
         </xsl:attribute>
         <xsl:attribute name="name">
            <xsl:value-of select="$suitename" />
         </xsl:attribute>
         <xsl:apply-templates />
      </testsuites>
   </xsl:template>
   
  <xsl:template match="//result[status='success']">
    <testcase>
       <xsl:attribute name="classname">
          <xsl:value-of select="test-case/name" />
       </xsl:attribute>
       <xsl:attribute name="name">
          <xsl:value-of select="test/name" />
       </xsl:attribute>
       <xsl:attribute name="time">
          <xsl:value-of select="elapsed" />
       </xsl:attribute>
       <xsl:attribute name="timestamp">
          <xsl:value-of select="start-time" />
       </xsl:attribute>
    </testcase>
  </xsl:template>
  <xsl:template match="//result[status='failure']">
    <testcase>
        <xsl:attribute name="classname">
          <xsl:value-of select="test-case/name" />
       </xsl:attribute>
       <xsl:attribute name="name">
          <xsl:value-of select="test/name" />
       </xsl:attribute>
       <xsl:attribute name="time">
          <xsl:value-of select="elapsed" />
       </xsl:attribute>
       <xsl:attribute name="timestamp">
          <xsl:value-of select="start-time" />
       </xsl:attribute>
       <failure>
         <xsl:attribute name="message">
            <xsl:value-of select="backtrace/entry/info" />
         </xsl:attribute>
         <xsl:attribute name="type">Failure</xsl:attribute>          
         File: <xsl:value-of select="backtrace/entry/file" />
         Line: <xsl:value-of select="backtrace/entry/line" />
       </failure>
    </testcase>
  </xsl:template>
 
  <xsl:template match="text()|@*" />
  
</xsl:stylesheet>
