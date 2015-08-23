package com.common.demo;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStream;

import org.docx4j.jaxb.Context;
import org.docx4j.openpackaging.contenttype.ContentType;
import org.docx4j.openpackaging.exceptions.Docx4JException;
import org.docx4j.openpackaging.exceptions.InvalidFormatException;
import org.docx4j.openpackaging.io.SaveToZipFile;
import org.docx4j.openpackaging.packages.WordprocessingMLPackage;
import org.docx4j.openpackaging.parts.PartName;
import org.docx4j.openpackaging.parts.WordprocessingML.AlternativeFormatInputPart;
import org.docx4j.relationships.Relationship;
import org.docx4j.wml.CTAltChunk;
import org.docx4j.wml.CTAltChunkPr;
import org.docx4j.convert.in.Doc;

import com.common.utils.ReadFromFile;
public class docx4jDemo {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		
		WordprocessingMLPackage wordMLPackage;
		byte[] content = null;
		try {
						
			content = ReadFromFile.getBytes("c:\\temp\\1.htm");
			
			wordMLPackage = WordprocessingMLPackage.createPackage();

			
			AlternativeFormatInputPart afiPart = new AlternativeFormatInputPart(new PartName("/hw.html"));
	
			afiPart.setBinaryData(content);
	
			afiPart.setContentType(new ContentType("text/html"));
	
			Relationship altChunkRel = wordMLPackage.getMainDocumentPart().addTargetPart(afiPart);
	
			// .. the bit in document body
	
			CTAltChunk ac = Context.getWmlObjectFactory().createCTAltChunk();
	
			ac.setId(altChunkRel.getId() );
	
			wordMLPackage.getMainDocumentPart().addObject(ac);
	
			// .. content type
	
			wordMLPackage.getContentTypeManager().addDefaultContentType("html", "text/html");
	
			wordMLPackage.save(new java.io.File( "c:\\temp\\test.doc"));
		} catch (InvalidFormatException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (Docx4JException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}


}
