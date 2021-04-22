package dan2;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;

public class Druga {

	public static void main(String[] args) throws IOException {
		System.out.println(intcode1("src/dan2/dan2.in", "src/dan2/dan2-2.out"));

	}
	
	public static int intcode1(String input, String output) throws IOException {
		BufferedReader vhod = new BufferedReader(new FileReader(input));
        PrintWriter izhod = new PrintWriter(new FileWriter(output));
        
        	String vrstica = vhod.readLine();
        	
        	for (int j = 0; j <= 99; j++) {
        		for (int k = 0; k <= 99; k++) {
        			String[] ukazi = vrstica.split(",");
        			ukazi[1] = Integer.toString(j);
        			ukazi[2] = Integer.toString(k);
        			
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
        			if (ukazi[0].equals("19690720")) {
        				izhod.print(100 * Integer.parseInt(ukazi[1]) + Integer.parseInt(ukazi[2]));
        				vhod.close();
        		        izhod.close();
        				return 100 * Integer.parseInt(ukazi[1]) + Integer.parseInt(ukazi[2]);
        			}
        		}
        	}
        	vhod.close();
	        izhod.close();
        	return 0;
	}
		
}
