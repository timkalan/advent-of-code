(* pomožna funkcija za pomoč pri branju datoteke *)

let vhod_v_seznam vsebina_datoteke = 
    let string_sez = String.split_on_char '\n' vsebina_datoteke in
        List.map int_of_string string_sez


(* 1. DEL *)

let rec notranja_rekurzija y = function
    | [] -> None
    | x :: xs -> if x + y = 2020 then Some (x * y) else notranja_rekurzija y xs


let rec zunanja_rekurzija = function
    | [] -> None
    | x :: xs -> if notranja_rekurzija x xs != None then notranja_rekurzija x xs else zunanja_rekurzija xs


(* 2. DEL *)
let rec tretja_rekurzija x y = function
    | [] -> None
    | z :: zs -> if x + y + z = 2020 then Some (x * y * z) else tretja_rekurzija x y zs


let rec druga_rekurzija y = function
    | [] -> None
    | x :: xs -> if tretja_rekurzija y x xs != None then tretja_rekurzija y x xs else druga_rekurzija y xs


let rec prva_rekurzija = function
    | [] -> None
    | x :: xs -> if druga_rekurzija x xs != None then druga_rekurzija x xs else prva_rekurzija xs



(* Spodnje je rahlo modificirana koda iz spletne učilnice *)

let naloga1 vsebina_datoteke =
    match zunanja_rekurzija (vhod_v_seznam vsebina_datoteke) with
    | None -> "Ni takih števil"
    | Some x -> string_of_int x

let naloga2 vsebina_datoteke =
    match prva_rekurzija (vhod_v_seznam vsebina_datoteke) with
    | None -> "Ni takih števil"
    | Some x -> string_of_int x

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
    let vsebina_datoteke = preberi_datoteko "01/day_1.in" in
    let odgovor1 = naloga1 vsebina_datoteke
    and odgovor2 = naloga2 vsebina_datoteke
    in
    izpisi_datoteko "01/day_1_1.out" odgovor1;
    izpisi_datoteko "01/day_1_2.out" odgovor2;