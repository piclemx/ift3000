(***************************************************************************) 
(* Jeu d'essai - TP1 - HIVER 2015                                          *) 
(***************************************************************************)

(* Pour changer ou obtenir le répertoire courant
Sys.getcwd ();;
Sys.chdir;; 
*)

(* Pour afficher les listes avec plus de «profondeurs»:
#print_depth 1000;;
#print_length 1000;;
*)

(* On charge le fichier ml du Tp après avoir implanté 
les fonctions demandées pour realiser les tests  *)
 
#use "TP1-H2015.ml";;

(* Résultat:
module type SYSACTIVITES =
  sig
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
    val ajouter_liste_activites :
      string list list -> sysactivites -> sysactivites
    val lire_fichier : in_channel -> string -> string list list
    val charger_donnees_sysactivites : sysactivites -> string -> sysactivites
    val trouver_selon_arrondissement :
      sysactivites -> string -> activite list
    val trouver_selon_type : sysactivites -> string -> activite list
    val lister_arrondissements : sysactivites -> string list
    val lister_types_activites : sysactivites -> string list
    val lancer_systeme_activites : sysactivites -> string -> unit
  end
module SysActivites : SYSACTIVITES
*)

(* On ouvre le module disposant de fonctions pertinentes pour nos tests *) 
open SysActivites;;

(* On exécute maintenant les fonctions une à une *)

let sa = initialiser_system ();;

(* Résultat:
val sa : SysActivites.sysactivites = Vide
*)

let a1 = creer_activite ["P2015";"Aquaforme";"Aquaforme";"Activites aquatiques";"YWCA Quebec";"Y.W.C.A";
			 "Y.W.C.A. piscine";"Arrondissement de La Cite-Limoilou";
			 "855, avenue Holland, Quebec (QC) G1S 3S5";
			 "2015-05-01";"2015-06-19";"Vendredi";"10:30:00";"11:25:00"];;

(* Résultat:
val a1 : SysActivites.activite =
  {code_session = "P2015"; description = "Aquaforme";
   description_act = "Aquaforme"; description_nat = "Activites aquatiques";
   nom_cour = "YWCA Quebec"; lieu_1 = "Y.W.C.A"; lieu_2 = "Y.W.C.A. piscine";
   arrondissement = "Arrondissement de La Cite-Limoilou";
   adresse = "855, avenue Holland, Quebec (QC) G1S 3S5";
   date_deb = "2015-05-01"; date_fin = "2015-06-19";
   jour_semaine = "Vendredi"; heure_deb = "10:30:00"; heure_fin = "11:25:00"}
*)

let sa = ajouter_activite a1 sa;;

(* Résultat:
val sa : SysActivites.sysactivites =
  SysAct
   [{code_session = "P2015"; description = "Aquaforme";
     description_act = "Aquaforme"; description_nat = "Activites aquatiques";
     nom_cour = "YWCA Quebec"; lieu_1 = "Y.W.C.A";
     lieu_2 = "Y.W.C.A. piscine";
     arrondissement = "Arrondissement de La Cite-Limoilou";
     adresse = "855, avenue Holland, Quebec (QC) G1S 3S5";
     date_deb = "2015-05-01"; date_fin = "2015-06-19";
     jour_semaine = "Vendredi"; heure_deb = "10:30:00";
     heure_fin = "11:25:00"}]
*)

activite_existe a1 sa;;

(* Résultat:
- : bool = true
*)

let na = retourner_nbr_activites sa;;

(* Résultat:
val na : int = 1
*)


afficher_activite a1;;

(*
Description: Aquaforme.
Type: Activites aquatiques.
Lieu: Y.W.C.A.
Adresse: 855, avenue Holland, Quebec (QC) G1S 3S5.
Arrondissement: Arrondissement de La Cite-Limoilou.
Dates: 2015-05-01 au 2015-06-19.
Jour de la semaine: Vendredi.
Heures: 10:30:00 a 11:25:00.

- : unit = ()
*)


let sa = supprimer_activite a1 sa;;

(* Résultat:
val sa : SysActivites.sysactivites = SysAct []
*)

let sa = ajouter_liste_activites [["P2015";"Aquaforme";"Aquaforme";"Activites aquatiques";
				   "YWCA Quebec";"Y.W.C.A";"Y.W.C.A. piscine";
				   "Arrondissement de La Cite-Limoilou";
				   "855, avenue Holland, Quebec (QC) G1S 3S5";
				   "2015-05-01";"2015-06-19";"Vendredi";"10:30:00";"11:25:00"];
				  ["H2015";"Billard libre";"Billard libre";"Loisirs recreatifs";
				   "Club FADOQ Bonne-Entente inc.";"Centre de loisirs Saint-Benoit";
				   "Salle RC03-01";"Arrondissement Sainte-Foy-Sillery-Cap-Rouge";
				   "909, boulevard Pie-XII, Quebec (QC) G1X 3T4";
				   "2015-01-12";"2015-04-27";"Jeudi";"09:00:00";"11:30:00"]] sa;;


(* Résultat:
val sa : SysActivites.sysactivites =
  SysAct
   [{code_session = "P2015"; description = "Aquaforme";
     description_act = "Aquaforme"; description_nat = "Activites aquatiques";
     nom_cour = "YWCA Quebec"; lieu_1 = "Y.W.C.A";
     lieu_2 = "Y.W.C.A. piscine";
     arrondissement = "Arrondissement de La Cite-Limoilou";
     adresse = "855, avenue Holland, Quebec (QC) G1S 3S5";
     date_deb = "2015-05-01"; date_fin = "2015-06-19";
     jour_semaine = "Vendredi"; heure_deb = "10:30:00";
     heure_fin = "11:25:00"};
    {code_session = "H2015"; description = "Billard libre";
     description_act = "Billard libre";
     description_nat = "Loisirs recreatifs";
     nom_cour = "Club FADOQ Bonne-Entente inc.";
     lieu_1 = "Centre de loisirs Saint-Benoit"; lieu_2 = "Salle RC03-01";
     arrondissement = "Arrondissement Sainte-Foy-Sillery-Cap-Rouge";
     adresse = "909, boulevard Pie-XII, Quebec (QC) G1X 3T4";
     date_deb = "2015-01-12"; date_fin = "2015-04-27";
     jour_semaine = "Jeudi"; heure_deb = "09:00:00"; heure_fin = "11:30:00"}]
*)


afficher_systeme_activites sa;;

(* Résultat:
Description: Aquaforme.
Type: Activites aquatiques.
Lieu: Y.W.C.A.
Adresse: 855, avenue Holland, Quebec (QC) G1S 3S5.
Arrondissement: Arrondissement de La Cite-Limoilou.
Dates: 2015-05-01 au 2015-06-19.
Jour de la semaine: Vendredi.
Heures: 10:30:00 a 11:25:00.

Description: Billard libre.
Type: Loisirs recreatifs.
Lieu: Centre de loisirs Saint-Benoit.
Adresse: 909, boulevard Pie-XII, Quebec (QC) G1X 3T4.
Arrondissement: Arrondissement Sainte-Foy-Sillery-Cap-Rouge.
Dates: 2015-01-12 au 2015-04-27.
Jour de la semaine: Jeudi.
Heures: 09:00:00 a 11:30:00.

- : unit = ()
*)

let file = open_in "LOISIR_LIBRE.CSV";;
let lla = lire_fichier file "|";;
close_in file;;

(* Résultat:
val file : in_channel = <abstr>
# val lla : string list list =
  [["ï»¿CODE_SESSION"; "DESCRIPTION"; "DESCRIPTION_ACT"; "DESCRIPTION_NAT";
    "NOM_COUR"; "LIEU_1"; "LIEU_2"; "ARRONDISSEMENT"; "ADRESSE"; "DATE_DEB";
    "DATE_FIN"; "JOUR_SEMAINE"; "HEURE_DEBUT"; "HEURE_FIN"];
   ["H2015"; "Adolescents(es)"; "Adolescents(es)"; "Loisirs jeunesse";
    "Maison des jeunes de Beauport Ouest"; "Parc La Ribambelle";
    "Ecole la Ribambelle gymnase"; "Arrondissement de Beauport";
    "333, rue Perroteau, Quebec (QC) G1C 5Z4 "; "2015-01-05"; "2015-06-20";
    "Jeudi"; "18:00:00"; "22:00:00"];
   ["H2015"; "Centre de jour Feu Vert"; "Centre de jour Feu Vert";
    "Loisirs recreatifs"; "Centre de jour Feu Vert inc. (secteur Beauport)";
    "Centre de loisirs La Sabliere"; "La Sabliere petite salleÂ­";
    "Arrondissement de Beauport"; "156, rue Bertrand, Quebec (QC) G1B 1H7 ";
    "2015-01-06"; "2015-06-26"; "Mardi"; "08:30:00"; "15:30:00"];
   ["P2015"; "Badminton - Groupe communautaire";
    "Badminton - Groupe communautaire"; "Sports et de plein air";
    "Loisirs et Sports Neufchatel inc."; "Centre recreatif Apprenti-Sage";
    "Centre recreatif Apprenti-Sage \\ gymnase simple";
    "Arrondissement des Rivieres"; "2200, rue Coursol, Quebec (QC) G2B 4Y4 ";
    "2015-04-30"; "2015-07-16"; "Jeudi"; "20:00:00"; "22:00:00"];
   ["P2015"; "Hockey interieur - Groupe communautaire";
    "Hockey interieur - Groupe communautaire"; "Sports et de plein air";
    "Loisirs et Sports Neufchatel inc."; "Centre recreatif Apprenti-Sage";
    "Centre recreatif Apprenti-Sage \\ gymnase simple";
    "Arrondissement des Rivieres"; "2200, rue Coursol, Quebec (QC) G2B 4Y4 ";
    "2015-05-03"; "2015-07-19"; "Dimanche"; "16:00:00"; "17:30:00"];
   ["P2015"; "Hockey interieur - Groupe communautaire";
    "Hockey interieur - Groupe communautaire"; "Sports et de plein air";
    "Loisirs et Sports Neufchatel inc."; "Centre recreatif Apprenti-Sage";
    "Centre comm. C.-A.-Savard \\ gymnase simple SS109-2-3-4";
    "Arrondissement des Rivieres"; "2200, rue Coursol, Quebec (QC) G2B 4Y4 ";
    "2015-05-01"; "2015-07-17"; "Vendredi"; "16:30:00"; "17:30:00"];
   ["H2015"; "Maison des jeunes Neufchatel"; "Maison des jeunes Neufchatel";
    "Loisirs jeunesse"; "Maison des jeunes de St-Andre de Neufchatel (La)";
    "Pavillon de service Saint-Andre";
    "Pav. de service Saint-Andre \\ salle rez-de-chaussee";
    "Arrondissement des Rivieres";
    "2125, boulevard Bastien, Quebec (QC) G2B 1B8 "; "2015-01-01";
    "2015-03-31"; "Mercredi"; "18:00:00"; "22:00:00"];
   ["H2015"; "Maison des jeunes Neufchatel"; "Maison des jeunes Neufchatel";
    "Loisirs jeunesse"; "Maison des jeunes de St-Andre de Neufchatel (La)";
    "Pavillon de service Saint-Andre";
    "Pav. de service Saint-Andre \\ salle rez-de-chaussee";
    "Arrondissement des Rivieres";
    "2125, boulevard Bastien, Quebec (QC) G2B 1B8 "; "2015-01-01";
    "2015-03-31"; "Vendredi"; "17:00:00"; "23:00:00"];
   ["P2015"; "Maison des jeunes Neufchatel"; "Maison des jeunes Neufchatel";
    "Loisirs jeunesse"; "Maison des jeunes de St-Andre de Neufchatel (La)";
    "Pavillon de service Saint-Andre";
    "Pav. de service Saint-Andre \\ salle rez-de-chaussee";
    "Arrondissement des Rivieres";
    "2125, boulevard Bastien, Quebec (QC) G2B 1B8 "; "2015-04-01";
    "2015-06-30"; "Mercredi"; "18:00:00"; "22:00:00"];
   ["E2015"; "Evenement special - Fete nationale"; "Evenement special";
    "Evenement special"; "Loisirs et Sports Neufchatel inc.";
    "Centre communautaire Charles-Auguste-Savard";
    "Centre comm. C.-A.-Savard \\ p. salle SS-105";
    "Arrondissement des Rivieres";
    "2155, boulevard Bastien, Quebec (QC) G2B 1B8 "; "2015-06-24";
    "2015-06-24"; "Mercredi"; "08:00:00"; "23:59:00"];
   ["E2015"; "Evenement special - Fete nationale"; "Evenement special";
    "Evenement special"; "Loisirs et Sports Neufchatel inc.";
    "Centre communautaire Charles-Auguste-Savard";
    "Parc St-Andre \\ tennis 1-2"; "Arrondissement des Rivieres";
    "2155, boulevard Bastien, Quebec (QC) G2B 1B8 "; "2015-06-24";
    "2015-06-24"; "Mercredi"; "08:00:00"; "23:59:00"];
   ["E2015"; "Evenement special - Festi-Parc"; "Evenement special";
    "Evenement special"; "Loisirs et Sports Neufchatel inc.";
    "Centre communautaire Charles-Auguste-Savard";
    "Parc Saint-Andre \\ patinoire exterieure 4 saisons";
    "Arrondissement des Rivieres";
    "2155, boulevard Bastien, Quebec (QC) G2B 1B8 "; "2015-08-13";
    "2015-08-16"; "Dimanche"; "18:00:00"; "23:59:00"];
   ["E2015"; "Evenement special - Festi-Parc"; "Evenement special";
    "Evenement special"; "Loisirs et Sports Neufchatel inc.";
    "Centre communautaire Charles-Auguste-Savard";
    "Parc St-Andre \\ tennis 1-2"; "Arrondissement des Rivieres";
    "2155, boulevard Bastien, Quebec (QC) G2B 1B8 "; "2015-08-13";
    "2015-08-16"; "Dimanche"; "18:00:00"; "23:59:00"];
   ["E2015"; "Evenement special - Festi-Parc"; "Evenement special";
    "Evenement special"; "Loisirs et Sports Neufchatel inc.";
    "Centre communautaire Charles-Auguste-Savard";
    "Centre comm. C.-A.-Savard \\ p. salle SS-101-1";
    "Arrondissement des Rivieres";
    "2155, boulevard Bastien, Quebec (QC) G2B 1B8 "; "2015-08-13";
    "2015-08-16"; "Samedi"; "08:00:00"; "23:59:00"];
   ["H2015"; "Badminton pratique organisee"; "Badminton pratique organisee";
    "Activites physiques"; "Loisirs Montcalm inc (Les)";
    "Centre des loisirs Montcalm"; "CC Lucien-Borne gymnase simple B";
    "Arrondissement de La Cite-Limoilou";
    "265, boulevard Rene-Levesque Ouest, Quebec (QC) G1R 2A7 "; "2015-01-07";
    "2015-04-29"; "Mercredi"; "18:30:00"; "20:00:00"];
   ["P2015"; "Volleyball libre"; "Volleyball libre";
    "Sports et de plein air"; "Loisirs Du Plateau de Charlesbourg inc.";
    "Parc Maurice-Dorion"; "Parc Maurice-Dorion";
    "Arrondissement de Charlesbourg";
    "8815, avenue Jean-Paquin, Quebec (QC) G1G 4W7 "; "2015-06-01";
    "2015-09-06"; "Mercredi"; "08:00:00"; "22:00:00"];
   ["P2015"; "Volleyball libre"; "Volleyball libre";
    "Sports et de plein air"; "Loisirs Du Plateau de Charlesbourg inc.";
    "Parc Maurice-Dorion"; "Parc Maurice-Dorion";
    "Arrondissement de Charlesbourg";
    "8815, avenue Jean-Paquin, Quebec (QC) G1G 4W7 "; "2015-06-01";
    "2015-09-06"; "Jeudi"; "08:00:00"; "22:00:00"];
   ["P2015"; "Volleyball libre"; "Volleyball libre";
    "Sports et de plein air"; "Loisirs Du Plateau de Charlesbourg inc.";
    "Parc Maurice-Dorion"; "Parc Maurice-Dorion";
    "Arrondissement de Charlesbourg";
    "8815, avenue Jean-Paquin, Quebec (QC) G1G 4W7 "; "2015-06-01";
    "2015-09-06"; "Samedi"; "08:00:00"; "22:00:00"];
   ["P2015"; "Collectifs"; "Collectifs"; "Exposition";
    "Societe artistique de Charlesbourg S.A.C.";
    "Galerie d'art Magella-Paradis"; "Maison Pierre-Lefevbre - Etage";
    "Arrondissement de Charlesbourg";
    "7970, Le Trait-Carre Ouest, Quebec (QC) G1H 4P4 "; "2015-04-12";
    "2015-05-24"; "Dimanche"; "13:00:00"; "17:00:00"];
   ["E2015"; "Â« On se dessine les uns les autres Â»";
    "Â« On se dessine les uns les autres Â»"; "Arts visuels";
    "Societe artistique de Charlesbourg S.A.C.";
    "Galerie d'art Magella-Paradis"; "Maison Magella-Paradis Salle d'entree";
    "Arrondissement de Charlesbourg";
    "7970, Le Trait-Carre Ouest, Quebec (QC) G1H 4P4 "; "2015-07-26";
    "2015-07-26"; "Dimanche"; "11:00:00"; ...];
   ...]
# - : unit = ()
*)

let sa = initialiser_system ();;
let sa = charger_donnees_sysactivites sa "LOISIR_LIBRE.CSV";;

(* Résultat:
val sa : SysActivites.sysactivites = Vide
# val sa : SysActivites.sysactivites =
  SysAct
   [{code_session = "H2015"; description = "Adolescents(es)";
     description_act = "Adolescents(es)";
     description_nat = "Loisirs jeunesse";
     nom_cour = "Maison des jeunes de Beauport Ouest";
     lieu_1 = "Parc La Ribambelle"; lieu_2 = "Ecole la Ribambelle gymnase";
     arrondissement = "Arrondissement de Beauport";
     adresse = "333, rue Perroteau, Quebec (QC) G1C 5Z4 ";
     date_deb = "2015-01-05"; date_fin = "2015-06-20";
     jour_semaine = "Jeudi"; heure_deb = "18:00:00"; heure_fin = "22:00:00"};
    {code_session = "H2015"; description = "Centre de jour Feu Vert";
     description_act = "Centre de jour Feu Vert";
     description_nat = "Loisirs recreatifs";
     nom_cour = "Centre de jour Feu Vert inc. (secteur Beauport)";
     lieu_1 = "Centre de loisirs La Sabliere";
     lieu_2 = "La Sabliere petite salleÂ­";
     arrondissement = "Arrondissement de Beauport";
     adresse = "156, rue Bertrand, Quebec (QC) G1B 1H7 ";
     date_deb = "2015-01-06"; date_fin = "2015-06-26";
     jour_semaine = "Mardi"; heure_deb = "08:30:00"; heure_fin = "15:30:00"};
    {code_session = "P2015";
     description = "Badminton - Groupe communautaire";
     description_act = "Badminton - Groupe communautaire";
     description_nat = "Sports et de plein air";
     nom_cour = "Loisirs et Sports Neufchatel inc.";
     lieu_1 = "Centre recreatif Apprenti-Sage";
     lieu_2 = "Centre recreatif Apprenti-Sage \\ gymnase simple";
     arrondissement = "Arrondissement des Rivieres";
     adresse = "2200, rue Coursol, Quebec (QC) G2B 4Y4 ";
     date_deb = "2015-04-30"; date_fin = "2015-07-16";
     jour_semaine = "Jeudi"; heure_deb = "20:00:00"; heure_fin = "22:00:00"};
    {code_session = "P2015";
     description = "Hockey interieur - Groupe communautaire";
     description_act = "Hockey interieur - Groupe communautaire";
     description_nat = "Sports et de plein air";
     nom_cour = "Loisirs et Sports Neufchatel inc.";
     lieu_1 = "Centre recreatif Apprenti-Sage";
     lieu_2 = "Centre recreatif Apprenti-Sage \\ gymnase simple";
     arrondissement = "Arrondissement des Rivieres";
     adresse = "2200, rue Coursol, Quebec (QC) G2B 4Y4 ";
     date_deb = "2015-05-03"; date_fin = "2015-07-19";
     jour_semaine = "Dimanche"; heure_deb = "16:00:00";
     heure_fin = "17:30:00"};
    {code_session = "P2015";
     description = "Hockey interieur - Groupe communautaire";
     description_act = "Hockey interieur - Groupe communautaire";
     description_nat = "Sports et de plein air";
     nom_cour = "Loisirs et Sports Neufchatel inc.";
     lieu_1 = "Centre recreatif Apprenti-Sage";
     lieu_2 = "Centre comm. C.-A.-Savard \\ gymnase simple SS109-2-3-4";
     arrondissement = "Arrondissement des Rivieres";
     adresse = "2200, rue Coursol, Quebec (QC) G2B 4Y4 ";
     date_deb = "2015-05-01"; date_fin = "2015-07-17";
     jour_semaine = "Vendredi"; heure_deb = "16:30:00";
     heure_fin = "17:30:00"};
    {code_session = "H2015"; description = "Maison des jeunes Neufchatel";
     description_act = "Maison des jeunes Neufchatel";
     description_nat = "Loisirs jeunesse";
     nom_cour = "Maison des jeunes de St-Andre de Neufchatel (La)";
     lieu_1 = "Pavillon de service Saint-Andre";
     lieu_2 = "Pav. de service Saint-Andre \\ salle rez-de-chaussee";
     arrondissement = "Arrondissement des Rivieres";
     adresse = "2125, boulevard Bastien, Quebec (QC) G2B 1B8 ";
     date_deb = "2015-01-01"; date_fin = "2015-03-31";
     jour_semaine = "Mercredi"; heure_deb = "18:00:00";
     heure_fin = "22:00:00"};
    {code_session = "H2015"; description = "Maison des jeunes Neufchatel";
     description_act = "Maison des jeunes Neufchatel";
     description_nat = "Loisirs jeunesse";
     nom_cour = "Maison des jeunes de St-Andre de Neufchatel (La)";
     lieu_1 = "Pavillon de service Saint-Andre";
     lieu_2 = "Pav. de service Saint-Andre \\ salle rez-de-chaussee";
     arrondissement = "Arrondissement des Rivieres";
     adresse = "2125, boulevard Bastien, Quebec (QC) G2B 1B8 ";
     date_deb = "2015-01-01"; date_fin = "2015-03-31";
     jour_semaine = "Vendredi"; heure_deb = "17:00:00";
     heure_fin = "23:00:00"};
    {code_session = "P2015"; description = "Maison des jeunes Neufchatel";
     description_act = "Maison des jeunes Neufchatel";
     description_nat = "Loisirs jeunesse";
     nom_cour = "Maison des jeunes de St-Andre de Neufchatel (La)";
     lieu_1 = "Pavillon de service Saint-Andre";
     lieu_2 = "Pav. de service Saint-Andre \\ salle rez-de-chaussee";
     arrondissement = "Arrondissement des Rivieres";
     adresse = "2125, boulevard Bastien, Quebec (QC) G2B 1B8 ";
     date_deb = "2015-04-01"; date_fin = "2015-06-30";
     jour_semaine = "Mercredi"; heure_deb = "18:00:00";
     heure_fin = "22:00:00"};
    {code_session = "E2015";
     description = "Evenement special - Fete nationale";
     description_act = "Evenement special";
     description_nat = "Evenement special";
     nom_cour = "Loisirs et Sports Neufchatel inc.";
     lieu_1 = "Centre communautaire Charles-Auguste-Savard";
     lieu_2 = "Centre comm. C.-A.-Savard \\ p. salle SS-105";
     arrondissement = "Arrondissement des Rivieres";
     adresse = "2155, boulevard Bastien, Quebec (QC) G2B 1B8 ";
     date_deb = "2015-06-24"; date_fin = "2015-06-24";
     jour_semaine = "Mercredi"; heure_deb = "08:00:00";
     heure_fin = "23:59:00"};
    {code_session = "E2015";
     description = "Evenement special - Fete nationale";
     description_act = "Evenement special";
     description_nat = "Evenement special";
     nom_cour = "Loisirs et Sports Neufchatel inc.";
     lieu_1 = "Centre communautaire Charles-Auguste-Savard";
     lieu_2 = "Parc St-Andre \\ tennis 1-2";
     arrondissement = "Arrondissement des Rivieres";
     adresse = "2155, boulevard Bastien, Quebec (QC) G2B 1B8 ";
     date_deb = "2015-06-24"; date_fin = "2015-06-24";
     jour_semaine = "Mercredi"; heure_deb = "08:00:00";
     heure_fin = "23:59:00"};
    {code_session = "E2015"; description = "Evenement special - Festi-Parc";
     description_act = "Evenement special";
     description_nat = "Evenement special";
     nom_cour = "Loisirs et Sports Neufchatel inc.";
     lieu_1 = "Centre communautaire Charles-Auguste-Savard";
     lieu_2 = "Parc Saint-Andre \\ patinoire exterieure 4 saisons";
     arrondissement = "Arrondissement des Rivieres";
     adresse = "2155, boulevard Bastien, Quebec (QC) G2B 1B8 ";
     date_deb = "2015-08-13"; date_fin = "2015-08-16";
     jour_semaine = "Dimanche"; heure_deb = "18:00:00";
     heure_fin = "23:59:00"};
    {code_session = "E2015"; description = "Evenement special - Festi-Parc";
     description_act = "Evenement special";
     description_nat = "Evenement special";
     nom_cour = "Loisirs et Sports Neufchatel inc.";
     lieu_1 = "Centre communautaire Charles-Auguste-Savard";
     lieu_2 = "Parc St-Andre \\ tennis 1-2";
     arrondissement = "Arrondissement des Rivieres";
     adresse = "2155, boulevard Bastien, Quebec (QC) G2B 1B8 ";
     date_deb = "2015-08-13"; date_fin = "2015-08-16";
     jour_semaine = "Dimanche"; heure_deb = "18:00:00";
     heure_fin = "23:59:00"};
    {code_session = "E2015"; description = "Evenement special - Festi-Parc";
     description_act = "Evenement special";
     description_nat = "Evenement special";
     nom_cour = "Loisirs et Sports Neufchatel inc.";
     lieu_1 = "Centre communautaire Charles-Auguste-Savard";
     lieu_2 = "Centre comm. C.-A.-Savard \\ p. salle SS-101-1";
     arrondissement = "Arrondissement des Rivieres";
     adresse = "2155, boulevard Bastien, Quebec (QC) G2B 1B8 ";
     date_deb = "2015-08-13"; date_fin = "2015-08-16";
     jour_semaine = "Samedi"; heure_deb = "08:00:00"; heure_fin = "23:59:00"};
    {code_session = "H2015"; description = "Badminton pratique organisee";
     description_act = "Badminton pratique organisee";
     description_nat = "Activites physiques";
     nom_cour = "Loisirs Montcalm inc (Les)";
     lieu_1 = "Centre des loisirs Montcalm";
     lieu_2 = "CC Lucien-Borne gymnase simple B";
     arrondissement = "Arrondissement de La Cite-Limoilou";
     adresse = "265, boulevard Rene-Levesque Ouest, Quebec (QC) G1R 2A7 ";
     date_deb = "2015-01-07"; date_fin = "2015-04-29";
     jour_semaine = "Mercredi"; heure_deb = "18:30:00";
     heure_fin = "20:00:00"};
    {code_session = "P2015"; description = "Volleyball libre";
     description_act = "Volleyball libre";
     description_nat = "Sports et de plein air";
     nom_cour = "Loisirs Du Plateau de Charlesbourg inc.";
     lieu_1 = "Parc Maurice-Dorion"; lieu_2 = "Parc Maurice-Dorion";
     arrondissement = "Arrondissement de Charlesbourg";
     adresse = "8815, avenue Jean-Paquin, Quebec (QC) G1G 4W7 ";
     date_deb = "2015-06-01"; date_fin = "2015-09-06";
     jour_semaine = "Mercredi"; heure_deb = "08:00:00";
     heure_fin = "22:00:00"};
    {code_session = "P2015"; description = "Volleyball libre";
     description_act = "Volleyball libre";
     description_nat = "Sports et de plein air";
     nom_cour = "Loisirs Du Plateau de Charlesbourg inc.";
     lieu_1 = "Parc Maurice-Dorion"; lieu_2 = "Parc Maurice-Dorion";
     arrondissement = "Arrondissement de Charlesbourg";
     adresse = "8815, avenue Jean-Paquin, Quebec (QC) G1G 4W7 ";
     date_deb = "2015-06-01"; date_fin = "2015-09-06";
     jour_semaine = "Jeudi"; heure_deb = "08:00:00"; heure_fin = "22:00:00"};
    {code_session = "P2015"; description = "Volleyball libre";
     description_act = "Volleyball libre";
     description_nat = "Sports et de plein air";
     nom_cour = "Loisirs Du Plateau de Charlesbourg inc.";
     lieu_1 = "Parc Maurice-Dorion"; lieu_2 = "Parc Maurice-Dorion";
     arrondissement = "Arrondissement de Charlesbourg";
     adresse = "8815, avenue Jean-Paquin, Quebec (QC) G1G 4W7 ";
     date_deb = "2015-06-01"; date_fin = "2015-09-06";
     jour_semaine = "Samedi"; heure_deb = "08:00:00"; heure_fin = "22:00:00"};
    {code_session = "P2015"; description = "Collectifs";
     description_act = "Collectifs"; description_nat = "Exposition";
     nom_cour = "Societe artistique de Charlesbourg S.A.C.";
     lieu_1 = "Galerie d'art Magella-Paradis";
     lieu_2 = "Maison Pierre-Lefevbre - Etage";
     arrondissement = "Arrondissement de Charlesbourg";
     adresse = "7970, Le Trait-Carre Ouest, Quebec (QC) G1H 4P4 ";
     date_deb = "2015-04-12"; date_fin = "2015-05-24";
     jour_semaine = "Dimanche"; heure_deb = "13:00:00";
     heure_fin = "17:00:00"};
    {code_session = "E2015";
     description = "Â« On se dessine les uns les autres Â»";
     description_act = "Â« On se dessine les uns les autres Â»";
     description_nat = "Arts visuels";
     nom_cour = "Societe artistique de Charlesbourg S.A.C.";
     lieu_1 = "Galerie d'art Magella-Paradis";
     lieu_2 = "Maison Magella-Paradis Salle d'entree";
     arrondissement = "Arrondissement de Charlesbourg";
     adresse = "7970, Le Trait-Carre Ouest, Quebec (QC) G1H 4P4 ";
     date_deb = "2015-07-26"; date_fin = "2015-07-26";
     jour_semaine = "Dimanche"; heure_deb = "11:00:00";
     heure_fin = "16:00:00"};
    {code_session = "H2015";
     description = "Activites sociales ainees - Bonheurs d'Occasions";
     description_act = "Activites sociales ainees";
     description_nat = "Loisirs recreatifs";
     nom_cour = "Loisirs Lebourgneuf inc.";
     lieu_1 = "Centre communautaire Lebourgneuf";
     lieu_2 = "Centre com. Lebourgneuf  \\ salle de danse R-260";
     arrondissement = "Arrondissement des Rivieres";
     adresse = "1650, boulevard La Morille, Quebec (QC) G2K 2L2 ";
     date_deb = "2015-01-10"; date_fin = "2015-04-11";
     jour_semaine = "Samedi"; heure_deb = ...; heure_fin = ...};
    ...]
*)

let la = trouver_selon_arrondissement sa "Arrondissement Sainte-Foy-Sillery-Cap-Rouge";;
let na = List.length la;;

(* Résultat:
val la : SysActivites.activite list =
  [{code_session = "H2015"; description = "Billard libre";
    description_act = "Billard libre";
    description_nat = "Loisirs recreatifs";
    nom_cour = "Club FADOQ Bonne-Entente inc.";
    lieu_1 = "Centre de loisirs Saint-Benoit"; lieu_2 = "Salle RC03-01";
    arrondissement = "Arrondissement Sainte-Foy-Sillery-Cap-Rouge";
    adresse = "909, boulevard Pie-XII, Quebec (QC) G1X 3T4 ";
    date_deb = "2015-01-12"; date_fin = "2015-04-27";
    jour_semaine = "Vendredi"; heure_deb = "09:00:00";
    heure_fin = "11:30:00"};
   {code_session = "H2015"; description = "Billard libre";
    description_act = "Billard libre";
    description_nat = "Loisirs recreatifs";
    nom_cour = "Club FADOQ Bonne-Entente inc.";
    lieu_1 = "Centre de loisirs Saint-Benoit"; lieu_2 = "Salle RC03-01";
    arrondissement = "Arrondissement Sainte-Foy-Sillery-Cap-Rouge";
    adresse = "909, boulevard Pie-XII, Quebec (QC) G1X 3T4 ";
    date_deb = "2015-01-12"; date_fin = "2015-04-27"; jour_semaine = "Mardi";
    heure_deb = "09:00:00"; heure_fin = "11:30:00"};
   {code_session = "H2015"; description = "Billard libre";
    description_act = "Billard libre";
    description_nat = "Loisirs recreatifs";
    nom_cour = "Club FADOQ Bonne-Entente inc.";
    lieu_1 = "Centre de loisirs Saint-Benoit"; lieu_2 = "Salle RC03-01";
    arrondissement = "Arrondissement Sainte-Foy-Sillery-Cap-Rouge";
    adresse = "909, boulevard Pie-XII, Quebec (QC) G1X 3T4 ";
    date_deb = "2015-01-12"; date_fin = "2015-04-27";
    jour_semaine = "Vendredi"; heure_deb = "13:00:00";
    heure_fin = "16:30:00"};
   {code_session = "P2015"; description = "Petanque";
    description_act = "Petanque"; description_nat = "Loisirs recreatifs";
    nom_cour = "Corporation des loisirs Saint-Louis-de-France inc.";
    lieu_1 = "Parc Saint-Louis de France";
    lieu_2 = "Petanque Saint-Louis-de-France";
    arrondissement = "Arrondissement Sainte-Foy-Sillery-Cap-Rouge";
    adresse = "1560, route de l'Eglise, Quebec (QC) G1W 3P5 ";
    date_deb = "2015-05-25"; date_fin = "2015-08-26"; jour_semaine = "Mardi";
    heure_deb = "19:00:00"; heure_fin = "22:00:00"};
   {code_session = "H2015"; description = "Meditation (cercle de)";
    description_act = "Meditation (cercle)"; description_nat = "Mieux-etre";
    nom_cour = "Centre de yoga de Sainte-Foy inc.";
    lieu_1 = "Centre de yoga"; lieu_2 = "Salle A Centre de yoga";
    arrondissement = "Arrondissement Sainte-Foy-Sillery-Cap-Rouge";
    adresse = "844, rue Paradis, Quebec (QC) G1V 4J5 ";
    date_deb = "2015-01-22"; date_fin = "2015-04-11"; jour_semaine = "Jeudi";
    heure_deb = "19:30:00"; heure_fin = "20:30:00"};
   {code_session = "H2015"; description = "Club FADOQ. Bonne-Entente inc.";
    description_act = "Club FADOQ. Bonne-Entente, inc.";
    description_nat = "Loisirs recreatifs";
    nom_cour = "Club FADOQ Bonne-Entente inc.";
    lieu_1 = "Centre de loisirs Saint-Benoit"; lieu_2 = "Salle RC02-01";
    arrondissement = "Arrondissement Sainte-Foy-Sillery-Cap-Rouge";
    adresse = "909, boulevard Pie-XII, Quebec (QC) G1X 3T4 ";
    date_deb = "2015-01-19"; date_fin = "2015-04-27";
    jour_semaine = "Mercredi"; heure_deb = "13:00:00";
    heure_fin = "15:00:00"};
   {code_session = "H2015"; description = "Billard libre";
    description_act = "Billard libre";
    description_nat = "Loisirs recreatifs";
    nom_cour = "Club FADOQ Bonne-Entente inc.";
    lieu_1 = "Centre de loisirs Saint-Benoit"; lieu_2 = "Salle RC03-01";
    arrondissement = "Arrondissement Sainte-Foy-Sillery-Cap-Rouge";
    adresse = "909, boulevard Pie-XII, Quebec (QC) G1X 3T4 ";
    date_deb = "2015-01-12"; date_fin = "2015-04-27";
    jour_semaine = "Mercredi"; heure_deb = "09:00:00";
    heure_fin = "11:30:00"};
   {code_session = "H2015"; description = "Billard libre";
    description_act = "Billard libre";
    description_nat = "Loisirs recreatifs";
    nom_cour = "Club FADOQ Bonne-Entente inc.";
    lieu_1 = "Centre de loisirs Saint-Benoit"; lieu_2 = "Salle RC03-01";
    arrondissement = "Arrondissement Sainte-Foy-Sillery-Cap-Rouge";
    adresse = "909, boulevard Pie-XII, Quebec (QC) G1X 3T4 ";
    date_deb = "2015-01-12"; date_fin = "2015-04-27";
    jour_semaine = "Mercredi"; heure_deb = "13:00:00";
    heure_fin = "16:30:00"};
   {code_session = "H2015"; description = "Scrabble libre et duplicata";
    description_act = "Scrabble libre et duplicata";
    description_nat = "Loisirs recreatifs";
    nom_cour = "Club FADOQ Bonne-Entente inc.";
    lieu_1 = "Centre de loisirs Saint-Benoit"; lieu_2 = "Salle RC08-01";
    arrondissement = "Arrondissement Sainte-Foy-Sillery-Cap-Rouge";
    adresse = "909, boulevard Pie-XII, Quebec (QC) G1X 3T4 ";
    date_deb = "2015-01-12"; date_fin = "2015-06-22"; jour_semaine = "Jeudi";
    heure_deb = "13:00:00"; heure_fin = "15:45:00"};
   {code_session = "H2015"; description = "Ceramique, classes ouvertes";
    description_act = "Ceramique - classes ouvertes";
    description_nat = "Metiers d'art";
    nom_cour = "Centre de ceramique de Sainte-Foy";
    lieu_1 = "Centre de ceramique de Sainte-Foy";
    lieu_2 = "Centre de ceramique salle SS102";
    arrondissement = "Arrondissement Sainte-Foy-Sillery-Cap-Rouge";
    adresse = "2130, rue de la Somme, Quebec (QC) G1V 2C5 ";
    date_deb = "2015-01-08"; date_fin = "2015-01-10";
    jour_semaine = "Samedi"; heure_deb = "13:00:00"; heure_fin = "15:00:00"};
   {code_session = "P2015"; description = "Ceramique, classes ouvertes";
    description_act = "Ceramique - classes ouvertes";
    description_nat = "Metiers d'art";
    nom_cour = "Centre de ceramique de Sainte-Foy";
    lieu_1 = "Centre de ceramique de Sainte-Foy";
    lieu_2 = "Centre de ceramique salle SS102";
    arrondissement = "Arrondissement Sainte-Foy-Sillery-Cap-Rouge";
    adresse = "2130, rue de la Somme, Quebec (QC) G1V 2C5 ";
    date_deb = "2015-04-11"; date_fin = "2015-04-12";
    jour_semaine = "Samedi"; heure_deb = "13:00:00"; heure_fin = "15:00:00"};
   {code_session = "P2015"; description = "Ceramique, classes ouvertes";
    description_act = "Ceramique - classes ouvertes";
    description_nat = "Metiers d'art";
    nom_cour = "Centre de ceramique de Sainte-Foy";
    lieu_1 = "Centre de ceramique de Sainte-Foy";
    lieu_2 = "Centre de ceramique salle SS102";
    arrondissement = "Arrondissement Sainte-Foy-Sillery-Cap-Rouge";
    adresse = "2130, rue de la Somme, Quebec (QC) G1V 2C5 ";
    date_deb = "2015-04-11"; date_fin = "2015-04-12";
    jour_semaine = "Dimanche"; heure_deb = "13:00:00";
    heure_fin = "15:00:00"};
   {code_session = "H2015"; description = "Momes et compagnie";
    description_act = "Momes et compagnie";
    description_nat = "Loisirs recreatifs";
    nom_cour = "Corporation des loisirs Sainte-Ursule Inc.";
    lieu_1 = "Centre de loisirs Sainte-Ursule";
    lieu_2 = "Salle 106 centre de loisirs Ste-Ursule";
    arrondissement = "Arrondissement Sainte-Foy-Sillery-Cap-Rouge";
    adresse = "3224, rue Armand-Hamelin, Quebec (QC) G1W 2W7 ";
    date_deb = "2015-01-20"; date_fin = "2015-06-16"; jour_semaine = "Mardi";
    heure_deb = "09:00:00"; heure_fin = "11:30:00"};
   {code_session = "P2015"; description = "Petanque";
    description_act = "Petanque"; description_nat = "Loisirs recreatifs";
    nom_cour = "Corporation des loisirs Saint-Louis-de-France inc.";
    lieu_1 = "Parc Saint-Louis de France";
    lieu_2 = "Petanque Saint-Louis-de-France";
    arrondissement = "Arrondissement Sainte-Foy-Sillery-Cap-Rouge";
    adresse = "1560, route de l'Eglise, Quebec (QC) G1W 3P5 ";
    date_deb = "2015-05-25"; date_fin = "2015-08-26";
    jour_semaine = "Mercredi"; heure_deb = "19:00:00";
    heure_fin = "22:00:00"};
   {code_session = "H2015"; description = "Club FADOQ. Bonne-Entente inc.";
    description_act = "Club FADOQ. Bonne-Entente, inc.";
    description_nat = "Loisirs recreatifs";
    nom_cour = "Club FADOQ Bonne-Entente inc.";
    lieu_1 = "Centre de loisirs Saint-Benoit"; lieu_2 = "Salle RC02-01";
    arrondissement = "Arrondissement Sainte-Foy-Sillery-Cap-Rouge";
    adresse = "909, boulevard Pie-XII, Quebec (QC) G1X 3T4 ";
    date_deb = "2015-01-19"; date_fin = "2015-04-27"; jour_semaine = "Lundi";
    heure_deb = "13:00:00"; heure_fin = "15:00:00"};
   {code_session = "H2015"; description = "Billard libre";
    description_act = "Billard libre";
    description_nat = "Loisirs recreatifs";
    nom_cour = "Club FADOQ Bonne-Entente inc.";
    lieu_1 = "Centre de loisirs Saint-Benoit"; lieu_2 = "Salle RC03-01";
    arrondissement = "Arrondissement Sainte-Foy-Sillery-Cap-Rouge";
    adresse = "909, boulevard Pie-XII, Quebec (QC) G1X 3T4 ";
    date_deb = "2015-01-12"; date_fin = "2015-04-27"; jour_semaine = "Lundi";
    heure_deb = "09:00:00"; heure_fin = "11:30:00"};
   {code_session = "H2015"; description = "Conditionnement physique";
    description_act = "Conditionnement physique";
    description_nat = "Activites physiques";
    nom_cour = "Club FADOQ Bonne-Entente inc.";
    lieu_1 = "Centre de loisirs Saint-Benoit";
    lieu_2 = "Salle polyvalente RC10-01";
    arrondissement = "Arrondissement Sainte-Foy-Sillery-Cap-Rouge";
    adresse = "909, boulevard Pie-XII, Quebec (QC) G1X 3T4 ";
    date_deb = "2015-01-12"; date_fin = "2015-06-18"; jour_semaine = "Jeudi";
    heure_deb = "09:00:00"; heure_fin = "10:00:00"};
   {code_session = "H2015"; description = "Scrabble libre et duplicata";
    description_act = "Scrabble libre et duplicata";
    description_nat = "Loisirs recreatifs";
    nom_cour = "Club FADOQ Bonne-Entente inc.";
    lieu_1 = "Centre de loisirs Saint-Benoit"; lieu_2 = "Salle RC08-01";
    arrondissement = "Arrondissement Sainte-Foy-Sillery-Cap-Rouge";
    adresse = "909, boulevard Pie-XII, Quebec (QC) G1X 3T4 ";
    date_deb = "2015-01-12"; date_fin = "2015-06-22"; jour_semaine = "Lundi";
    heure_deb = "13:00:00"; heure_fin = "15:45:00"};
   {code_session = "H2015"; description = "Conditionnement physique";
    description_act = "Conditionnement physique";
    description_nat = "Activites physiques";
    nom_cour = "Club FADOQ Bonne-Entente inc.";
    lieu_1 = "Centre de loisirs Saint-Benoit";
    lieu_2 = "Salle polyvalente RC10-01";
    arrondissement = "Arrondissement Sainte-Foy-Sillery-Cap-Rouge";
    adresse = "909, boulevard Pie-XII, Quebec (QC) G1X 3T4 ";
    date_deb = "2015-01-12"; date_fin = "2015-06-18"; jour_semaine = "Lundi";
    heure_deb = "10:45:00"; heure_fin = "11:45:00"};
   {code_session = "H2015"; description = "Harmonie et stage band";
    description_act = "Harmonie de Cap-Rouge";
    description_nat = "Arts de la scene";
    nom_cour = "Cercle de musique de Cap-Rouge inc.";
    lieu_1 = "Centre communautaire Champigny"; lieu_2 = "Salle polyvalente";
    arrondissement = "Arrondissement Sainte-Foy-Sillery-Cap-Rouge";
    adresse = "7519, boulevard Wilfrid-Hamel, Quebec (QC) G2G 1C2 ";
    date_deb = "2015-01-14"; date_fin = "2015-04-29";
    jour_semaine = "Mercredi"; heure_deb = "19:00:00"; heure_fin = ...};
   ...]
# val na : int = 28
*)

let lt = trouver_selon_type sa "Sports et de plein air";;
let nt = List.length lt;;

(* Résultat:
val lt : SysActivites.activite list =
  [{code_session = "P2015"; description = "Badminton - Groupe communautaire";
    description_act = "Badminton - Groupe communautaire";
    description_nat = "Sports et de plein air";
    nom_cour = "Loisirs et Sports Neufchatel inc.";
    lieu_1 = "Centre recreatif Apprenti-Sage";
    lieu_2 = "Centre recreatif Apprenti-Sage \\ gymnase simple";
    arrondissement = "Arrondissement des Rivieres";
    adresse = "2200, rue Coursol, Quebec (QC) G2B 4Y4 ";
    date_deb = "2015-04-30"; date_fin = "2015-07-16"; jour_semaine = "Jeudi";
    heure_deb = "20:00:00"; heure_fin = "22:00:00"};
   {code_session = "P2015";
    description = "Hockey interieur - Groupe communautaire";
    description_act = "Hockey interieur - Groupe communautaire";
    description_nat = "Sports et de plein air";
    nom_cour = "Loisirs et Sports Neufchatel inc.";
    lieu_1 = "Centre recreatif Apprenti-Sage";
    lieu_2 = "Centre recreatif Apprenti-Sage \\ gymnase simple";
    arrondissement = "Arrondissement des Rivieres";
    adresse = "2200, rue Coursol, Quebec (QC) G2B 4Y4 ";
    date_deb = "2015-05-03"; date_fin = "2015-07-19";
    jour_semaine = "Dimanche"; heure_deb = "16:00:00";
    heure_fin = "17:30:00"};
   {code_session = "P2015";
    description = "Hockey interieur - Groupe communautaire";
    description_act = "Hockey interieur - Groupe communautaire";
    description_nat = "Sports et de plein air";
    nom_cour = "Loisirs et Sports Neufchatel inc.";
    lieu_1 = "Centre recreatif Apprenti-Sage";
    lieu_2 = "Centre comm. C.-A.-Savard \\ gymnase simple SS109-2-3-4";
    arrondissement = "Arrondissement des Rivieres";
    adresse = "2200, rue Coursol, Quebec (QC) G2B 4Y4 ";
    date_deb = "2015-05-01"; date_fin = "2015-07-17";
    jour_semaine = "Vendredi"; heure_deb = "16:30:00";
    heure_fin = "17:30:00"};
   {code_session = "P2015"; description = "Volleyball libre";
    description_act = "Volleyball libre";
    description_nat = "Sports et de plein air";
    nom_cour = "Loisirs Du Plateau de Charlesbourg inc.";
    lieu_1 = "Parc Maurice-Dorion"; lieu_2 = "Parc Maurice-Dorion";
    arrondissement = "Arrondissement de Charlesbourg";
    adresse = "8815, avenue Jean-Paquin, Quebec (QC) G1G 4W7 ";
    date_deb = "2015-06-01"; date_fin = "2015-09-06";
    jour_semaine = "Mercredi"; heure_deb = "08:00:00";
    heure_fin = "22:00:00"};
   {code_session = "P2015"; description = "Volleyball libre";
    description_act = "Volleyball libre";
    description_nat = "Sports et de plein air";
    nom_cour = "Loisirs Du Plateau de Charlesbourg inc.";
    lieu_1 = "Parc Maurice-Dorion"; lieu_2 = "Parc Maurice-Dorion";
    arrondissement = "Arrondissement de Charlesbourg";
    adresse = "8815, avenue Jean-Paquin, Quebec (QC) G1G 4W7 ";
    date_deb = "2015-06-01"; date_fin = "2015-09-06"; jour_semaine = "Jeudi";
    heure_deb = "08:00:00"; heure_fin = "22:00:00"};
   {code_session = "P2015"; description = "Volleyball libre";
    description_act = "Volleyball libre";
    description_nat = "Sports et de plein air";
    nom_cour = "Loisirs Du Plateau de Charlesbourg inc.";
    lieu_1 = "Parc Maurice-Dorion"; lieu_2 = "Parc Maurice-Dorion";
    arrondissement = "Arrondissement de Charlesbourg";
    adresse = "8815, avenue Jean-Paquin, Quebec (QC) G1G 4W7 ";
    date_deb = "2015-06-01"; date_fin = "2015-09-06";
    jour_semaine = "Samedi"; heure_deb = "08:00:00"; heure_fin = "22:00:00"};
   {code_session = "P2015";
    description = "Volley-ball - Groupe communautaire";
    description_act = "Volley-ball";
    description_nat = "Sports et de plein air";
    nom_cour = "Loisirs Lebourgneuf inc.";
    lieu_1 = "Centre communautaire Lebourgneuf";
    lieu_2 = "Centre com. Lebourgneuf \\ Gymnase simple 1";
    arrondissement = "Arrondissement des Rivieres";
    adresse = "1650, boulevard La Morille, Quebec (QC) G2K 2L2 ";
    date_deb = "2015-04-23"; date_fin = "2015-05-28"; jour_semaine = "Jeudi";
    heure_deb = "20:45:00"; heure_fin = "22:15:00"};
   {code_session = "P2015";
    description = "Volley-ball - Groupe communautaire";
    description_act = "Volley-ball - Groupe communautaire";
    description_nat = "Sports et de plein air";
    nom_cour = "Loisirs Lebourgneuf inc.";
    lieu_1 = "Centre communautaire Lebourgneuf";
    lieu_2 = "Centre com. Lebourgneuf \\ Gymnase simple 2";
    arrondissement = "Arrondissement des Rivieres";
    adresse = "1650, boulevard La Morille, Quebec (QC) G2K 2L2 ";
    date_deb = "2015-04-20"; date_fin = "2015-05-25"; jour_semaine = "Lundi";
    heure_deb = "16:00:00"; heure_fin = "17:30:00"};
   {code_session = "H2015"; description = "Soccer-reservation";
    description_act = "Soccer (reservation)";
    description_nat = "Sports et de plein air";
    nom_cour = "Soccer Quebec-Centre";
    lieu_1 = "Centre communautaire Lucien-Borne";
    lieu_2 = "C. c. Ferland gymnase AB (RC05)";
    arrondissement = "Arrondissement de La Cite-Limoilou";
    adresse = "100, chemin Sainte-Foy, Quebec (QC) G1R 1T2 ";
    date_deb = "2015-01-03"; date_fin = "2015-05-10";
    jour_semaine = "Vendredi"; heure_deb = "18:30:00";
    heure_fin = "19:45:00"};
   {code_session = "H2015"; description = "Volley-ball - Pratique organisee";
    description_act = "Volley-ball - Pratique organisee";
    description_nat = "Sports et de plein air";
    nom_cour = "Loisirs Duberger-Les Saules inc.";
    lieu_1 = "Centre communautaire Les Saules";
    lieu_2 = "Centre communautaire Les Saules \\ gymnase simple";
    arrondissement = "Arrondissement des Rivieres";
    adresse = "4120, rue De Musset, Quebec (QC) G1P 1P1 ";
    date_deb = "2015-01-13"; date_fin = "2015-04-28"; jour_semaine = "Mardi";
    heure_deb = "19:45:00"; heure_fin = "21:45:00"};
   {code_session = "P2015"; description = "Parcours de sauts a velo";
    description_act = "Parcours de sauts a velo";
    description_nat = "Sports et de plein air";
    nom_cour = "Loisirs Maria-Goretti inc. (Les)";
    lieu_1 = "Parc Maria-Goretti"; lieu_2 = "Parc Maria-Goretti";
    arrondissement = "Arrondissement de Charlesbourg";
    adresse = "7475, avenue Paul-Comtois, Quebec (QC) G1H 5X6 ";
    date_deb = "2015-05-01"; date_fin = "2015-10-01";
    jour_semaine = "Dimanche"; heure_deb = "18:00:00";
    heure_fin = "22:00:00"};
   {code_session = "P2015"; description = "Parcours de sauts a velo";
    description_act = "Parcours de sauts a velo";
    description_nat = "Sports et de plein air";
    nom_cour = "Loisirs Maria-Goretti inc. (Les)";
    lieu_1 = "Parc Maria-Goretti"; lieu_2 = "Parc Maria-Goretti";
    arrondissement = "Arrondissement de Charlesbourg";
    adresse = "7475, avenue Paul-Comtois, Quebec (QC) G1H 5X6 ";
    date_deb = "2015-05-01"; date_fin = "2015-10-01";
    jour_semaine = "Vendredi"; heure_deb = "18:00:00";
    heure_fin = "22:00:00"};
   {code_session = "P2015";
    description = "Vollleyball de plage - pratique libre";
    description_act = "Volleyball de plage - pratique libre";
    description_nat = "Sports et de plein air";
    nom_cour = "Loisirs Maria-Goretti inc. (Les)";
    lieu_1 = "Parc Maria-Goretti"; lieu_2 = "Parc Maria-Goretti";
    arrondissement = "Arrondissement de Charlesbourg";
    adresse = "7475, avenue Paul-Comtois, Quebec (QC) G1H 5X6 ";
    date_deb = "2015-06-01"; date_fin = "2015-10-04";
    jour_semaine = "Dimanche"; heure_deb = "10:00:00";
    heure_fin = "22:00:00"};
   {code_session = "P2015"; description = "Club de marche";
    description_act = "Club de marche";
    description_nat = "Sports et de plein air";
    nom_cour = "Patro de Charlesbourg inc.";
    lieu_1 = "Patro de Charlesbourg"; lieu_2 = "Patro de Charlesbourg";
    arrondissement = "Arrondissement de Charlesbourg";
    adresse = "7700, 3e Avenue Est, Quebec (QC) G1H 7J2 ";
    date_deb = "2015-04-03"; date_fin = "2015-06-19";
    jour_semaine = "Mercredi"; heure_deb = "10:00:00";
    heure_fin = "11:30:00"};
   {code_session = "P2015";
    description = "Rampe de rouli-roulant - pratique libre";
    description_act = "Rampe de rouli-roulant - pratique libre";
    description_nat = "Sports et de plein air";
    nom_cour = "Loisirs Bourg-Royal inc. (Les)"; lieu_1 = "Parc St-Viateur";
    lieu_2 = "Parc Saint-viateur";
    arrondissement = "Arrondissement de Charlesbourg";
    adresse = "705, rue Saint-Viateur, Quebec (QC) G2L 2R5 ";
    date_deb = "2015-04-27"; date_fin = "2015-08-30";
    jour_semaine = "Samedi"; heure_deb = "13:00:00"; heure_fin = "17:00:00"};
   {code_session = "P2015"; description = "Hockey-balle (pratique libre)";
    description_act = "Hockey-Balle (pratique libre)";
    description_nat = "Sports et de plein air";
    nom_cour = "Loisirs Bourassa inc. (Les)";
    lieu_1 = "Parc de la Terrasse Bon-Air"; lieu_2 = "Parc Terrasse Bon-Air";
    arrondissement = "Arrondissement de Charlesbourg";
    adresse = "1085, 60e Rue Est, Quebec (QC) G1H 2E3 ";
    date_deb = "2015-05-04"; date_fin = "2015-08-31";
    jour_semaine = "Samedi"; heure_deb = "09:00:00"; heure_fin = "23:00:00"};
   {code_session = "P2015";
    description = "Rampe rouli-roulant - pratique libre";
    description_act = "Parc de rouli-roulant - pratique libre";
    description_nat = "Sports et de plein air";
    nom_cour = "Loisirs Bourassa inc. (Les)";
    lieu_1 = "Parc de la Terrasse Bon-Air"; lieu_2 = "Parc Terrasse Bon-Air";
    arrondissement = "Arrondissement de Charlesbourg";
    adresse = "1085, 60e Rue Est, Quebec (QC) G1H 2E3 ";
    date_deb = "2015-05-04"; date_fin = "2015-08-31";
    jour_semaine = "Dimanche"; heure_deb = "10:00:00";
    heure_fin = "22:00:00"};
   {code_session = "P2015"; description = "Basketball";
    description_act = "Basketball";
    description_nat = "Sports et de plein air";
    nom_cour = "Loisirs Du Jardin inc."; lieu_1 = "Parc St-Pierre";
    lieu_2 = "Parc Saint-Pierre";
    arrondissement = "Arrondissement de Charlesbourg";
    adresse = "5295, rue des Violettes, Quebec (QC) G1G 5L5 ";
    date_deb = "2015-05-01"; date_fin = "2015-08-31";
    jour_semaine = "Dimanche"; heure_deb = "10:00:00";
    heure_fin = "23:00:00"};
   {code_session = "P2015";
    description = "Rampes de rouli-roulant Â« skate parc Â»";
    description_act = "Rampes de rouli-roulant";
    description_nat = "Sports et de plein air";
    nom_cour = "Loisirs Du Jardin inc."; lieu_1 = "Parc St-Pierre";
    lieu_2 = "Parc Saint-Pierre";
    arrondissement = "Arrondissement de Charlesbourg";
    adresse = "5295, rue des Violettes, Quebec (QC) G1G 5L5 ";
    date_deb = "2015-05-01"; date_fin = "2015-08-31"; jour_semaine = "Mardi";
    heure_deb = "16:00:00"; heure_fin = "23:00:00"};
   {code_session = "H2015"; description = "Competitif \"D\" et \"C\"  mixte";
    description_act = "Volley-ball";
    description_nat = "Sports et de plein air";
    nom_cour = "Ligue \"Volleylite\" de Beauport";
    lieu_1 = "Ecole secondaire Samuel-De Champlain";
    lieu_2 = "Palestre Samuel-De Champlain";
    arrondissement = "Arrondissement de Beauport";
    adresse = "2740, avenue Saint-David, Quebec (QC) G1E 4K7 ";
    date_deb = "2015-01-14"; date_fin = "2015-04-08";
    jour_semaine = "Mercredi"; heure_deb = "20:00:00"; heure_fin = ...};
   ...]
# val nt : int = 212
*)

let liste_arrond = lister_arrondissements sa;;
let na = List.length liste_arrond;;

(*
val liste_arrond : string list =
  ["Arrondissement de Beauport"; "Arrondissement des Rivieres";
   "Arrondissement de La Cite-Limoilou"; "Arrondissement de Charlesbourg";
   "Arrondissement Sainte-Foy-Sillery-Cap-Rouge";
   "Arrondissement de La Haute-Saint-Charles"]
# val na : int = 6
*)

let liste_types = lister_types_activites sa;;
let nt = List.length liste_types;;

(*
val liste_types : string list =
  ["Loisirs jeunesse"; "Loisirs recreatifs"; "Sports et de plein air";
   "Evenement special"; "Activites physiques"; "Exposition"; "Arts visuels";
   "Arts de la scene"; "Activites aquatiques"; "Cours de natation";
   "Mieux-etre"; "Artisanat"; "Relache"; "Camp specialise";
   "Sports de combat"; "Sports de glace"; "Activites Physiques";
   "Loisir educatif"; "Programme d'aide"; "Patrimoine"; "Metiers d'art";
   "Formation"; "Clubs de natation"; "Loisir scientifique"]
# val nt : int = 24
*)

let sa = initialiser_system ();;
lancer_systeme_activites sa "LOISIR_LIBRE.CSV";;

(* Résultat:
val sa : SysActivites.sysactivites = Vide
# Outil de recherche du Centre de Losirs de Quebec
Quel type (nature) d'activites vous interessent?
0 - Loisirs jeunesse
1 - Loisirs recreatifs
2 - Sports et de plein air
3 - Evenement special
4 - Activites physiques
5 - Exposition
6 - Arts visuels
7 - Arts de la scene
8 - Activites aquatiques
9 - Cours de natation
10 - Mieux-etre
11 - Artisanat
12 - Relache
13 - Camp specialise
14 - Sports de combat
15 - Sports de glace
16 - Activites Physiques
17 - Loisir educatif
18 - Programme d'aide
19 - Patrimoine
20 - Metiers d'art
21 - Formation
22 - Clubs de natation
23 - Loisir scientifique
24 - Tous 
Veuillez entrer un nombre entre 0 et 24:? 0

Quel arrondissement vous interesse?
0 - Arrondissement de Beauport
1 - Arrondissement des Rivieres
2 - Arrondissement de La Cite-Limoilou
3 - Arrondissement de Charlesbourg
4 - Arrondissement Sainte-Foy-Sillery-Cap-Rouge
5 - Arrondissement de La Haute-Saint-Charles
6 - Tous 
Veuillez entrer un nombre entre 0 et 6:? 2
Description: Local ados.
Type: Loisirs jeunesse.
Lieu: Centre communautaire Mgr-Marcoux.
Adresse: 1885, chemin de la Canardiere, Quebec (QC) G1J 2E5 .
Arrondissement: Arrondissement de La Cite-Limoilou.
Dates: 2015-01-12 au 2015-06-07.
Jour de la semaine: Vendredi.
Heures: 18:00:00 a 22:00:00.

Description: Local ados.
Type: Loisirs jeunesse.
Lieu: Centre communautaire Mgr-Marcoux.
Adresse: 1885, chemin de la Canardiere, Quebec (QC) G1J 2E5 .
Arrondissement: Arrondissement de La Cite-Limoilou.
Dates: 2015-01-12 au 2015-06-07.
Jour de la semaine: Dimanche.
Heures: 18:00:00 a 21:00:00.

Description: Cadets-cadettes.
Type: Loisirs jeunesse.
Lieu: Manege militaire de Saint-Malo.
Adresse: 1020, rue Vincent-Massey, Quebec (QC) G1N 1M8 .
Arrondissement: Arrondissement de La Cite-Limoilou.
Dates: 2015-01-09 au 2015-03-27.
Jour de la semaine: Vendredi.
Heures: 18:30:00 a 21:30:00.

Description: Local ados.
Type: Loisirs jeunesse.
Lieu: Centre communautaire Mgr-Marcoux.
Adresse: 1885, chemin de la Canardiere, Quebec (QC) G1J 2E5 .
Arrondissement: Arrondissement de La Cite-Limoilou.
Dates: 2015-01-12 au 2015-06-07.
Jour de la semaine: Mercredi.
Heures: 18:00:00 a 21:00:00.

Description: Local ados.
Type: Loisirs jeunesse.
Lieu: Centre communautaire Mgr-Marcoux.
Adresse: 1885, chemin de la Canardiere, Quebec (QC) G1J 2E5 .
Arrondissement: Arrondissement de La Cite-Limoilou.
Dates: 2015-01-12 au 2015-06-07.
Jour de la semaine: Lundi.
Heures: 18:00:00 a 21:00:00.

Description: Cadets-cadettes.
Type: Loisirs jeunesse.
Lieu: Manege militaire de Saint-Malo.
Adresse: 1020, rue Vincent-Massey, Quebec (QC) G1N 1M8 .
Arrondissement: Arrondissement de La Cite-Limoilou.
Dates: 2015-04-03 au 2015-06-12.
Jour de la semaine: Vendredi.
Heures: 19:00:00 a 21:30:00.


Nombre d'activites trouvees: 6

Merci est au revoir!- : unit = ()
*)


(***************************************)
(* Verification des messages d'erreurs *)
(***************************************)

let a1 = creer_activite ["P2015";"Aquaforme";"Aquaforme";"Activites aquatiques";"YWCA Quebec";"Y.W.C.A";
			 "Y.W.C.A. piscine";"Arrondissement de La Cite-Limoilou";
			 "855, avenue Holland, Quebec (QC) G1S 3S5";
			 "2015-05-01";"2015-06-19";"Vendredi";"10:30:00";"11:25:00"];;


try 
  ignore (supprimer_activite a1 (initialiser_system ()))
with
  Err s -> print_endline s;;

(* Résultat:
Le systeme d'activites est vide
- : unit = ()
*)

let a2 = creer_activite ["H2015";"Billard libre";"Billard libre";"Loisirs recreatifs";
			 "Club FADOQ Bonne-Entente inc.";"Centre de loisirs Saint-Benoit";
			 "Salle RC03-01";"Arrondissement Sainte-Foy-Sillery-Cap-Rouge";
			 "909, boulevard Pie-XII, Quebec (QC) G1X 3T4";
			 "2015-01-12";"2015-04-27";"Jeudi";"09:00:00";"11:30:00"];;

let sa = ajouter_activite a1 sa;;

try 
  ignore (supprimer_activite a2 sa)
with
  Err s -> print_endline s;;

(* Résultat:
Le systeme d'activites ne contient pas cette activite
- : unit = ()
*)

try 
  ignore (afficher_systeme_activites (initialiser_system ()))
with
  Err s -> print_endline s;;

(* Résultat:
Le systeme d'activites est vide
- : unit = ()
*)



try 
  ignore (charger_donnees_sysactivites (initialiser_system ()) "TestTP1.CSV")
with
  Sys_error s -> print_endline s;;

(* Résultat:
TestTP1.CSV: No such file or directory
- : unit = ()
*)

try 
  ignore (trouver_selon_arrondissement (initialiser_system ()) "test")
with
  Err s -> print_endline s;;

(* Résultat:
Le systeme d'activites est vide
- : unit = ()
*)


try 
  ignore (trouver_selon_type (initialiser_system ()) "test")
with
  Err s -> print_endline s;;

(* Résultat:
Le systeme d'activites est vide
- : unit = ()
*)


try 
  ignore (lister_arrondissements (initialiser_system ()))
with
  Err s -> print_endline s;;

(* Résultat:
Le systeme d'activites est vide
- : unit = ()
*)


try 
  ignore (lister_types_activites (initialiser_system ()))
with
  Err s -> print_endline s;;

(* Résultat:
Le systeme d'activites est vide
- : unit = ()
*)


try 
  ignore (lancer_systeme_activites (initialiser_system ()) "LOISIR_LIBRE.CSV")
with
  Err s -> print_endline s;;

(* Résultat:
Outil de recherche du Centre de Losirs de Quebec
Quel type (nature) d'activites vous interessent?
0 - Loisirs jeunesse
1 - Loisirs recreatifs
2 - Sports et de plein air
3 - Evenement special
4 - Activites physiques
5 - Exposition
6 - Arts visuels
7 - Arts de la scene
8 - Activites aquatiques
9 - Cours de natation
10 - Mieux-etre
11 - Artisanat
12 - Relache
13 - Camp specialise
14 - Sports de combat
15 - Sports de glace
16 - Activites Physiques
17 - Loisir educatif
18 - Programme d'aide
19 - Patrimoine
20 - Metiers d'art
21 - Formation
22 - Clubs de natation
23 - Loisir scientifique
24 - Tous 
Veuillez entrer un nombre entre 0 et 24:? 25
Nombre incorrect, veuillez recommencer!
- : unit = ()
*)

