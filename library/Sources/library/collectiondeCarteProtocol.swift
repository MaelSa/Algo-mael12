import Foundation


protocol CollectiondeCarteProtocol : Sequence{
    associatedtype ItCollection : IteratorProtocol
    associatedtype CarteProtocol : Carte

    var cartes : [Carte] {get set}
    
    //initialise une collection de cartes vide
    init()

	//renvoie un booléen si la collection est vide ou non
    //estvideCollection : CollectiondeCarte -> bool
	//post: renvoie True si la collection est vide, False sinon
	func estvideCollection () -> Bool

	//ajouter une carte dans la collection choisie
    //ajouterCarteCollection : CollectiondeCarte x Carte -> CollectiondeCarte
    // pré: prend comme argument la carte qu'on veut mettre dans la collection
    //post : renvoie la collection de carte initiale avec la carte choisie en plus
	mutating func ajouterCarteCollection (carte : Carte) -> Self


	//enlever une carte de la collection
    //supprimerCarteCollection : CollectiondeCarte x Carte -> Carte
    // pré : prend en paramètre une carte qu'on veut retirer de la collection
    //post : renvoie la carte que l'on a supprimer de la collection
	mutating func supprimerCarteCollection(carte : Carte) -> (Self, Carte)


    // renvoie la premiere carte ajouter dans la collection et la supprime
    //supprimerCarteCollection : CollectiondeCarte  -> Carte
    //post : renvoie la carte que l'on a supprimer de la collection
    mutating func sortirCarteCollection() -> (Carte, Carte?)

	//renvoie le nombre de carte dans la collection
    //nombreCarteCollection : CollectiondeCarte -> int
    //post : renvoie le nombre de cartes contenue dans la collection
	func nombreCarteCollection () -> Int

    
    // crée un itérateur sur la collection pour itérer avec for in. L’itération se fait dans l’ordre d'arrivée des cartes dans la collection
    // makeIterator : CollectiondeCarte -> ItCollection
    func makeIterator() -> ItCollection

    //renvoie la 1ere carte de la liste et la supprime de la collection
    //getFirst(): CollectiondeCarte -> Carte
    //post : renvoie la 1ere carte si la collection n'est pas vide
    mutating func getFirst() -> (Self, Carte?)

    //renvoie true si les deux cartes placées en paramètres sont les mêmes, renvoie false sinon
    //comparer : Carte x Carte -> Bool
    func comparer(carte1 : Carte, carte2 : Carte) -> Bool

}
