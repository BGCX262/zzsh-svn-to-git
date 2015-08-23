package com.common.utils;

import java.io.FileInputStream;
import java.math.BigInteger;

import org.docx4j.openpackaging.packages.WordprocessingMLPackage;
import org.docx4j.openpackaging.parts.WordprocessingML.AltChunkType;
import org.docx4j.openpackaging.parts.WordprocessingML.MainDocumentPart;
import org.docx4j.wml.P;
import org.docx4j.wml.PPr;
import org.docx4j.wml.STPageOrientation;
import org.docx4j.wml.SectPr;

public class Docx4jUtils {

	
    public static Boolean merge(String mainPath, String tablePath, String outFileName) throws Exception {    
        
        WordprocessingMLPackage wmlDestPkg = WordprocessingMLPackage.createPackage();
        try {
	        MainDocumentPart main = wmlDestPkg.getMainDocumentPart();
	        main.addAltChunk(AltChunkType.WordprocessingML, new FileInputStream(mainPath) );
	
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
	
	        main.addAltChunk(AltChunkType.WordprocessingML, new FileInputStream(tablePath) );

	        // Now save it     
	        wmlDestPkg.save(new java.io.File(outFileName) );    
	        return true;
        } catch(Exception e) {

        }
        
        return false;
                    
    }    	
	
	/**
	 * @param args
	 * @throws Exception 
	 */
	public static void main(String[] args) throws Exception {
		// TODO Auto-generated method stub
		Docx4jUtils.merge("C:\\YQ\\out.docx", "C:\\YQ\\out-table.docx", "C:\\YQ\\b.docx");
	}

}
