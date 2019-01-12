import Foundation


protocol JoueurProtocol {
    associatedtype CollectionDeCartes : CollectiondeCarteProtocol
    associatedtype ChampDeBatailleProtocol : ChampDeBataille    

    var nomjoueur : String {get set}
    var main : CollectionDeCartes {get set}
    var cimetiere : CollectionDeCartes {get set}
    var royaume : CollectionDeCartes {get set}
    var pioche : CollectionDeCartes {get set}
    var cdb : ChampDeBataille {get set}

    
    //lors de l'initialisation du joueur on crée une pioche, une main, un cimetière et un royaume associé à ce joueur
    init(nom: String)
    
    
    // renvoie le nom du joueur
    //getNom : Joueur -> String
    func getNom() -> String
    
    //renvoie la main du joueur
    //getMain : Joueur -> CollectiondeCarte
    func getMain() -> CollectionDeCartes
    
    //renvoie le cimetière du joueur
    //getCimetiere: Joueur -> CollectiondeCarte
    func getCimetiere() -> CollectionDeCartes
    
    //renvoie le royaume du joueur
    //getRoyaume : Joueur -> CollectiondeCarte
    func getRoyaume() -> CollectionDeCartes
    
    //renvoie la pioche du joueur
    //getPioche : Joueur -> CollectiondeCarte
    func getPioche() -> CollectionDeCartes
    
    //renvoie le champ de bataille du joueur
    //getCdB : Joueur -> ChampDeBataille
    func getCdB() -> ChampDeBataille

    //Ajoute les cartes dans la main du joueur et dans la pioche au debut de la partie
    //pré : la main du joueur contient un roi, la pioche contient 20 cartes
    //post : la main du joueur contient 4 cartes (3 cartes de la pioche + 1 roi), la pioche contient les 17 autres cartes
    //modification : on passe en parametre le numero du joueur (1 ou 2) pour lui donner le roi associé
    mutating func initialisationJoueur(numeroJoueur : Int)

    //renvoie un booléen si le roi du joueur est mort ou non
    //estRoiMort: Joueur -> Bool
    //pré : on prend en paramètre un joueur
    //post : on renvoie True si le roi est mort (si le roi est dans le cimetière du joueur ou dans le royaume de son adversaire) False sinon
    //modification : on passe le joueur 2 en parametre pour checker son royaume
    func estRoiMort(autrejoueur : Joueur) -> Bool

    // renvoie un booléen qui indique si la main du joueur estVide ou non
    // estMainVide: Joueur -> Bool
    //post Renvoie True si la main estVide False sinon
    func estMainVide()-> Bool

}
