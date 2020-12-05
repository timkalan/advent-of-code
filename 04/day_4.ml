let vhod_v_seznam vsebina_datoteke = 
    String.split_on_char '\n' vsebina_datoteke 

(* rezultat vhod_v_seznam pretvorimo v seznam stringov, kjer je en string en passport *)
let pretvori_v_uporabno seznam = 
    let rec aux (passport : string) (seznam : string list) : string list = 
        match seznam with
        | [] -> [passport]
        | x :: y :: xs -> 
            if y = "" then 
                if x = "" then passport :: aux "" xs
                else (String.concat " " [x; passport]) :: (aux "" xs)
            else
                if x = "" then passport :: aux y xs
                else (aux (String.concat " " [x; y; passport]) xs)
                
        | x :: [] -> 
            if x = "" then passport :: (aux "" [])
            else (String.concat " " [x; passport]) :: (aux "" [])

    in 
    (* opazil sem težave s presledki na koncu -> String.trim popravi *)
    List.map (String.trim) (aux "" seznam)
     

let naloga1 vsebina_datoteke = 
    let seznam = vhod_v_seznam vsebina_datoteke in 
    let uporaben = pretvori_v_uporabno seznam in 
    let preveri_vrstico niz =
        let seznam_polj = String.split_on_char ' ' niz in
        match List.length seznam_polj with 
        | 8 -> 1 
        | 7 -> 
            let rec poglej_cid = function
            | [] -> 1
            | x :: xs -> 
                if List.nth x 0 = "cid" then 0
                else poglej_cid xs
            in 
            poglej_cid (List.map (String.split_on_char ':') seznam_polj)

        
        | _ -> 0
    in 
    let seznam_ustreznih = List.map preveri_vrstico uporaben in 
    let rec vsota seznam =
        match seznam with
        | [] -> 0
        | x :: xs -> x + vsota xs
    in 
    string_of_int (vsota seznam_ustreznih)


(* 2. DEL *)


let testni_hcl = ['#'; '0'; '1'; '2'; '3'; '4'; '5'; '6'; '7'; '8'; '9'; 'a'; 'b'; 'c'; 'd'; 'e'; 'f']

let naloga2 vsebina_datoteke = 
    let seznam = vhod_v_seznam vsebina_datoteke in 
    let uporaben = pretvori_v_uporabno seznam in 
    let preveri_vrstico niz =
        let seznam_polj = String.split_on_char ' ' niz in
        match List.length seznam_polj with 
        | 8 | 7 -> 
            let rec poglej_st polje spodnja zgornja = function 
                | [] -> 0
                | x :: xs -> 
                    if List.nth x 0 = polje then 
                        if (int_of_string (List.nth x 1) >= spodnja) && 
                            (int_of_string (List.nth x 1) <= zgornja) then 1
                        else 0 
                    else poglej_st polje spodnja zgornja xs
            in

            let byr = poglej_st "byr" 1920 2002 (List.map (String.split_on_char ':') seznam_polj) in 
            let iyr = poglej_st "iyr" 2010 2020 (List.map (String.split_on_char ':') seznam_polj) in
            let eyr = poglej_st "eyr" 2020 2030 (List.map (String.split_on_char ':') seznam_polj) in  
            
            let rec poglej_hgt = function
                | [] -> 0 
                | x :: xs -> 
                    if List.nth x 0 = "hgt" then 
                        if String.length (List.nth x 1) = 5 then
                            if String.sub (List.nth x 1) 3 2 = "cm" then 
                                if (int_of_string (String.sub (List.nth x 1) 0 3) >= 150) &&
                                    (int_of_string (String.sub (List.nth x 1) 0 3) <= 193) 
                                then 1
                                else 0
                            else 0
                        else if String.length (List.nth x 1) = 4 then
                            if String.sub (List.nth x 1) 2 2 = "in" then 
                                if (int_of_string (String.sub (List.nth x 1) 0 2) >= 59) &&
                                    (int_of_string (String.sub (List.nth x 1) 0 2) <= 76) 
                                then 1
                                else 0 
                            else 0
                        else 0
                            
                    else poglej_hgt xs
            in 
            let hgt = poglej_hgt (List.map (String.split_on_char ':') seznam_polj) in 

            (* nedokončano *)
            let rec poglej_hcl = function 
                | [] -> 0
                | x :: xs -> 
                    if List.nth x 0 = "hcl" then 
                        if (String.length (List.nth x 1) = 7) &&  ((List.nth x 1).[0] = '#') then 
                            1 else 0

                    else poglej_hcl xs 
            
            in 
            let hcl = poglej_hcl (List.map (String.split_on_char ':') seznam_polj) in 

            let rec poglej_ecl = function
                | [] -> 0
                | x :: xs -> 
                    if List.nth x 0 = "ecl" then 
                         if List.mem (List.nth x 1) ["amb"; "blu"; "brn"; "gry"; "grn"; "hzl"; "oth"] 
                         then 1 
                         else 0
                    else poglej_ecl xs
            
            in 
            let ecl = poglej_ecl (List.map (String.split_on_char ':') seznam_polj) in

            let rec poglej_pid = function
                | [] -> 0 
                | x :: xs -> 
                    if List.nth x 0 = "pid" then 
                        if String.length (List.nth x 1) = 9 then 1
                        else 0 
                    else 0
            
            in 
            let pid = poglej_pid (List.map (String.split_on_char ':') seznam_polj) in



                if byr + iyr + eyr + hgt + hcl + ecl + pid >= 7 then 1 else 0

        (*| 7 -> 
            let rec poglej_cid = function
            | [] -> 1
            | x :: xs -> 
                if List.nth x 0 = "cid" then 0
                else poglej_cid xs
            in 
            poglej_cid (List.map (String.split_on_char ':') seznam_polj)*)

        
        | _ -> 0
    in 
    let seznam_ustreznih = List.map preveri_vrstico uporaben in 
    let rec vsota seznam =
        match seznam with
        | [] -> 0
        | x :: xs -> x + vsota xs
    in 
    string_of_int (vsota seznam_ustreznih)



(* rahlo modificirana koda iz spletne učilnice *)

let _ =
    let preberi_datoteko ime_datoteke =
        let chan = open_in ime_datoteke in
        let vsebina = really_input_string chan (in_channel_length chan) in
        close_in chan;
        vsebina
    and izpisi_datoteko ime_datoteke vsebina =
        let chan = open_out ime_datoteke in
        output_string chan vsebina;
        close_out chan
    in
    let vsebina_datoteke = preberi_datoteko "04/day_4.in" in
    let odgovor1 = naloga1 vsebina_datoteke
    and odgovor2 = naloga2 vsebina_datoteke
    in
    izpisi_datoteko "04/day_4_1.out" odgovor1;
    izpisi_datoteko "04/day_4_2.out" odgovor2;
