(* loči prvotno datoteko po vrsticah *)
let vhod_v_seznam vsebina_datoteke = 
    String.split_on_char '\n' vsebina_datoteke 


(* prešteje drevesa ob pomiku desno in pomiku navzdol za 1 *)
let rec koliko_dreves seznam zamik pomik_desno = 
    match seznam with
    | [] -> 0
    | x :: xs -> 
        let realni_zamik zamik =
            if zamik >= String.length x then zamik - String.length x
            else zamik
        in
        if x.[realni_zamik zamik] = '#' 
        then 1 + koliko_dreves xs ((realni_zamik zamik) + pomik_desno) pomik_desno
        else koliko_dreves xs ((realni_zamik zamik) + pomik_desno) pomik_desno


(* za eleganco napišemo verzijo s premikom dveh polj navzdol posebaj *)
let rec koliko_dva_dol seznam zamik pomik_desno = 
    let realni_zamik zamik x =
            if zamik >= String.length x then zamik - String.length x
            else zamik
    in
    match seznam with
    | [] -> 0
    | x :: y :: xs -> 
        if x.[realni_zamik zamik x] = '#' 
        then 1 + koliko_dva_dol xs ((realni_zamik zamik x) + pomik_desno) pomik_desno
        else koliko_dva_dol xs ((realni_zamik zamik x) + pomik_desno) pomik_desno

    (* to bi verjetno lahko nekako združili z zgornjim matchom *)
    | x :: [] -> 
        if x.[realni_zamik zamik x] = '#' 
        then 1 + koliko_dva_dol [] ((realni_zamik zamik x) + pomik_desno) pomik_desno
        else koliko_dva_dol [] ((realni_zamik zamik x) + pomik_desno) pomik_desno


let naloga1 vsebina_datoteke = 
    let vsebina = vhod_v_seznam vsebina_datoteke in 
    let nepretvorjen_odgovor = koliko_dreves vsebina 0 3 in 
        string_of_int nepretvorjen_odgovor


(* 2. DEL *)

let naloga2 vsebina_datoteke = 
    let vsebina = vhod_v_seznam vsebina_datoteke in 
    let enaena = koliko_dreves vsebina 0 1 in 
    let triena = koliko_dreves vsebina 0 3 in 
    let petena = koliko_dreves vsebina 0 5 in
    let sedemena = koliko_dreves vsebina 0 7 in 
    let enadva = koliko_dva_dol vsebina 0 1 in 
    let nepretvorjen = enaena * triena * petena * sedemena * enadva in 
        string_of_int nepretvorjen




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
    let vsebina_datoteke = preberi_datoteko "03/day_3.in" in
    let odgovor1 = naloga1 vsebina_datoteke
    and odgovor2 = naloga2 vsebina_datoteke
    in
    izpisi_datoteko "03/day_3_1.out" odgovor1;
    izpisi_datoteko "03/day_3_2.out" odgovor2;
