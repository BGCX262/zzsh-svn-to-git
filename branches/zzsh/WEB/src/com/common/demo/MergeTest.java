package com.common.demo;

import org.apache.poi.hwpf.HWPFDocument;
import org.apache.poi.hwpf.usermodel.Section;
import org.apache.poi.hwpf.usermodel.Range;
import org.apache.poi.hwpf.usermodel.Paragraph;
import org.apache.poi.hwpf.usermodel.ParagraphProperties;
import org.apache.poi.hwpf.usermodel.CharacterRun;
import org.apache.poi.hwpf.usermodel.CharacterProperties;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

/**
 * 
 * @author win user
 */
public class MergeTest {

	private HWPFDocument mergeToDocument = null;
	private Range mergeToDocRange = null;
	private String mergeToDocName = null;

	public MergeTest(String mergeToDocName) throws FileNotFoundException,
			IOException {
		File mergeToFile = new File(mergeToDocName);
		FileInputStream fis = new FileInputStream(mergeToFile);
		this.mergeToDocument = new HWPFDocument(fis);
		this.mergeToDocRange = this.mergeToDocument.getRange();
		fis.close();
		fis = null;
		this.mergeToDocName = mergeToDocName;
	}

	public void mergeParaFrom(String mergeFilename, int numParaToMerge,
			int numParaMergeAfter) throws FileNotFoundException, IOException {
		File mergeFromFile = new File(mergeFilename);
		FileInputStream fis = new FileInputStream(mergeFromFile);
		HWPFDocument mergeFromDoc = new HWPFDocument(fis);
		Range docRange = mergeFromDoc.getRange();
		if (numParaToMerge > docRange.numParagraphs()) {
			throw new IllegalArgumentException(
					"Value passed tonumParaToMerge parameter greater than the number of Paragraphs in the document.");
		}
		if (numParaMergeAfter > this.mergeToDocRange.numParagraphs()) {
			throw new IllegalArgumentException(
					"Value passed to numParaMergeAfter parameter greater than the number of Paragraphs in the document.");
		}
		Paragraph paraToMerge = docRange.getParagraph(numParaToMerge);

		this.mergeParaIntoDoc(
				this.mergeToDocRange.getParagraph(numParaMergeAfter),
				paraToMerge);
	}

	public void mergeParaIntoDoc(Paragraph mergeAfterPara, Paragraph toMergePara) {
		CharacterRun newCharRun = null;
		CharacterRun toMergeCharRun = null;
		CharacterProperties charProps = null;
		String text = null;
		ParagraphProperties paraProps = toMergePara.cloneProperties();
		Range range = mergeAfterPara.insertAfter(paraProps, 0);
		System.out.println("Text: " + toMergePara.text());
		int numCharRuns = toMergePara.numCharacterRuns();
		for (int i = 0; i < numCharRuns; i++) {
			toMergeCharRun = toMergePara.getCharacterRun(i);
			text = toMergeCharRun.text();
			text = CharacterRun.stripFields(text);
			charProps = toMergeCharRun.cloneProperties();
			newCharRun = range.insertAfter(text, charProps);
			// newCharRun = range.insertAfter(text);
			range = newCharRun;
		}
	}

	public void saveMergedDocument() throws FileNotFoundException, IOException {
		this.saveMergedDocument(this.mergeToDocName);
	}

	public void saveMergedDocument(String filename)
			throws FileNotFoundException, IOException {
		File outputFile = null;
		FileOutputStream fos = null;
		try {
			outputFile = new File(filename);
			fos = new FileOutputStream(outputFile);
			this.mergeToDocument.write(fos);
		} finally {
			if (fos != null) {
				try {
					fos.close();
					fos = null;
				} catch (Exception ex) {
					// I G N O R E
				}
			}
		}
	}

	/**
	 * @param args
	 * the command line arguments
	 */
	public static void main(String[] args) {
		MergeTest mergeTest = null;
		try {
			mergeTest = new MergeTest("C:\\YQ\\out-table.docx");
			mergeTest.mergeParaFrom("C:\\YQ\\out.docx", 1, 1);
			mergeTest.saveMergedDocument("C:\\YQ\\Results.docx");
		} catch (Exception ex) {
			System.out.println("Caught an: " + ex.getClass().getName());
			System.out.println("Message: " + ex.getMessage());
			System .out.println("Stacktrace follows..............");
			ex.printStackTrace(System.out);
		}
	}
}