(* loči prvotno datoteko po vrsticah *)
let vhod_v_seznam vsebina_datoteke = 
    String.split_on_char '\n' vsebina_datoteke


(* iz vrstice naredi seznam relevantnih zadev *)
let vseznami_vrstico str = 
    match String.split_on_char '-' str with
    | [] -> []
    | spodnja_meja :: neobdelano :: ostalo -> (
        match String.split_on_char ' ' neobdelano with
        | [] -> []
        | zgornja_meja :: xs -> spodnja_meja :: zgornja_meja :: xs
    )
    | _ -> []


let st_pojavitev znak niz = List.length (String.split_on_char znak niz) - 1


(* ali_ustreza dobi vrstico in iz nje načara 0 če ne ustreza in 1, če *)
let ali_ustreza string = 
    match vseznami_vrstico string with
    | [] -> 0
    | spodnja :: zgornja :: skoraj_char :: geslo :: nicelno_ostalo -> (
        let popravljen = String.get skoraj_char 0 in 
        if (st_pojavitev popravljen geslo >= int_of_string spodnja) &&
            (st_pojavitev popravljen geslo <= int_of_string zgornja) 
        then 1 else 0
    )
    | _ -> failwith "To ni možno"


let naloga1 vsebina_datoteke =
    let seznam_gesel = vhod_v_seznam vsebina_datoteke in 
    let ustrezni =  List.map ali_ustreza seznam_gesel in 
        let rec st_pravilnih seznam = 
            match seznam with
            | [] -> 0
            | x :: xs -> x + st_pravilnih xs
        in 
        string_of_int (st_pravilnih ustrezni)


(* 2. DEL *)

let ali_ustreza_2 string = 
    match vseznami_vrstico string with
    | [] -> 0
    | prvo_mesto :: drugo_mesto :: skoraj_char :: geslo :: nicelno_ostalo -> (
        let popravljen = String.get skoraj_char 0 in
        let pozicija_ena = geslo.[(int_of_string prvo_mesto) - 1] in 
        let pozicija_dva = geslo.[(int_of_string drugo_mesto) - 1] in 
        if (pozicija_ena != pozicija_dva) && 
            (pozicija_ena = popravljen || pozicija_dva = popravljen)
        then 1 else 0
    )
    | _ -> failwith "To ni možno"


let naloga2 vsebina_datoteke =
    let seznam_gesel = vhod_v_seznam vsebina_datoteke in 
    let ustrezni =  List.map ali_ustreza_2 seznam_gesel in 
        let rec st_pravilnih seznam = 
            match seznam with
            | [] -> 0
            | x :: xs -> x + st_pravilnih xs
        in 
        string_of_int (st_pravilnih ustrezni)


(* Spodnje je rahlo modificirana koda iz spletne učilnice *)

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
    let vsebina_datoteke = preberi_datoteko "02/day_2.in" in
    let odgovor1 = naloga1 vsebina_datoteke
    and odgovor2 = naloga2 vsebina_datoteke
    in
    izpisi_datoteko "02/day_2_1.out" odgovor1;
    izpisi_datoteko "02/day_2_2.out" odgovor2;