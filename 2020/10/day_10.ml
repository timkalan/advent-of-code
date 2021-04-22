
let vhod_v_seznam vsebina_datoteke = 
    vsebina_datoteke |> String.split_on_char '\n' |> List.map int_of_string |>
    List.sort compare


let naloga1 vsebina_datoteke = 
    let sez = 0 :: (vhod_v_seznam vsebina_datoteke) in 
    let rec aux acc = function
        | x :: y :: xs -> aux ((y - x) :: acc) (y :: xs)
        | _ -> acc
    in 
    let razlike = aux [] sez in 
    let rec prestej st = function
        | [] -> 0
        | x :: xs -> if x = st then 1 + prestej st xs else prestej st xs
    in 
    (* pri razliki 3 prištejemo 1 zaradi naše naprave *)
    ((prestej 1 razlike) * ((prestej 3 razlike) + 1)) |> string_of_int


(* 2. DEL *) 


(* vir: https://stackoverflow.com/questions/2710233/how-to-get-a-sub-list-from-a-list-in-ocaml *)
let rec sublist b e l = 
  match l with
    [] -> failwith "sublist"
  | h :: t -> 
     let tail = if e=0 then [] else sublist (b-1) (e-1) t in
     if b>0 then tail else h :: tail


let rec naredi_drevo sez = 
    match sez with 
    | [] -> []
    | x :: xs -> 
        match List.length xs with
            | 0 -> []
            | 1 -> if List.hd xs <= x + 3 then (x, [List.hd xs]) :: (naredi_drevo xs)
                   else (x, []) :: naredi_drevo xs
            | 2 -> 
                if List.nth xs 0 > x + 3 then (x, []) :: (naredi_drevo xs)
                else if List.nth xs 1 > x + 3 then (x, [List.nth xs 0]) :: (naredi_drevo xs) 
                else (x, [(List.nth xs 0); (List.nth xs 1)]) :: (naredi_drevo xs)

            | _ -> 
                if List.nth xs 0 > x + 3 then (x, []) :: (naredi_drevo xs)
                else if List.nth xs 1 > x + 3 then (x, [List.nth xs 0]) :: (naredi_drevo xs) 
                else if List.nth xs 2 > x + 3 then (x, [(List.nth xs 0); (List.nth xs 1)]) :: (naredi_drevo xs)
                else (x, [(List.nth xs 0); (List.nth xs 1); (List.nth xs 2)]) :: (naredi_drevo xs)


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
    let vsebina_datoteke = preberi_datoteko "10/day_10.in" in
    let odgovor1 = naloga1 vsebina_datoteke
    (*and odgovor2 = naloga2 vsebina_datoteke*)
    in
    izpisi_datoteko "10/day_10_1.out" odgovor1;
    (*izpisi_datoteko "10/day_10_2.out" odgovor2;*)