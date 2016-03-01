(*********************************************************************)
(* Langages de Programmation: IFT 3000 NRC 11775                     *)
(* TP1 HIVER 2015. Date limite: Vendredi 6 mars à 17h                *) 
(* Implanter un système permettant de chercher des activités         *)
(* gratuites en utilisant les données ouvertes de la ville de Québec *)
(*********************************************************************)
(*********************************************************************) 
(* Signature du système des activités                                *)  
(*********************************************************************)

module type SYSACTIVITES = sig

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

  val initialiser_system : unit -> sysactivites
  
  val creer_activite : string list -> activite

  val activite_existe : activite -> sysactivites -> bool

  val retourner_nbr_activites : sysactivites -> int

  val ajouter_activite : activite -> sysactivites -> sysactivites

  val supprimer_activite : activite -> sysactivites -> sysactivites

  val afficher_activite : activite -> unit

  val afficher_systeme_activites : sysactivites -> unit

  val ajouter_liste_activites : string list list -> sysactivites -> sysactivites

  val lire_fichier : in_channel -> string -> string list list

  val charger_donnees_sysactivites : sysactivites -> string -> sysactivites

  val trouver_selon_arrondissement : sysactivites -> string -> activite list

  val trouver_selon_type : sysactivites -> string -> activite list

  val lister_arrondissements : sysactivites -> string list

  val lister_types_activites : sysactivites -> string list

  val lancer_systeme_activites : sysactivites -> string -> unit

end
