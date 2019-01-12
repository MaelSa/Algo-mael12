import Foundation 

public struct Joueur : JoueurProtocol {
    public typealias PositionProtocol = Position
    public typealias CollectiondeCarteProtocol = CollectionDeCartes
    public typealias ChampDeBatailleProtocol = ChampDeBataille
    public typealias CarteProtocol = Carte

	internal var nomjoueur : String
    internal var main : CollectionDeCartes
    internal var royaume : CollectionDeCartes
    internal var pioche : CollectionDeCartes
    internal var cimetiere : CollectionDeCartes
    internal var cdb : ChampDeBataille

    init(nom: String){
    	self.nomjoueur = nom
    	self.main = CollectionDeCartes()
    	self.cimetiere = CollectionDeCartes()
    	self.royaume = CollectionDeCartes()
    	self.pioche = CollectionDeCartes()
    	self.cdb = ChampDeBataille()
    }

    public func getNom() -> String {
    	return self.nomjoueur
    }

    public func getMain() -> CollectionDeCartes {
    	return self.main
    }

    public func getCimetiere() -> CollectionDeCartes {
    	return self.cimetiere
    }

    public func getRoyaume() -> CollectionDeCartes {
    	return self.royaume
    }

    public func getPioche() -> CollectionDeCartes {
    	return self.pioche
    }

    public func getCdB() -> ChampDeBataille {
    	return self.cdb
    }

    public mutating func initialisationjoueur(numeroJoueur : Int) {
        if numeroJoueur == 1 {
            self.main.ajouterCarteCollection(carte : Carte(type : TypedeCarte.Roi1))
        }
        else
        {
            self.main.ajouterCarteCollection(carte : Carte(type : TypedeCarte.Roi2))
        }
    	for i in 1...6 {
            self.pioche.ajouterCarteCollection(carte : Carte(type : TypedeCarte.Garde))
        }
        for i in 1...5 {
            self.pioche.ajouterCarteCollection(carte : Carte(type : TypedeCarte.Archer))
        }
        for i in 1...9 {
            self.pioche.ajouterCarteCollection(carte : Carte(type : TypedeCarte.Soldat))
        }
        self.pioche.shuffled()
        for i in 1...3 {
            var carteaajoute : Carte
            self.pioche ; carteaajoute = self.pioche.getFirst()
            self.main.ajouterCarteCollection(carte : carteaajoute)
        }
        
    }

    public func estRoiMort(autrejoueur : Joueur) -> Bool {
    	for carte in self.cimetiere {
            if carte.getNomCarte().rawValue == "Roi1" || carte.getNomCarte().rawValue == "Roi2" {
                return true
            }
        }
        for carte in autrejoueur.royaume {
            if carte.getNomCarte().rawValue == "Roi1" || carte.getNomCarte().rawValue == "Roi2" {
                return true
            }
        }
        return false
    }

    public func estMainVide() -> Bool {
        return self.main.estvideCollection()
    }
}
