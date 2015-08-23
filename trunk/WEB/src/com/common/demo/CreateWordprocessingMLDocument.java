package com.common.demo;

import java.io.File;    
import java.io.FileInputStream;
import java.math.BigInteger;    
import java.util.Properties;

import org.docx4j.Docx4jProperties;
import org.docx4j.XmlUtils;
import org.docx4j.customxml.ObjectFactory;    
import org.docx4j.model.structure.PageDimensions;
import org.docx4j.model.structure.PageSizePaper;
import org.docx4j.openpackaging.packages.WordprocessingMLPackage;    
import org.docx4j.openpackaging.parts.Part;
import org.docx4j.openpackaging.parts.WordprocessingML.AltChunkType;
import org.docx4j.openpackaging.parts.WordprocessingML.MainDocumentPart;
import org.docx4j.openpackaging.parts.relationships.Namespaces;
import org.docx4j.openpackaging.parts.relationships.RelationshipsPart;
import org.docx4j.openpackaging.parts.relationships.RelationshipsPart.AddPartBehaviour;
import org.docx4j.openpackaging.exceptions.InvalidFormatException;    
import org.docx4j.openpackaging.io.SaveToZipFile;    
import org.docx4j.org.xhtmlrenderer.css.value.PageSize;
import org.docx4j.relationships.Relationship;
import org.docx4j.wml.Br;
import org.docx4j.wml.P;
import org.docx4j.wml.PPr;
import org.docx4j.wml.STBrType;
import org.docx4j.wml.STPageOrientation;    
import org.docx4j.wml.SectPr;

import com.common.utils.HtmlToDoc;
import com.common.utils.ReadFromFile;
    
/**  
 * 创建ooxml文档  
 * @素馨花  
 * @version 1.0  
 */    
public class CreateWordprocessingMLDocument {    
    
	
	
	public  static P addPageBreak() {

        org.docx4j.wml.P p = new org.docx4j.wml.P();
        org.docx4j.wml.R r = new org.docx4j.wml.R();
        org.docx4j.wml.Br br = new org.docx4j.wml.Br();
        br.setType(STBrType.PAGE);

        r.getContent().add(br);
        p.getContent().add(r);
        
        return p;
    }	
		
    public static void main(String[] args) throws Exception {    
            
        System.out.println( "Creating package..");    
        //创建文档处理对象
        
//		Properties properties = Docx4jProperties.getProperties();
//        properties.setProperty("docx4j.PageOrientationLandscape", "true");        
//        properties.setProperty("docx4j.PageSize", "A4");    
//   
//		String papersize= Docx4jProperties.getProperties().getProperty("docx4j.PageSize", "A4");
//		String landscapeString = Docx4jProperties.getProperties().getProperty("docx4j.PageOrientationLandscape", "false");
//		boolean default_landscape= Boolean.parseBoolean(landscapeString);

        
        WordprocessingMLPackage wmlDestPkg = WordprocessingMLPackage.createPackage();
        
        MainDocumentPart main = wmlDestPkg.getMainDocumentPart();
        main.addAltChunk(AltChunkType.WordprocessingML, new FileInputStream("c:\\YQ\\out.docx") );
        
//        P page_break = addPageBreak();
//        main.addObject(page_break);
        

        org.docx4j.wml.ObjectFactory factory = new org.docx4j.wml.ObjectFactory();

        SectPr sectionLandscape = factory.createSectPr();
        
        //dieser Wert werden als referenz auf das Format Benedict
        String rsidR = sectionLandscape.getRsidR();
        
        SectPr sectionPortrait = factory.createSectPr();
        sectionPortrait.setRsidR(rsidR);
        sectionPortrait.setRsidSect(rsidR);    
                
        org.docx4j.wml.SectPr.PgSz landscape = new org.docx4j.wml.SectPr.PgSz();
        landscape.setOrient(STPageOrientation.LANDSCAPE);

        landscape.setH(BigInteger.valueOf(11906));
        landscape.setW(BigInteger.valueOf(16383));
        

        org.docx4j.wml.SectPr.PgSz portrait = new org.docx4j.wml.SectPr.PgSz();
        portrait.setOrient(STPageOrientation.PORTRAIT);
        portrait.setH(BigInteger.valueOf(16383));
        portrait.setW(BigInteger.valueOf(11906));   
        
        sectionLandscape.setPgSz(landscape);
        sectionPortrait.setPgSz(portrait);        
        
        P p1 = factory.createP();
        PPr pPr = factory.createPPr();
        pPr.setSectPr(sectionPortrait);    
        p1.setRsidR(rsidR);
        p1.setRsidRDefault(rsidR);
        p1.setPPr(pPr);		

        
        main.addObject(p1);  
        
        main.addObject(sectionLandscape); 	 

        main.addAltChunk(AltChunkType.WordprocessingML, new FileInputStream("c:\\YQ\\out-table.docx") );
        System.out.println( ".. done!");    

        // Now save it     
        wmlDestPkg.save(new java.io.File("c:\\YQ\\bolds.docx") );    
            
        System.out.println("Done.");    
        
        
//		byte[] content = ReadFromFile.getBytes("c:\\YQ\\gzsc.html");
//		HtmlToDoc.doHtmlToDoc(content, "c:\\YQ\\test.docx");
                    
    }    
    
    
    /** 
     * 功能描述：获取文字信息 
     * @param content  文字信息 
     * @return  返回值：返回值指定样式的信息 
     * @author myclover 
     */  
    public static String getContentInfo(String content){  
        StringBuffer sb = new StringBuffer();  
        sb.append("<w:p xmlns:w=\"http://schemas.openxmlformats.org/wordprocessingml/2006/main\" >");  
        sb.append("<w:pPr><w:spacing w:line=\"360\" w:lineRule=\"auto\"/><w:ind w:firstLineChars=\"200\" w:firstLine=\"480\"/>");  
        sb.append("<w:rPr><w:rFonts w:asciiTheme=\"minorEastAsia\" w:hAnsiTheme=\"minorEastAsia\"/>");  
        sb.append("<w:sz w:val=\"24\"/><w:szCs w:val=\"24\"/></w:rPr></w:pPr><w:r w:rsidRPr=\"00792470\"><w:rPr>");  
        sb.append("<w:rFonts w:asciiTheme=\"minorEastAsia\" w:hAnsiTheme=\"minorEastAsia\" w:hint=\"eastAsia\"/>");  
        sb.append("<w:sz w:val=\"24\"/><w:szCs w:val=\"24\"/></w:rPr><w:t>");  
        sb.append(content);  
        sb.append("</w:t></w:r></w:p>");  
        return sb.toString();  
    }      
    
        
}    