enum NomPosition{
	case F1
	case F2
	case F3
	case A1
	case A2
	case A3
}

protocol PositionProtocol{
    associatedtype CarteProtocol : Carte

    var nomposition : NomPosition {get set}
	var carte : CarteProtocol? {get set}

	//modification : creer une position avec un nom et une carte?
	init(nom : NomPosition, carte : Carte?)

	// Fonction pour avoir le nom de la position
	func getNomPos()->String

	//Fonction qui dit si la position est vide ou non
    //estPositionVide : Position ->Bool
    //post : renvoie True s'il n'ya pas de carte sur la position donnée, False sinon
	func estPositionVide()->Bool

	// Fonction pour avoir la carte sur la position donnée
    //getCarte : PositionProtocol -> (CarteProtocol | Vide)
    // post :renvoie vide s'il n'y a pas de carte sur la position donnée, sinon renvoie la Carte 
	func getCarte()->CarteProtocol?
}
