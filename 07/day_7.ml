let vhod_v_seznam vsebina_datoteke = 
    String.split_on_char '\n' vsebina_datoteke 


let podtorbe vrstica = 
    let sez_besed str = String.split_on_char ' ' str in
    let dolzina_seza = List.length (sez_besed vrstica) in
    let nadtorba = String.concat " " [List.nth (sez_besed vrstica) 0; List.nth (sez_besed vrstica) 1] in
    match String.split_on_char ',' vrstica with
    | [] -> failwith "Napačna oblika niza"
    | x :: [] when List.mem "no" (sez_besed vrstica) -> 
        (nadtorba, [])
    
    | x :: [] -> 
        let podtorba = (List.nth (sez_besed vrstica) (dolzina_seza - 3)) ^ 
                        " " ^ (List.nth (sez_besed vrstica) (dolzina_seza - 2)) in 
        (nadtorba, [podtorba])
    
    | x :: xs -> 
        let rec aux acc = function 
            | [] -> acc 
            | x :: xs -> aux (((List.nth (sez_besed x) 2) ^ " " ^ (List.nth (sez_besed x) 3)) :: acc) xs 
        in 
        let podtorba = (List.nth (sez_besed x) (List.length (sez_besed x) - 3)) ^ 
                        " " ^ (List.nth (sez_besed x) (List.length (sez_besed x) - 2)) in 
        (nadtorba, podtorba :: (aux [] xs))



(* vir kode: https://stackoverflow.com/questions/43169972/elegant-bfs-in-ocaml *)
type 'a graph = Gr of ('a * 'a list) list

let get_neighbors node (Gr g) = 
    try List.assoc node g with Not_found -> []

let bfs start g = 
    let v = Hashtbl.create 100 in 
    let q = Queue.create () in    

    let rec bfs' cur_n acc = 
        get_neighbors cur_n g |>
        List.iter
        (fun n -> 
            try Hashtbl.find v n
            with Not_found -> 
                Hashtbl.add v n ();
                Queue.push n q);
        Hashtbl.add v cur_n (); 
        try bfs' (Queue.pop q) (cur_n::acc)
        with Queue.Empty -> List.rev (cur_n::acc) in
        bfs' start []


let naloga1 vsebina_datoteke = 
    let torbe = vsebina_datoteke |> vhod_v_seznam |> (List.map podtorbe) in 
    let graf = Gr torbe in 
    let rec preglej acc = function
        | [] -> acc
        | (torba, podtorbe) :: xs -> 
            if List.mem "shiny gold" (bfs torba graf) then preglej (1 + acc) xs
            else preglej acc xs
    in 
    let st_moznih = preglej 0 torbe in 
    (* naš BFS šteje za možnost tudi verzijo, ko je shiny gold zunanja torba, to odštejemo *)
    string_of_int (st_moznih - 1)



(* 2. DEL *)


(* spremenimo podtorbe da zajemejo tudi števila *)
let podtorbe_stevila vrstica = 
    let sez_besed str = String.split_on_char ' ' str in
    let dolzina_seza = List.length (sez_besed vrstica) in
    let nadtorba = String.concat " " [List.nth (sez_besed vrstica) 0; List.nth (sez_besed vrstica) 1] in
    match String.split_on_char ',' vrstica with
    | [] -> failwith "Napačna oblika niza"
    | x :: [] when List.mem "no" (sez_besed vrstica) -> 
        (nadtorba, [])
    
    | x :: [] -> 
        let podtorba = (int_of_string (List.nth (sez_besed vrstica) (dolzina_seza - 4)), 
                        (List.nth (sez_besed vrstica) (dolzina_seza - 3)) ^ 
                        " " ^ (List.nth (sez_besed vrstica) (dolzina_seza - 2))) in 
        (nadtorba, [podtorba])
    
    | x :: xs -> 
        let rec aux acc = function 
            | [] -> acc 
            | x :: xs -> aux (((int_of_string (List.nth (sez_besed x) 1), 
                        (List.nth (sez_besed x) 2) ^ " " ^ 
                        (List.nth (sez_besed x) 3))) :: acc) xs 
        in 
        let podtorba = (int_of_string(List.nth (sez_besed x) (List.length (sez_besed x) - 4)),
                        (List.nth (sez_besed x) (List.length (sez_besed x) - 3)) ^ 
                        " " ^ (List.nth (sez_besed x) (List.length (sez_besed x) - 2))) in 
        (nadtorba, podtorba :: (aux [] xs))


let naloga2 vsebina_datoteke = 
    let torbe = vsebina_datoteke |> vhod_v_seznam |> (List.map podtorbe) in 
    let graf = Gr torbe in 
    let za_pogledat = bfs "shiny gold" graf in 


    let rec preglej acc = function
        | [] -> acc
        | (torba, podtorbe) :: xs -> 
            if List.mem "shiny gold" (bfs torba graf) then preglej (1 + acc) xs
            else preglej acc xs
    in 
    let st_moznih = preglej 0 torbe in 
    (* naš BFS šteje za možnost tudi verzijo, ko je shiny gold zunanja torba, to odštejemo *)
    string_of_int (st_moznih - 1)



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
    let vsebina_datoteke = preberi_datoteko "07/day_7.in" in
    let odgovor1 = naloga1 vsebina_datoteke
    and odgovor2 = naloga2 vsebina_datoteke
    in
    izpisi_datoteko "07/day_7_1.out" odgovor1;
    izpisi_datoteko "07/day_7_2.out" odgovor2;