package com.partycommittee.util;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;

public class FileRead {
	
	public String readTxt() throws IOException {
		BufferedReader br = new BufferedReader(new FileReader("c:/test.txt"));
		StringBuilder strBuilder = new StringBuilder();
		String r = br.readLine();
		while (r != null) {
			if (r.indexOf("#") == 0 || r.trim().equals("")) {
				// Do NOT add line.
			} else {
				strBuilder.append(r);
			}
			r = br.readLine();
		}
		System.out.println(strBuilder.toString());
		return strBuilder.toString();
	}
}
