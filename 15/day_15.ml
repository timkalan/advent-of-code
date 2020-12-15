let v_seznam vsebina_datoteke = 
    String.split_on_char ',' vsebina_datoteke |> 
    List.map int_of_string


(* vir: https://stackoverflow.com/questions/2710233/how-to-get-a-sub-list-from-a-list-in-ocaml *)
let rec sublist b e l = 
  match l with
    [] -> failwith "sublist"
  | h :: t -> 
     let tail = if e=0 then [] else sublist (b-1) (e-1) t in
     if b>0 then tail else h :: tail


let najdi_zadnjega elem sez = 
    let rec aux trenutni najvecji = function 
    | [] -> najvecji
    | x :: xs -> 
        if x = elem then aux (trenutni + 1) trenutni xs 
        else aux (trenutni + 1) najvecji xs
    in 
    aux 0 0 sez


let nto_stevilo input n = 
    let rec aux seznam = 
        let zadnje = List.nth seznam ((List.length seznam) - 1) in
        if List.length seznam >= n then zadnje
        else (
            let brez_zadnjega = sublist 0 ((List.length seznam) - 2) seznam in
            if List.mem zadnje brez_zadnjega
            then let nova = (List.length seznam) - 1 - (najdi_zadnjega zadnje brez_zadnjega) in
                    aux (seznam @ [nova])

            else aux (seznam @ [0])
        )
    in 
    aux input


let naloga1 vsebina_datoteke = 
    let sez = v_seznam vsebina_datoteke in 
    string_of_int (nto_stevilo sez 2020)


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
    let vsebina_datoteke = preberi_datoteko "15/day_15.in" in
    let odgovor1 = naloga1 vsebina_datoteke
    (*and odgovor2 = naloga2 vsebina_datoteke*)
    in
    izpisi_datoteko "15/day_15_1.out" odgovor1;
    (*izpisi_datoteko "15/day_15_2.out" odgovor2;*)