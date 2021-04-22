let vhod_v_seznam vsebina_datoteke = 
    String.split_on_char '\n' vsebina_datoteke


(* Vrne največji element seznama *)
let najvecji seznam = 
    let rec aux acc = function 
        | [] -> acc
        | x :: xs -> if x > acc then aux x xs else aux acc xs
    in 
    aux 0 seznam


(*vir kode https://reasonml.chat/t/iterate-over-a-string-pattern-match-on-a-string/1317 *)
let niz_v_seznam string = string |> String.to_seq |> List.of_seq


(* razpolovi glede na dani znak *)
let razpolovi (min, max) znak = 
    (* POMNI: celoštevilsko deljenje *)
    let napol = (max - min) / 2 in
    match znak with 
    | 'F' | 'L' -> (min, min + napol)
    | 'B' | 'R' -> (max - napol, max)
    | _ -> failwith "Verjetno napačen znak"


let vrsta min max niz = 
    let sez_vrsta = (String.sub niz 0 7) |> niz_v_seznam in 
    let rec aux (min, max) sez = 
        match sez with 
        | x :: xs -> aux (razpolovi (min, max) x) xs
        | [] -> (min, max)    
    in 
    let par_rezultat = aux (0, 127) sez_vrsta in 
    fst par_rezultat 


let stolpec min max niz = 
    let sez_vrsta = (String.sub niz 7 3) |> niz_v_seznam in 
    let rec aux (min, max) sez = 
        match sez with 
        | x :: xs -> aux (razpolovi (min, max) x) xs
        | [] -> (min, max)    
    in 
    let par_rezultat = aux (0, 7) sez_vrsta in 
    fst par_rezultat 


let naloga1 vsebina_datoteke = 
    let seznam = vhod_v_seznam vsebina_datoteke in 
    let id (a, b) = a * 8 + b in 
    let vrste = List.map (vrsta 0 127) seznam in 
    let stolpci = List.map (stolpec 0 7) seznam in 
    let pari = List.combine vrste stolpci in 
    let idji = List.map id pari in 
    string_of_int (najvecji idji)
    

(* 2. DEL *)

let rec najdi_razliko_2 sez = 
    match sez with
    | x :: xs -> 
        if List.nth xs 0 = x + 1 then najdi_razliko_2 xs 
        else ((List.nth xs 0) + x) / 2 
    | [] -> failwith "Ni takega števila"


let naloga2 vsebina_datoteke = 
    let seznam = vhod_v_seznam vsebina_datoteke in 
    let id (a, b) = a * 8 + b in 
    let vrste = List.map (vrsta 0 127) seznam in 
    let stolpci = List.map (stolpec 0 7) seznam in 
    let pari = List.combine vrste stolpci in 
    let idji = List.map id pari in
    let po_vrsti = List.sort compare idji in 
    string_of_int (najdi_razliko_2 po_vrsti)


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
    let vsebina_datoteke = preberi_datoteko "05/day_5.in" in
    let odgovor1 = naloga1 vsebina_datoteke
    and odgovor2 = naloga2 vsebina_datoteke
    in
    izpisi_datoteko "05/day_5_1.out" odgovor1;
    izpisi_datoteko "05/day_5_2.out" odgovor2;