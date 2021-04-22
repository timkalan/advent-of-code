let vhod_v_seznam vsebina_datoteke = 
    let sez = vsebina_datoteke |> String.split_on_char '\n' in 
    let rec aux = function
        | [] -> []
        | x :: xs -> (String.sub x 0 1, 
                     int_of_string (String.sub x 1 ((String.length x) - 1))) :: (aux xs)
    in 
    aux sez


let naloga1 vsebina_datoteke = 
    let seznam_premikov = vhod_v_seznam vsebina_datoteke in 
    let rec korak x y smer = function
        | [] -> (Int.abs x) + (Int.abs y)
        | (ukaz, kolicina) :: xs ->
            match ukaz with 
            | "N" -> korak x (y + kolicina) smer xs
            | "S" -> korak x (y - kolicina) smer xs
            | "E" -> korak (x + kolicina) y smer xs
            | "W" -> korak (x - kolicina) y smer xs
            | "L" -> korak x y (smer + kolicina) xs
            | "R" -> korak x y (smer - kolicina) xs 
            | "F" -> (
                match (smer mod 360) with
                    | 0 -> korak (x + kolicina) y smer xs
                    | 90 | - 270 -> korak x (y  + kolicina) smer xs 
                    | 180 | - 180 -> korak (x - kolicina) y  smer xs
                    | 270 | - 90 -> korak x (y - kolicina) smer xs
                    | _ -> failwith "napačen kot"
                )

            | _ -> failwith "nekje smo se zmotili"

    in 
    (korak 0 0 0 seznam_premikov) |> string_of_int


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
    let vsebina_datoteke = preberi_datoteko "12/day_12.in" in
    let odgovor1 = naloga1 vsebina_datoteke
    (*and odgovor2 = naloga2 vsebina_datoteke*)
    in
    izpisi_datoteko "12/day_12_1.out" odgovor1;
    (*izpisi_datoteko "12/day_12_2.out" odgovor2;*)