let vhod_v_seznam vsebina_datoteke = 
    String.split_on_char '\n' vsebina_datoteke 

(* rezultat vhod_v_seznam pretvorimo v seznam stringov, kjer je en string en form *)
let pretvori_v_uporabno seznam = 
    let rec aux (form : string) (seznam : string list) : string list = 
        match seznam with
        | [] -> [form]
        | x :: y :: xs -> 
            if y = "" then 
                if x = "" then form :: aux "" xs
                else (String.concat " " [x; form]) :: (aux "" xs)
            else
                if x = "" then form :: aux y xs
                else (aux (String.concat " " [x; y; form]) xs)
                
        | x :: [] -> 
            if x = "" then form :: (aux "" [])
            else (String.concat " " [x; form]) :: (aux "" [])

    in 
    (* opazil sem težave s presledki na koncu -> String.trim popravi *)
    List.map (String.trim) (aux "" seznam)


let rec unija sez1 sez2 = 
    match sez1 with 
    | [] -> sez2 
    | x :: xs ->
            if not (List.mem x sez2) then unija xs (x :: sez2)
            else unija xs sez2


(*vir kode https://reasonml.chat/t/iterate-over-a-string-pattern-match-on-a-string/1317 *)
let niz_v_seznam string = string |> String.to_seq |> List.of_seq


let strinjanje niz = 
    let sez = String.split_on_char ' ' niz in 
    let uporaben = List.map niz_v_seznam sez in 
    let rec aux acc sez = 
        match sez with 
        | [] -> acc 
        | x :: xs -> aux (unija x acc) xs
    in 
    aux [] uporaben
    

let rec vsota = function 
    | [] -> 0 
    | x :: xs -> x + vsota xs


let naloga1 vsebina_datoteke = 
    let seznam = vsebina_datoteke |> vhod_v_seznam |> pretvori_v_uporabno in 
    let sez_yes = seznam |> (List.map strinjanje) |> (List.map List.length) in 
    string_of_int (vsota sez_yes)


(* 2. DEL *)


let presek sez1 sez2 = 
    let rec aux acc l1 l2 = 
        match l1 with 
        | [] -> acc 
        | x :: xs ->
            if List.mem x l2 then aux (x :: acc) xs l2 
            else aux acc xs l2
    in 
    aux [] sez1 sez2 


let strinjanje_strogo niz = 
    let sez = String.split_on_char ' ' niz in 
    let uporaben = List.map niz_v_seznam sez in 
    let rec aux acc sez = 
        match sez with 
        | [] -> acc 
        | x :: xs -> aux (presek x acc) xs
    in 
    aux (List.nth uporaben 0) uporaben


let naloga2 vsebina_datoteke = 
    let seznam = vsebina_datoteke |> vhod_v_seznam |> pretvori_v_uporabno in 
    let sez_yes = seznam |> (List.map strinjanje_strogo) |> (List.map List.length) in 
    string_of_int (vsota sez_yes)


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
    let vsebina_datoteke = preberi_datoteko "06/day_6.in" in
    let odgovor1 = naloga1 vsebina_datoteke
    and odgovor2 = naloga2 vsebina_datoteke
    in
    izpisi_datoteko "06/day_6_1.out" odgovor1;
    izpisi_datoteko "06/day_6_2.out" odgovor2;

 