(*********************************************************************)
(* Langages de Programmation: IFT 3000 NRC 11775                     *)
(* Corrigé TP1 HIVER 2015.                                           *) 
(* Implanter un système permettant de chercher des activités         *)
(* gratuites en utilisant les données ouvertes de la ville de Québec *)
(*********************************************************************)
(* Étudiant(e):                                                      *)
(* NOM: _____Picard-Lemieux____ PRÉNOM:_________Alexandre___________ *) 
(* MATRICULE: _111_103_625_____ PROGRAMME: ________IFT _____________ *)
(*                                                                   *)
(*********************************************************************)

#load "str.cma";;  (* Charger le module Str *)

(* Charger la signature du système d'activités *)
#use "TP1-SIG-H2015.mli";;

(********************************************************************) 
(* Implantation du système en utilisant                             *)
(* les listes et les enregistrements                     	    *) 
(********************************************************************)

module SysActivites: SYSACTIVITES = struct

  open List
  open Str

(* *****************************************************************)
(* Déclarations d'exceptions et de types *)
(* *****************************************************************)

  exception Err of string

  type activite = {
      code_session : string;
      description : string;
      description_act : string;
      description_nat : string;
      nom_cour : string;
      lieu_1 : string;
      lieu_2 : string;
      arrondissement : string;
      adresse : string;
      date_deb : string;
      date_fin : string;
      jour_semaine : string;
      heure_deb : string;
      heure_fin : string;
    }

  type sysactivites = Vide | SysAct of activite list

(******************************************************************)
(* Fonctions fournies (vous pouvez en ajouter au besoin ...)      *)
(* ****************************************************************)

(* Fonctions manipulant les listes et/ou les chaînes de caractères *)

  (* appartient : 'a -> 'a list -> bool                   *)
  (* Retourner si un élément existe ou non dans une liste *)

  let appartient e l = exists (fun x -> x = e) l

  (* enlever : 'a -> 'a list -> 'a list *)
  (* Enlever un élément dans une liste  *)

  let enlever e l = 
    let (l1, l2) = partition (fun x -> x = e) l
    in l2

  (* remplacer : 'a -> 'a -> 'a list -> 'a list       *)
  (* Remplacer un élément par un autre dans une liste *)

  let remplacer e e' l =
    map (fun x -> (if (x = e) then e' else x)) l 

  (* uniques : string list -> string list                         *)
  (* Retourner une liste ne contenant que des éléments uniques    *) 
  (* Les chaînes vides sont également enlevées de la liste        *)
  (* ainsi que les espaces inutiles avant et/ou après les chaînes *)

  let uniques liste =
    let res = ref [] in
    let rec fct l = match l with
     | [] -> !res
     | x::xs -> if (not (mem x !res) && (x <> "")) then res := (!res)@[String.trim x]; fct xs
    in fct liste

  (* decouper_chaine : string -> string -> string list                          *)
  (* Retourner une liste en découpant une chaîne selon un séparateur (p.ex "|") *)

  let decouper_chaine chaine separateur = split (regexp separateur) chaine

  (* formater_chaine : string list -> string                                  *)
  (* Construire une chaîne selon un certain formatage pour les besoins du TP  *)

  let formater_chaine liste = 
    let res = ref "" in
    let n = (length liste) - 1  in
      for i = 0 to n do
	res := !res ^ ((string_of_int i) ^ " - " ^ (nth liste i) ^ "\n")
      done;
      res := !res ^ ((string_of_int (n+1)) ^ " - Tous \n"); !res


(* Fonctions manipulant le système d'activités *)

  (* initialiser_system : unit -> sysactivites *)
  (* Retourner un système d'activités vide     *)

  let initialiser_system () = Vide

  (* creer_activite : string list -> activite                        *)
  (* Retourner une activité selon une liste de chaînes de caractères *)

  let creer_activite (lch:string list) = 
    if (List.length lch) != 14 then raise (Err "La longueur de la liste est incorrecte");
    {
       code_session = nth lch 0;
       description = nth lch 1;
       description_act = nth lch 2;
       description_nat = nth lch 3;
       nom_cour = nth lch 4;
       lieu_1 = nth lch 5;
       lieu_2 = nth lch 6;
       arrondissement = nth lch 7;
       adresse = nth lch 8;
       date_deb = nth lch 9;
       date_fin = nth lch 10;
       jour_semaine = nth lch 11;
       heure_deb = nth lch 12;
       heure_fin = nth lch 13;
   }

  (* activite_existe : activite -> sysactivites -> bool                  *)
  (* Retourner si une activité existe ou non dans un système d'activités *)

  let activite_existe (a:activite) (sa:sysactivites) = match sa with
    | Vide -> false
    | SysAct la -> appartient a la

  (* retourner_nbr_activites : sysactivites -> int *)
  (* Retourner le nombre d'activités dans un système d'activités *)

  let retourner_nbr_activites (sa:sysactivites) = match sa with
    | Vide -> 0
    | SysAct la -> length la

(******************************************************************)
(* Fonctions à implanter				          *)
(* ****************************************************************)

  (* ajouter_activite : activite -> sysactivites -> sysactivites *)
  (* Permet d'ajouter une activité à un système d'activités      *)

   let ajouter_activite (a:activite) (sa:sysactivites) = match sa with
     | Vide ->  SysAct (a::[])
     | SysAct la -> if activite_existe a sa then sa else SysAct(a::[] @ la) 

   (* supprimer_activite : activite -> sysactivites -> sysactivites *)
   (* Permet de supprimer une activité à un système d'activités     *)

   let supprimer_activite (a:activite) (sa:sysactivites) = match sa with
     | Vide -> raise (Err "Le systeme d'activites est vide")
     | SysAct la -> if activite_existe a sa then SysAct(enlever a la) 
     else raise (Err "Le systeme d'activites ne contient pas cette activite")

   (* ajouter_liste_activites : string list list -> sysactivites -> sysactivites   *)
   (* Permet d'ajouter une liste d'activités à un système d'activités              *)

   let ajouter_liste_activites (lla:string list list) (sa:sysactivites) =
     let sys = ref sa and n = length lla in
     for i = n - 1 downto 0 do
       sys := ajouter_activite (creer_activite(nth lla i )) (!sys)
     done;
     !sys
	 

   (* afficher_activite : activite -> unit                      *)
   (* Permet d'afficher une activité selon un certain formatage *)

   let afficher_activite (a:activite) =
     print_string (" \n Description: " ^ a.description 
		   ^ " \n Type: " ^ a.description_nat 
		   ^ " \n Lieu: " ^ a.lieu_2 
		   ^ " \n Adresse: " ^ a.adresse 
		   ^ " \n Arrondissement: " ^ a.arrondissement 
		   ^ " \n Dates: " ^ a.date_deb ^ " a " ^ a.date_fin
		   ^ " \n Jour de la semaine: " ^ a.jour_semaine 
		   ^ " \n Heures: " ^ a.heure_deb ^ " a " ^ a.heure_fin ^ " \n ")				
   

   (* afficher_systeme_activites : sysactivites -> unit *)
   (* Permet d'afficher un système d'activités          *)

   let afficher_systeme_activites (sa:sysactivites) = match sa with
     | Vide ->  raise (Err "Le systeme d'activites est vide")
     | SysAct la -> iter afficher_activite  la

   (* lire_fichier : in_channel -> string -> string list list                     *)
   (* Lire un fichier CSV et retourne une lite de listes de chaînes de caractères *)
   (* en spécifiant le séparateur qu'il faut utiliser pour délimiter les chaînes  *)

   let rec lire_fichier (flux:in_channel) (separateur:string) = 
       let lines = ref [] in
         try
	   while true; do
	     lines := decouper_chaine (input_line flux) (separateur) :: !lines
	     done; []
	 with End_of_file -> rev !lines

   (* charger_donnees_sysactivites : sysactivites -> string -> sysactivites *)
   (* Charger le système d'activités à partir du fichier CSV                *)

   let charger_donnees_sysactivites (sa:sysactivites) (fichier:string) =
     ajouter_liste_activites (tl (lire_fichier (open_in fichier)("|"))) sa
   (* trouver_selon_arrondissement : sysactivites -> string -> activite list *)
   (* Retourner les activités qui se font dans un arrondissement spécifique  *)

   let trouver_selon_arrondissement (sa:sysactivites) (na:string) = match sa with
     | Vide ->  raise (Err "Le systeme d'activites est vide")
     | SysAct la -> filter(fun x -> (compare  x.arrondissement na) = 0 ) la

   (* trouver_selon_type : sysactivites -> string -> activite list *)
   (* Retourner les activités qui ont un type spécifique           *)

   let trouver_selon_type (sa:sysactivites) (ta:string) = match sa with
     | Vide -> raise (Err "Le systeme d'activites est vide")
     | SysAct la -> filter(fun x -> (compare  x.description_nat ta) = 0 ) la

   (* lister_arrondissements : sysactivites -> string list                *)
   (* Trouver tous les arrondissements uniques dans un système d'activités *)
   
   let lister_arrondissements (sa:sysactivites) = match sa with
     | Vide -> raise (Err "Le systeme d'activites est vide")
     | SysAct la -> uniques ( map (fun x -> x.arrondissement) la)

   (* lister_types_activites : sysactivites -> string list                    *)
   (* Trouver tous les types d'activités uniques dans un système d'activités  *)
   
   let lister_types_activites (sa:sysactivites) = match sa with
     | Vide -> raise (Err "Le systeme d'activites est vide")
     | SysAct la -> uniques ( map (fun x -> x.description_nat) la)
	 
	 
   (* typeAct : sysactivites -> string *)
   (* Retourne le type d'activite *)
    let typeAct  (sa:sysactivites) = 
	print_string ("Quel type (nature) d'activites vous interessent? \n");
      let types = lister_types_activites sa in 
	print_string (formater_chaine types);
      let n = length types in
	print_string ("\n Veuillez entrer un nombre entre 0 et " ^ string_of_int n ^ ": ");
	flush stdout;
	let x = int_of_string(input_line stdin) in
	if (x < 0) || (x > n) then 
	  raise (Err "Nombre incorrect, veuillez recommencer!")
	else if x = 6 then "" else nth (lister_types_activites sa) x

   (* typeArrond : sysactivites -> string *)
   (* Retourne le type d'arrondissment *)
   let arrondAct (sa:sysactivites) = 
	print_string ("\n Quel arrondissement vous interesse ? \n");
     let arrond = lister_arrondissements sa in
	print_string ( formater_chaine arrond);
     let n = length arrond in
	print_string (" \n  Veuillez entrer un nombre entre 0 et " ^ string_of_int n ^ ": ");
	flush stdout;
	let x = int_of_string(input_line stdin) in
	if (x < 0) || (x > n ) then
	  raise (Err "Nombre incorrect, veuillez recommencer!") 
	else if x = 6 then ""  
	else nth (lister_arrondissements sa) x 
	

   (* lancer_systeme_activites : sysactivites -> string -> unit                        *)
   (* Lancer le système d'activités afin de trouver les activités qui nous intéressent *)
   
    let lancer_systeme_activites (sa:sysactivites) (fichier:string) =
     print_string ("Outil de recherche du Centre de Loisirs de Quebec \n");
     let sys  =  charger_donnees_sysactivites (sa) (fichier) in
     let x = typeAct sys in 
     let sy = SysAct(trouver_selon_type sys x) in
     let y = arrondAct sys in
     let f =  SysAct(trouver_selon_arrondissement sy  y) in
	 afficher_systeme_activites f; 
         print_string(" \n Nombre d'activites trouvees: " ^ string_of_int (retourner_nbr_activites f));
         print_string(" \n Merci et au revoir!")
     
	

end
