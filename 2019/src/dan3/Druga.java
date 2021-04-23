package dan3;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class Druga {

	public static void main(String[] args) throws IOException {
		System.out.println(zice("src/dan3/dan3.in", "src/dan3/dan3-2.out"));

	}
	
	public static int zice(String input, String output) throws IOException {
		BufferedReader vhod = new BufferedReader(new FileReader(input));
        PrintWriter izhod = new PrintWriter(new FileWriter(output));
        
        List<Koordinati> pozicije1 = null;
        List<Koordinati> pozicije2 = null;
        
        for (int j = 0; j < 2; j++) {
        	String vrstica = vhod.readLine();
        	String[] ukazi = vrstica.split(",");
        	
        	List<Koordinati> pozicije = new ArrayList<Koordinati>();
        	
        	for (String ukaz : ukazi) {
        		String smer = ukaz.substring(0, 1);
        		int kolicina = Integer.parseInt(ukaz.substring(1));
        		
        		for (int i = 1; i <= kolicina; i++) {
        			int stari_x = 0;
        			int stari_y = 0;
        			
        			if (pozicije.size() > 0) {
        			stari_x = pozicije.get(pozicije.size() - 1).getX();
        			stari_y = pozicije.get(pozicije.size() - 1).getY();
        			}
        			
        			switch(smer) {
        			case "U": pozicije.add(new Koordinati(stari_x, stari_y + 1)); break;
        			case "D": pozicije.add(new Koordinati(stari_x,stari_y - 1)); break;
        			case "L": pozicije.add(new Koordinati(stari_x - 1, stari_y)); break;
        			case "R": pozicije.add(new Koordinati(stari_x + 1, stari_y)); break;
        			}
        		}
        	}
			if (j == 0) pozicije1 = pozicije;
        	else pozicije2 = pozicije;
        	
        }

        int najmanj_korakov = Integer.MAX_VALUE;
        
        for (int i = 0; i < pozicije1.size(); i++) {
        	for (int j = 0; j < pozicije2.size(); j++) {
        		if (pozicije1.get(i).equals(pozicije2.get(j))) {
        			// dodamo 2, saj ne beležimo obeh izhodišč
        			if (i + j + 2 < najmanj_korakov) najmanj_korakov = i + j + 2;
        		}
        	}
        }
        
        izhod.print(najmanj_korakov);
        vhod.close();
        izhod.close();
        return najmanj_korakov;
	}
		
}