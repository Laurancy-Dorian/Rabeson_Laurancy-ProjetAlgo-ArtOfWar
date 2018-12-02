
/*
 	CarteProtocol (ou carte) est l'element avec lequel le reste du programme interagira.
 	Une Carte represente une unite sur un champ de bataille
	Elle possede comme caracteristique
 		- Un type, C'est la designations de la carte. Une carte peut etre par exemple un "roi", un "soldat", un "garde" ou un "archer".
			Ce type sera surtout utile pour identifier la carte. De nouvelles unites avec des types differents pourraient etre crees.
		- Une puissance d'attaque : C'est les degats que cette carte pourra effectuer lorsqu'elle attaquera une autre carte
		- Un statut (ou position) : Une carte peut etre en statut defensif ou offensif. En fonction de ce statut, elle peut ne pas avoir le meme nombre de PV
		- Des PV en statut defensif
		- Des PV en statut offensif
		- Une portee :

		//TODO suite je sais pas si c'est bien ce que j'ai fait jusque la
*/
protocol CarteProtocol {

	// init : -> CarteProtocol
	// Creation d'une Carte, initialise sans caracteristique
	init() // TODO Utile ? Requiert d'ajouter des preconditions dans les fonctions apres si on la laisse


	// init : String x Int x Int x Int x (Int,Int)[] -> CarteProtocol
	// Creation d'une carte avec toutes ses caracteristiques (type, puissance d'attaque, statut, PV en statut offensif, pv en statut defensif, portee)
	// Le statut est defini en defensif
	// pre : type_carte est le nom du type de la carte. Elle ne peut pas etre une chaine vide
	// pre : puissance_attaque est la puissance d'attaque de la carte, elle doit etre strictement positive
	// pre : pv_defensif est la valeur de pv maximum en statut defensif, elle doit etre strictement positive
	// pre : pv_offensif est la valeur de pv maximum en statut offensif, elle doit etre strictement positive
	// pre : pv_defensif >= pv_offensif
	// pre : portee est un tableau de tuples qui representent chacun une direction possible de l'attaque de la carte.
	//			 Les valeurs des tuples ne peuvent pas etre negatives
	init(type_carte : String, puissance_attaque : Int, pv_defensif : Int, pv_offensif : Int, portee : (Int,Int)[])


	// puissance_attaque : CarteProtocol -> CarteProtocol x Int
	// Post : retourne la puissance d'attaque de la carte
	func puissance_attaque() -> Int


	// puissance_attaque : CarteProtocol x Int -> CarteProtocol
	// Modifie la puissance d'attaque
	// Pre : p_att represente la puissance d'attaque
	// Pre : p_att > 0
	// Post : La puissance d'attaque est changee pour celle donnee en parametre
	mutating func puissance_attaque(p_att : Int)


	// pv_defensif : CarteProtocol -> CarteProtocol x Int
	// Post : retourne les pv de la carte lorsqu'elle est en statut defensif
	func pv_defensif() -> Int


	// pv_defensif : CarteProtocol x Int -> CarteProtocol
	// Modifie les pv de la carte en statut defensif
	// Pre : pv_def represente les pv en mode defensif
	// Pre : pv_def > 0
	// Post : La valeur des pv_defensif est changee pour celle donnee en parametre
	// 				Si cette valeur est inferieure a pv_offensif, lance une erreur et rien n'est fait
	// TODO Correct ?
	mutating func pv_defensif(pv_def : Int) trows

	// pv_offensif : CarteProtocol -> CarteProtocol x Int
	// Post : retourne les pv de la carte lorsqu'elle est en statut offensif
	func pv_offensif() -> Int

	// pv_offensif : CarteProtocol x Int -> CarteProtocol
	// Modifie les pv de la carte en statut offensif
	// Pre : pv_off represente les pv en mode offensif
	// Pre : pv_off > 0
	// Post : La valeur des pv_offensif est changee pour celle donnee en parametre
	// 				Si cette valeur est superieure a pv_defensif, lance une erreur et rien n'est fait
	// TODO Correct ?
	mutating func pv_offensif(pv_off : Int)


	// TODO : fonction get pv qui renvoie les pv en fonction du statut actuel de la carte


	// statut : CarteProtocol -> CarteProtocol x Int
	// Post : retourne le statut actuel de la carte
	func statut() -> Int


	// statut : CarteProtocol x Int -> CarteProtocol
	// Modifie le statut de la carte.
	// La carte est en statut DEFENSIF si son statut est a 0.
	// La carte est en statut OFFENSIF si son statut est a 1.
	// Pre : statut represente le nouveau statut de la carte
	// Pre : Statut ne peut unique prendre comme valeur 0 ou 1
	// Post : Modifie le statut en fonction de la valeur en parametre (carte en offensif si 1, carte en defensif si 0)
	// 				Ne fait rien et genere une erreur si les precondition n'ont pas ete respectees
	mutating func statut(statut : Int) throws


	// TODO specs
	func portee() -> (Int,Int)[]

	// TODO specs
	mutating func portee(p : (Int,Int)[])


	// type_carte : CarteProtocol -> CarteProtocol x String
	// Post : Retourne le type de la carte sous forme de String
	func type_carte() -> String


	// type_carte : CarteProtocol x String -> CarteProtocol
	// Modifie le type de la carte
	// Pre : type ne peut pas etre une chaine de caracteres vide ""
	// Post : Modifie le type de la carte par la valeur en parametre si la precondition est respectee
	mutating func type_carte(type : String)


	// degats_subis : CarteProtocol -> CarteProtocol x Int
	// Post : Renvoie les degats subis par la carte
	func degats_subis() -> Int


	// degats_subis : CarteProtocol x Int -> CarteProtocol
	// Pre : degats represente les degats totaux subis par la carte
	// Pre : degats ne peut pas etre negative
	// Post : remplace les degats subis par la valeur passee en parametre si les pre sont verifiees
	mutating func degats_subis(degats : Int) // TODO degats_subis Ou bien ResetDegats ???


	// TODO OOOO
	func attaque(carte_attaqee : CarteProtocol) -> Int

}
