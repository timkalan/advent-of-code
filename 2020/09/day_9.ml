let vhod_v_seznam vsebina_datoteke = 
    let sez = vsebina_datoteke |> String.split_on_char '\n' in 
    List.map int_of_string sez


let vsote_dveh sez = 
    let rec vsote_prvi acc sez = 
        match sez with 
        | [] -> acc 
        | x :: y :: xs -> vsote_prvi ((x + y) :: acc) (x :: xs)
        | _ -> acc
    in 
    let rec aux acc sez = 
        match sez with 
        | [] -> acc
        | x :: xs -> aux (vsote_prvi acc (x :: xs)) xs

    in 
    aux [] sez


(* vir: https://stackoverflow.com/questions/2710233/how-to-get-a-sub-list-from-a-list-in-ocaml *)
let rec sublist b e l = 
  match l with
    [] -> failwith "sublist"
  | h :: t -> 
     let tail = if e=0 then [] else sublist (b-1) (e-1) t in
     if b>0 then tail else h :: tail


let naloga1 vsebina_datoteke = 
    let sez = vsebina_datoteke |> vhod_v_seznam in
    let rec aux sez =  
        if List.mem (List.nth sez 25) (vsote_dveh (sublist 0 24 sez)) then
        aux (sublist 1 ((List.length sez) - 1) sez) 
        else List.nth sez 25
    in 
    (aux sez) |> string_of_int



(* 2. DEL *)

let rec vsota = function 
    | [] -> 0 
    | x :: xs -> x + vsota xs


let min sez = 
    let rec aux acc = function 
        | [] -> acc
        | x :: xs -> 
            if x < acc then aux x xs 
            else aux acc xs
    in 
    aux 10000000000 sez  


let max sez = 
    let rec aux acc = function 
        | [] -> acc
        | x :: xs -> 
            if x > acc then aux x xs 
            else aux acc xs
    in 
    aux 0 sez 


let rec pomozna sez stevilo = 
    let rec vsote_prvi glej seznam = 
        match seznam with 
        | x :: xs -> 
            if vsota glej = stevilo then string_of_int ((min glej) + (max glej)) 
            else vsote_prvi (x :: glej) xs

        | [] -> pomozna (List.tl sez) stevilo

    in 
    vsote_prvi [] sez 


let naloga2 vsebina_datoteke = 
    let seznam = vhod_v_seznam vsebina_datoteke in 
    let stevilo = (naloga1 vsebina_datoteke) |> int_of_string in
    pomozna seznam stevilo


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
    let vsebina_datoteke = preberi_datoteko "09/day_9.in" in
    let odgovor1 = naloga1 vsebina_datoteke
    and odgovor2 = naloga2 vsebina_datoteke
    in
    izpisi_datoteko "09/day_9_1.out" odgovor1;
    izpisi_datoteko "09/day_9_2.out" odgovor2;