package dan3;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

public class Prva {

	public static void main(String[] args) throws IOException {
		System.out.println(zice("src/dan3/dan3.in", "src/dan3/dan3-1.out"));

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

        int najblizje = Integer.MAX_VALUE;
        
        for (Koordinati poz1 : pozicije1) {
        	for (Koordinati poz2 : pozicije2) {
        		if (poz1.equals(poz2)) {
        			int x = poz1.getX();
        			int y = poz1.getY();
        			
        			if (Math.abs(x) + Math.abs(y) < najblizje) {
        				najblizje = Math.abs(x) + Math.abs(y);
        			}
        		}
        	}
        }
        
        izhod.print(najblizje);
        vhod.close();
        izhod.close();
        return najblizje;
	}
		
}