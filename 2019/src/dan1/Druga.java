package dan1;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

public class Druga {

	public static void main(String[] args) throws IOException {
		System.out.println(bencin("src/dan1/dan1.in", "src/dan1/dan1-2.out"));

	}
	
	public static int bencin(String input, String output) throws IOException {
		BufferedReader vhod = new BufferedReader(new FileReader(input));
        PrintWriter izhod = new PrintWriter(new FileWriter(output));
        
        int skupna_masa = 0;
        
        while (vhod.ready()) {
        	String vrstica = vhod.readLine();
        	int masa = Integer.parseInt(vrstica);
        	
        	double bencin = Math.floor(masa / 3) - 2;
        	
        	while (bencin > 0) {
        		skupna_masa += bencin;
        		bencin = Math.floor(bencin / 3) - 2;
        	}
        	
        }
        izhod.print(skupna_masa);
        vhod.close();
        izhod.close();
        
        return skupna_masa;
	}
		
}
