package com.common.utils;

import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;

import javax.xml.bind.JAXBException;
 
import org.apache.poi.poifs.filesystem.DirectoryEntry;
import org.apache.poi.poifs.filesystem.DocumentEntry;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.docx4j.jaxb.Context;
import org.docx4j.openpackaging.contenttype.ContentType;
import org.docx4j.openpackaging.exceptions.Docx4JException;
import org.docx4j.openpackaging.exceptions.InvalidFormatException;
import org.docx4j.openpackaging.packages.WordprocessingMLPackage;
import org.docx4j.openpackaging.parts.PartName;
import org.docx4j.openpackaging.parts.WordprocessingML.AlternativeFormatInputPart;
import org.docx4j.relationships.Relationship;
import org.docx4j.wml.CTAltChunk;
/**
 * 将html文档转为doc
 * @author soildwang
 *
 */
public class HtmlToDoc {
	
	
	/**
	 * @param args
	 */
	public static Boolean doHtmlToDoc(byte[] content, String outFile) {
		// TODO Auto-generated method stub
		
		if (content == null) {
			return false;
		}
		
		WordprocessingMLPackage wordMLPackage;

		try {
						
//			content = ReadFromFile.getBytes(inFile);
			
			wordMLPackage = WordprocessingMLPackage.createPackage();

			
			AlternativeFormatInputPart afiPart = new AlternativeFormatInputPart(new PartName("/hw.html"));
	
			afiPart.setBinaryData(content);
	
			afiPart.setContentType(new ContentType("text/html"));
	
			Relationship altChunkRel = wordMLPackage.getMainDocumentPart().addTargetPart(afiPart);
	
			// .. the bit in document body
	
			CTAltChunk ac = Context.getWmlObjectFactory().createCTAltChunk();
	
			ac.setId(altChunkRel.getId() );
	
			wordMLPackage.getMainDocumentPart().addObject(ac);
//			wordMLPackage.getMainDocumentPart().addObject(org.docx4j.XmlUtils.unmarshalString(String.valueOf(ac)));  
			// .. content type
	
			wordMLPackage.getContentTypeManager().addDefaultContentType("html", "text/html");
			wordMLPackage.save(new java.io.File(outFile));
			return true;
		} catch (InvalidFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Docx4JException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			
		}
		
		return false;
	}	
	
	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		byte[] content = ReadFromFile.getBytes("c:\\temp\\1.doc");
		HtmlToDoc.doHtmlToDoc(content, "c:\\temp\\1.doc");
	}
}