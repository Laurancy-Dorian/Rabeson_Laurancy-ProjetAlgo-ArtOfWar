import ArtOfWar

///////////////////////////////
////// ART OF WAR - MAIN //////
///////////////////////////////


// ===== FONCTIONS DU MAIN ===== //

/*
  lire_input :  -> String?
  Lis la ligne courante et la renvoie sous forme de chaine de caractere
  Return : La ligne ecrite si la lecture a fonctionne, nil sinon
*/

func lire_input() -> String? {
    if let input = readLine() {
        return input;
    }
    return nil
}

/*
  input : String x [String] -> String

  Demande a l'utilisateur de saisir une expression dans le terminal
  Affiche un message et attend une reponse specifiqie. Continue a demandee tant qu'une reponse
  satisfaisante n'a pas ete saisie
  Parameters :
    - msg   Le message a afficher a l'utilsateur (Une question, une demande de saisie)
    - rep_possibles   Un tableau de String contenant l'ensemble des reponses attendues
  Return : La reponse selectionnee par l'utilisateur
*/
func input(_ msg: String = "Selectionnez votre reponse", _ rep_possibles: [String] = ["Y", "N"]) -> String {
    // Formate le message de demande sous la forme : Message (rep_attendue1, rep_attendue2 ...)
    let message_a_afficher: String
    var choix_reponse: String = ""
    if (!rep_possibles.isEmpty) {
        var virgule: String = ""

        for rep in rep_possibles {
            choix_reponse += virgule + rep
            virgule = ", "
        }

        message_a_afficher = msg + " (" + choix_reponse + ")"
    } else {
        message_a_afficher = msg
    }

    var reponse: String = ""
    // On recommence la boucle jusqu'a obtenir une reponse satisfaisante
    while (reponse == "") {
        // Affiche le message
        print(message_a_afficher)

        // Lit la reponse
        if let lecture_reponse = lire_input() {
            reponse = lecture_reponse

            // Verifie si la reponse est correcte
            var rep_correcte: Bool = false

            if (!rep_possibles.isEmpty) {
                for rep_attendue in rep_possibles {
                    if (reponse.lowercased() == rep_attendue.lowercased()) {
                        rep_correcte = true
                    }
                }
            } else {
                rep_correcte = true
            }

            // Si la reponse n'est pas correcte, on affiche un message et on reinitialise la
            if (!rep_correcte) {
                print("Erreur dans votre reponse")
                print("Veuillez taper l'une des reponses attendues : " + choix_reponse)
                reponse = ""
            }
        } else {
            // S'il y a eu une erreur lors de la saisie, affiche ce message et redemande de saisir la reponse
            print("Erreur lors de la lecture, veuillez reessayer")
        }
    }

    return reponse;
}


/*
    Renvoie les donnees de la carte passee en parametre sous la forme d'une chaine de caracteres
*/
func str_carte_stats(_ c: CarteProtocol) -> String {
    var str: String = "";
    str += c.type_carte();
    str += "\t Attaque : " + c.puissance_attaque()
    if (c.statut() == 1) {
        str += "\t Statut : Offensif"
    } else {
        str += "\t Statut : Defensif"
    }
    str += "\t PV en statut Defensif : " + c.pv_defensif()
    str += "\t PV en statut Offensif : " + c.pv_offensif()

    str += "\t PV restants : " + c.pv_restants()

    return str;
}

/*
    Renvoie les donnes de la carte passee en parametre de facon reduite sous la forme d'une chaine de caracteres
    Forme : Type (Attaque, statut, PV_restants)
*/
func str_carte_red(_ c: CarteProtocol) -> String {
    var str: String = "";
    str += c.type_carte()
    str += " (" + c.puissance_attaque()
    if (c.statut() == 1) {
        str += ", Off"
    } else {
        str += ", Def"
    }
    str += ", " + c.pv_restants() + ")"
    return str;
}


/*
    Assigne les differentes cartes des plateaux passees en parametre dans un tableau.
    La ligne 0 est l'arriere du plateau du j1
    La ligne 1 est le front du plateau du j1
    La ligne 2 est le front du plateau du j2
    La ligne 3 est l'arriere du plateau du j2

    Les deux plateau etant face a face, on aura donc la case (0,0) du J1 qui fera face a la case (0, 0) du j1, fera face
    a la case (2,0) du J2

    Le tableau[4][3] de Carte resultant sera sous cette forme, ou (x,y) represente la carte aux coordonnees x,y
    3   (2,1)   (1,1)   (0,1)   |   Arriere J2
    2   (2,0)   (1,0)   (0,0)   |   Front J2
    1   (0,0)   (1,0)   (2,0)   |   Front J1
    0   (0,1)   (1,1)   (2,1)   |   Arriere J1
          0       1       2

          ==> par exemple : tab[2][1] renvoie la carte en position (1,0) du plateau du J2
*/
func align_champ_bataille(_ p_joueur_actif: PlateauProtocol, _ p_joueur_inactif: PlateauProtocol) -> [CarteProtocol] {
    var tab = [[CartePotocol]]();
    var ligne1 = [CartePotocol]();
    ligne1.insert(p_joueur_actif.carte_en_position(0, 1), at: 0)
    ligne1.insert(p_joueur_actif.carte_en_position(1, 1), at: 1)
    ligne1.insert(p_joueur_actif.carte_en_position(2, 1), at: 2)

    ligne2 = [CartePotocol]();
    ligne2.insert(p_joueur_actif.carte_en_position(0, 0), at: 0)
    ligne2.insert(p_joueur_actif.carte_en_position(1, 0), at: 1)
    ligne2.insert(p_joueur_actif.carte_en_position(2, 0), at: 2)

    ligne3 = [CartePotocol]();
    ligne3.insert(p_joueur_inactif.carte_en_position(2, 0), at: 0)
    ligne3.insert(p_joueur_inactif.carte_en_position(1, 0), at: 1)
    ligne3.insert(p_joueur_inactif.carte_en_position(0, 0), at: 2)

    ligne4 = [CartePotocol]();
    ligne4.insert(p_joueur_inactif.carte_en_position(2, 1), at: 0)
    ligne4.insert(p_joueur_inactif.carte_en_position(1, 1), at: 1)
    ligne4.insert(p_joueur_inactif.carte_en_position(0, 1), at: 2)

    tab.insert(ligne1, at: 0)
    tab.insert(ligne1, at: 1)
    tab.insert(ligne1, at: 2)
    tab.insert(ligne1, at: 3)

    return tab

}

func str_plateau(_ plateau: PlateauProtocol) {
    var str: String = ""



}

/*
    Renvoie les donnees du champ de bataille sur la forme de chaine de caracteres selon le point de vue du joueur actif
    Ses troupes seront affichees en bas, les troupes enemies en haut
    Parameters :
        - p_joueur_actif    Le plateau du joueur actif
        - p_joueur_inactif  Le plateau du joueur inactif
*/
func str_champ_bataille(_ p_joueur_actif: PlateauProtocol, _ p_joueur_inactif: PlateauProtocol) {
    var str: String = ""
    let empty: String = "VIDE"

    var tab = align_champ_bataille(p_joueur_actif, p_joueur_inactif)

    for ligne in tab.reverse() {
        for carte in ligne {
            str += str_carte_red(carte)
            str += "\t"
        }
        str += "\n"
    }

    return str;
}

/*
    Renvoie les stats de toutes les cartes presentes dans la main du joueur
    Parameters :
        - main  La main a afficher
*/
func str_main(_ main: MainProtocol) {
    var str: String = ""
    for c in main {
        str += str_carte_stats(c) + "\n"
    }
    return str
}


// ===== MAIN ===== //
