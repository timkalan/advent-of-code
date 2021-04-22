package dan2;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Arrays;

public class Prva {

	public static void main(String[] args) throws IOException {
		System.out.println(intcode1("src/dan2/dan2.in", "src/dan2/dan2-1.out"));

	}
	
	public static String intcode1(String input, String output) throws IOException {
		BufferedReader vhod = new BufferedReader(new FileReader(input));
        PrintWriter izhod = new PrintWriter(new FileWriter(output));
        
        	String vrstica = vhod.readLine();
        	String[] ukazi = vrstica.split(",");
        	
        	for (int i = 0; i < ukazi.length; i+=4) {
        		if (ukazi[i].equals("1")) {
        			int poz_1 = Integer.parseInt(ukazi[i+1]);
        			int poz_2 = Integer.parseInt(ukazi[i+2]);
        			int poz_3 = Integer.parseInt(ukazi[i+3]);
        			
        			// men je zelo žal, če bo to kdo kdaj bral
        			ukazi[poz_3] = Integer.toString((Integer.parseInt(ukazi[poz_1]) + Integer.parseInt(ukazi[poz_2])));
        		}
        		else if (ukazi[i].equals("2")) {
        			int poz_1 = Integer.parseInt(ukazi[i+1]);
        			int poz_2 = Integer.parseInt(ukazi[i+2]);
        			int poz_3 = Integer.parseInt(ukazi[i+3]);
        			
        			ukazi[poz_3] = Integer.toString((Integer.parseInt(ukazi[poz_1]) * Integer.parseInt(ukazi[poz_2])));
        		}
        		
        		else if (ukazi[i].equals("99")) break;
        	}
        	
        	
        
        izhod.print(Arrays.toString(ukazi));
        vhod.close();
        izhod.close();
        
        return ukazi[0];
	}
		
}

