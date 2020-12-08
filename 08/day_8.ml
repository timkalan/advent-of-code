let vhod_v_seznam_parov vsebina_datoteke = 
    let sez = String.split_on_char '\n' vsebina_datoteke in 
    let v_par niz = 
        match String.split_on_char ' ' niz with
        | x :: y :: [] -> (x, int_of_string y)
        | _ -> failwith "nepravi format"
    in 
    List.map v_par sez


let naloga1 vsebina_datoteke = 
    let pari = vhod_v_seznam_parov vsebina_datoteke in 
    let rec aux acc indeksi sez zacetek =
        if List.mem zacetek indeksi then acc 
        else match List.nth sez zacetek with 
            | ("nop", koliko) -> aux acc (zacetek :: indeksi) sez (1 + zacetek)
            | ("acc", koliko) -> aux (koliko + acc) (zacetek :: indeksi) sez (1 + zacetek)
            | ("jmp", koliko) -> aux acc (zacetek :: indeksi) sez (koliko + zacetek)
            | _ -> failwith "napačen format"

    in 
    (aux 0 [] pari 0) |> string_of_int


(* 2. DEL *)

let rec izvanjanje acc indeksi sez zacetek =
    if List.mem zacetek indeksi then acc 
    else match List.nth sez zacetek with 
        | ("nop", koliko) -> izvanjanje acc (zacetek :: indeksi) sez (1 + zacetek)
        | ("acc", koliko) -> izvanjanje (koliko + acc) (zacetek :: indeksi) sez (1 + zacetek)
        | ("jmp", koliko) -> izvanjanje acc (zacetek :: indeksi) sez (koliko + zacetek)
        | _ -> failwith "napačen format"

let naloga2 vsebina_datoteke = "ni še" 






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
    let vsebina_datoteke = preberi_datoteko "08/day_8.in" in
    let odgovor1 = naloga1 vsebina_datoteke
    and odgovor2 = naloga2 vsebina_datoteke
    in
    izpisi_datoteko "08/day_8_1.out" odgovor1;
    izpisi_datoteko "08/day_8_2.out" odgovor2;