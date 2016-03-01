(***********************************************************************)
(* Langages de Programmation: IFT 3000 NRC 11775                       *)
(* TP2 HIVER 2015. Date limite: Vendredi 24 avril à 17h                *) 
(* Implanter un système permettant de chercher des activités gratuites *)
(* et payantes en utilisant les données ouvertes de la ville de Québec *)
(***********************************************************************)
(*                                                                     *)
(* NOM: BEAUDOIN                    PRÉNOM:VINCENT                     *) 
(* MATRICULE: 111 103 778           PROGRAMME: IFT                     *)
(*                                                                     *)
(***********************************************************************)
(*                                                                     *)
(* NOM: PICARD-LEMIEUX              PRÉNOM:ALEXANDRE                   *) 
(* MATRICULE: 111 103 625           PROGRAMME: IFT                     *)
(*                                                                     *)
(***********************************************************************)

#load "unix.cma";; (* Charger le module unix *)
#load "str.cma";;  (* Charger le module Str  *)

(* Charger la signature du système d'activités *)
#use "TP2-SIG-H2015.mli";;

(********************************************************************) 
(* Implantation du système en utilisant                             *)
(* la programmation orientée objet                       	    *) 
(********************************************************************)

module Tp2h15 : TP2H15 = struct

  open List
  open Str

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

  (* retourner_epoque_secondes : string -> string -> string -> string -> float                 *)
  (* Retourne le nombre de secondes depuis l'année 1970 jusqu'à une date et une heure précises *)
  (* Exemple: let ep = retourner_epoque_secondes "2015-03-31" "-" "15:30:00" ":";;             *)
  (* val ep : float = 1427830200.                                                              *)

  let retourner_epoque_secondes (date:string) (sdate: string) (hms:string) (shms: string) =
    let d = decouper_chaine date sdate in
    let yyyy = int_of_string (nth d 0) and mm = int_of_string (nth d 1) and dd = int_of_string (nth d 2) in
    let tmp = decouper_chaine hms shms in
    let h = int_of_string (nth tmp 0) and m = int_of_string (nth tmp 1) and s = int_of_string (nth tmp 2) in
    let eg = {Unix.tm_sec = s; tm_min = m; tm_hour = h; tm_mday = dd; tm_mon = mm-1;
	      tm_year = yyyy-1900; tm_wday = 0; tm_yday = 0; tm_isdst = false} in fst(Unix.mktime eg)

  (* Classes du TP *)

  class activite (lch:string list) (ta:bool) = 
    object(self)
      val type_activite = ta
      val code_session : string = nth lch 0
      val description : string = nth lch 1
      val description_act : string = nth lch 2
      val description_nat : string = nth lch 3
      val nom_cour : string = nth lch 4
      val tarif_base : float = if ta then 0.0 else float_of_string (replace_first (regexp ",") "." (nth lch 5))
      val lieu_1 : string = if ta then nth lch 5 else nth lch 6
      val lieu_2 : string = if ta then nth lch 6 else nth lch 7
      val arrondissement : string = if ta then nth lch 7 else nth lch 8
      val adresse : string = if ta then nth lch 8 else nth lch 9
      val date_deb : string = if ta then nth lch 9 else nth lch 10
      val date_fin : string = if ta then nth lch 10 else nth lch 11
      val jour_semaine : string = if ta then nth lch 11 else nth lch 12
      val heure_deb : string = if ta then nth lch 12 else nth lch 13
      val heure_fin : string = if ta then nth lch 13 else nth lch 14
      method get_type_activite = type_activite
      method get_description = description
      method get_lieu_1 = lieu_1
      method get_adresse = adresse
      method get_jour_semaine = jour_semaine
      method get_arrondissement = arrondissement
      method get_description_nat = description_nat
      method get_tarif_base = tarif_base
      method get_date_deb = date_deb
      method get_heure_deb = heure_deb
      method get_date_fin = date_fin
      method get_heure_fin = heure_fin

      (* Méthode à implanter *)
      
      (* afficher_activite : unit *)
      method afficher_activite =
        print_string ("Description: " ^ description ^ ".\n");
        print_string ("Type: " ^ description_nat ^ ".\n");
        print_string ("Lieu: " ^ lieu_1 ^ ".\n");
        print_string ("Adresse: " ^ adresse ^ ".\n");
        print_string ("Arrondissement: " ^ arrondissement ^ ".\n");
        print_string ("Dates: " ^ date_deb ^ " au " ^ date_fin ^ ".\n");
        print_string ("Jour de la semaine: " ^ jour_semaine ^ ".\n");
        print_string ("Heures: " ^ heure_deb ^ " a " ^ heure_fin  ^ ".\n");
        if ta then print_string ("\n") else print_string ("Prix de l'activite: " ^ (string_of_float tarif_base) ^ "$\n\n")

    end

  class sysactivites (od:string) =
    object(self)
      val origine_donnees : string = od
      val mutable liste_activites : activite list = []
      method get_origine_donnees = origine_donnees
      method get_liste_activites = liste_activites
      method set_liste_activites (la:activite list) = liste_activites <- la
      method activite_existe (a:activite) = appartient a liste_activites
      method retourner_nbr_activites = length liste_activites

      (* Méthodes à implanter *)
      
      (* ajouter_activite : activite -> unit *)
      method ajouter_activite (a:activite) =
        if (self#activite_existe a) = false then
          liste_activites <- liste_activites @ [a]

      (* supprimer_activite : activite -> unit *)
      method supprimer_activite (a:activite) =
        if self#retourner_nbr_activites = 0 then
          failwith "Le systeme d'activites est vide"
        else if (self#activite_existe a) = false then
          failwith "Le systeme d'activites ne contient pas cette activite"
        else
          liste_activites <- enlever a liste_activites

      (* afficher_systeme_activites : unit *)
      method afficher_systeme_activites =
        if self#retourner_nbr_activites = 0 then
          failwith "Le systeme d'activites est vide"
        else
		  iter (fun a -> (a#afficher_activite)) liste_activites

      (* lire_fichier : in_channel -> string -> string list list *)
      method lire_fichier (flux:in_channel) (separateur:string) =
	    let read_line ic =
	      try
	        input_line ic
	      with End_of_file -> "" 
	    in
	      let ligne = read_line flux in
	        match ligne with
	          | "" -> []
	          | s -> (decouper_chaine s separateur)::(self#lire_fichier flux separateur)

      (* trouver_selon_arrondissement : string -> activite list *)
      method trouver_selon_arrondissement (na:string) =
	    if self#retourner_nbr_activites = 0 then
          failwith "Le systeme d'activites est vide"
        else
          filter (fun a -> a#get_arrondissement = na) liste_activites

      (* trouver_selon_type : string -> activite list *)
      method trouver_selon_type (ta:string) =
	    if self#retourner_nbr_activites = 0 then
          failwith "Le systeme d'activites est vide"
        else
          filter (fun a -> a#get_description_nat = ta) liste_activites

      (* lister_arrondissements : string list *)
      method lister_arrondissements =
	    if self#retourner_nbr_activites = 0 then
          failwith "Le systeme d'activites est vide"
        else
          uniques (map (fun a -> a#get_arrondissement) liste_activites)

      (* lister_types_activites : string list *)
      method lister_types_activites =
	    if self#retourner_nbr_activites = 0 then
          failwith "Le systeme d'activites est vide"
        else
          uniques (map (fun a -> a#get_description_nat) liste_activites)

    end

  class sysactivites_gratuites (au:string) (od:string) =
    object(self)
      inherit sysactivites od as parent
      val systeme_utilisees : string = au
      method get_systeme_utilisees = systeme_utilisees

      (* Méthodes à implanter *)

      (* ajouter_liste_activites : string list list -> unit *)
      method ajouter_liste_activites (lla:string list list) =
        iter (fun la -> parent#ajouter_activite (new activite la true)) lla

      (* charger_donnees_sysactivites : string -> unit *)
      method charger_donnees_sysactivites (fichier:string) =
        let ic = open_in fichier in
          let _ = input_line ic in
            let liste_lignes = parent#lire_fichier ic "|" in
              close_in ic;
              self#ajouter_liste_activites liste_lignes

      (* trier_activites : int -> unit *)
      method trier_activites (ordre:int) =
        if ordre < 1 or ordre > 2 then
          failwith "trier_activites: ordre incorrect!"
        else
          let comparer_activites (lhs:activite) (rhs:activite) =
            let trier =
              if ordre = 1 then
                (retourner_epoque_secondes lhs#get_date_deb "-" lhs#get_heure_deb ":", retourner_epoque_secondes rhs#get_date_deb "-" rhs#get_heure_deb ":")
              else
                (retourner_epoque_secondes lhs#get_date_fin "-" lhs#get_heure_fin ":", retourner_epoque_secondes rhs#get_date_fin "-" rhs#get_heure_fin ":")
              in
                if (fst trier) = (snd trier) then
                  0
                else if (fst trier) > (snd trier) then
                  1
                else
                  -1
                in
                  liste_activites <- List.sort comparer_activites liste_activites

      initializer print_string ("Recherche dans un " ^ (self#get_systeme_utilisees) ^ 
				" utilisant les " ^ (parent#get_origine_donnees) ^ ".");
				print_newline()
    end

  class sysactivites_payantes (au:string) (od:string) =
    object(self)
      inherit sysactivites od as parent
      val systeme_utilisees : string = au
      method get_systeme_utilisees = systeme_utilisees

      (* Méthodes à implanter *)

      (* ajouter_liste_activites : string list list -> unit *)
      method ajouter_liste_activites (lla:string list list) =
        iter (fun la -> parent#ajouter_activite (new activite la false)) lla

      (* charger_donnees_sysactivites : string -> unit *)
      method charger_donnees_sysactivites (fichier:string) =
        let ic = open_in fichier in
          let _ = input_line ic in
            let liste_lignes = parent#lire_fichier ic "|" in
              close_in ic;
              self#ajouter_liste_activites liste_lignes

      (* trier_activites : int -> unit *)
      method trier_activites (ordre:int) =
        if ordre < 1 or ordre > 3 then
          failwith "trier_activites: ordre incorrect!"
        else
          let comparer_activites (lhs:activite) (rhs:activite) =
            let trier =
              if ordre = 1 then
                (retourner_epoque_secondes lhs#get_date_deb "-" lhs#get_heure_deb ":", retourner_epoque_secondes rhs#get_date_deb "-" rhs#get_heure_deb ":")
              else if ordre = 2 then
                (retourner_epoque_secondes lhs#get_date_fin "-" lhs#get_heure_fin ":", retourner_epoque_secondes rhs#get_date_fin "-" rhs#get_heure_fin ":")
              else
                (lhs#get_tarif_base, rhs#get_tarif_base)
              in
                if (fst trier) = (snd trier) then
                  0
                else if (fst trier) > (snd trier) then
                  1
                else
                  -1
                in
                  liste_activites <- List.sort comparer_activites liste_activites
 
      initializer print_string ("Recherche dans un " ^ (self#get_systeme_utilisees) ^ 
				" utilisant les " ^ (parent#get_origine_donnees) ^ ".");
				print_newline()
    end

  class app_sysactivites (nfa:string) (nfp:string) =
    object(self)
      val nom_fichier_agratuites = nfa
      val nom_fichier_apayantes = nfp

      (* Méthodes à implanter *)

      (* sauvegarder_liste_activites : activite list -> out_channel -> unit *)      
      method sauvegarder_liste_activites (la:activite list) (flux:out_channel) =
	    if (length la) = 0 then failwith "Le systeme d'activites est vide"
		else let ecrire (a:activite) = 
          output_string flux ("Description: " ^ a#get_description ^ ".\n");
          output_string flux ("Type: " ^ a#get_description_nat ^ ".\n");
          output_string flux ("Lieu: " ^ a#get_lieu_1 ^ ".\n");
          output_string flux ("Adresse: " ^ a#get_adresse ^ ".\n");
          output_string flux ("Arrondissement: " ^ a#get_arrondissement ^ ".\n");
          output_string flux ("Dates: " ^ a#get_date_deb ^ " au " ^ a#get_date_fin ^ ".\n");
          output_string flux ("Jour de la semaine: " ^ a#get_jour_semaine ^ ".\n");
          output_string flux ("Heures: " ^ a#get_heure_deb ^ " a " ^ a#get_heure_fin  ^ ".\n");
          if a#get_type_activite then output_string flux ("\n") else output_string flux ("Prix de l'activite: " ^ (string_of_float a#get_tarif_base) ^ "$\n\n")
        in iter ecrire la

      (* lancer_systeme_activites : unit *) 
      method lancer_systeme_activites =
        print_string "Bienvenue a l'outil de recherche du Centre de Losirs de Quebec\n";
        print_string "Quel type d'activites vous interessent?\n";
        print_string "1- Activites gratuites.\n";
        print_string "2- Activites payantes.\n";
        print_string ("Veuillez choisir une option (1 ou 2):? ");
        flush stdout;
        let choix = int_of_string (input_line stdin) in
        let sa = if (choix = 1) then (new sysactivites_gratuites "systeme d'activites gratuites" "donnees ouvertes de la ville de Quebec")
                 else if (choix = 2) then (new sysactivites_payantes "systeme d'activites payantes" "donnees ouvertes de la ville de Quebec")
                 else failwith "Nombre incorrect, veuillez recommencer!" in
        let ta = if (choix = 1) then true
                 else false in
        if ta then (sa#charger_donnees_sysactivites nom_fichier_agratuites)
        else (sa#charger_donnees_sysactivites nom_fichier_apayantes);
        print_string "Quel type (nature) d'activites vous interessent?\n";
        let liste_types = sa#lister_types_activites in
        let nbt = length liste_types in
        let liste_arrs = sa#lister_arrondissements in
        let nba = length liste_arrs in
        print_string (formater_chaine liste_types);
        print_string ("Veuillez entrer un nombre entre 0 et " ^ string_of_int (nbt) ^ ":? ");
        flush stdout;
        let choix = int_of_string (input_line stdin) in
        let sa = if (choix = nbt) then sa
                 else if (choix >= 0 && choix < nbt) then ((sa#set_liste_activites (sa#trouver_selon_type (nth liste_types choix))); sa)
                 else failwith "Nombre incorrect, veuillez recommencer!" in
        print_string "\nQuel arrondissement vous interesse?\n";
        print_string (formater_chaine liste_arrs);
        print_string ("Veuillez entrer un nombre entre 0 et " ^ string_of_int (nba) ^ ":? ");
        flush stdout;
        let choix = int_of_string (input_line stdin) in
        let sa = if (choix = nba) then sa
                 else if (choix >= 0 && choix < nba) then ((sa#set_liste_activites (sa#trouver_selon_arrondissement (nth liste_arrs choix))); sa)
                 else failwith "Nombre incorrect, veuillez recommencer!" in
        print_string "\nVoici le resultat de la recherche:\n";
        sa#afficher_systeme_activites;
        print_string ("\nNombre d'activites trouvees: " ^ (string_of_int sa#retourner_nbr_activites) ^ "\n\n");
        print_string "Voulez-vous trier le resultat de la recherche?\n";
        print_string "1- Selon la date et l'heure de début.\n";
        print_string "2- Selon la date et l'heure de fin.\n";
        if ta then (print_string "3- Non, merci!.\n"; print_string "Veuillez choisir une option (1 a 3):? ")
        else (print_string "3- Selon le tarif de base.\n"; print_string "4- Non, merci!.\n"; print_string "Veuillez choisir une option (1 a 4):? ");
        flush stdout;
        let choix = int_of_string (input_line stdin) in
        if (choix <> 3 || ta = false) && (choix <> 4 || ta) then (sa#trier_activites choix;
                                                                 print_string "\nVoici la liste triee:\n\n";
                                                                 sa#afficher_systeme_activites);
        print_string "\nVoulez-vous sauvegarder le resultat de recherche?\n";
        print_string "1- Dans un fichier 'Resultats.txt'.\n";
        print_string "2- Non merci!.\n";
        print_string ("Veuillez choisir une option (1 ou 2):? ");
        flush stdout;
        let choix = int_of_string (input_line stdin) in
        if (choix = 1) then (let file = open_out "Resultats.txt" in
                             self#sauvegarder_liste_activites (sa#get_liste_activites) file;
                             close_out file;
                             print_string "\nVeuillez consulter le fichier 'Resultats.txt' dans votre repertoire courant!\n")
        else if (choix = 2) then ()
        else failwith "Nombre incorrect, veuillez recommencer!";
        print_string "\nMerci est au revoir!\n\n"

      initializer self#lancer_systeme_activites

    end

end
