let pretvori_v_uporabno vsebina = 
    let sez = String.split_on_char '\n' vsebina in 
    let zelim_iti = List.hd sez in 
    let avtobusi = String.split_on_char ',' (List.nth sez 1) in 
    (* razišči zakaj tu dela samo <> in ne != *)
    let peljejo = List.filter (fun x -> x <> "x") avtobusi in 
    (int_of_string zelim_iti, (List.map int_of_string peljejo))


let naloga1 vsebina_datoteke = 
    let (zelim, mozni) = pretvori_v_uporabno vsebina_datoteke in 
    let rec aux min odhod = function
        | [] -> min 
        | bus :: xs -> 
            let pom depart avtobus = ((depart / avtobus) + 1) * avtobus in
            if (pom odhod bus > odhod) && 
                (pom odhod bus < pom odhod min)
            then aux bus odhod xs 
            else aux min odhod xs

    in 
    let bus = aux zelim zelim mozni in 
    let cakam = (((zelim / bus) + 1) * bus) - zelim in 
    string_of_int (bus * cakam)


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
    let vsebina_datoteke = preberi_datoteko "13/day_13.in" in
    let odgovor1 = naloga1 vsebina_datoteke
    (*and odgovor2 = naloga2 vsebina_datoteke*)
    in
    izpisi_datoteko "13/day_13_1.out" odgovor1;
    (*izpisi_datoteko "13/day_13_2.out" odgovor2;*)