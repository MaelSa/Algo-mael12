import Foundation

struct  CollectionDeCartes : CollectiondeCarteProtocol {
	public typealias CarteProtocol = Carte
    internal var cartes : [Carte]


	init(){
		cartes = []
		
	}

    public func estvideCollection () -> Bool{
    	return self.cartes.count == 0
    }

    public mutating func ajouterCarteCollection (carte : Carte) -> CollectionDeCartes{
    	self.cartes.append(carte)
    	return self
    }

    public mutating func supprimerCarteCollection(carte : Carte) -> (CollectionDeCartes, Carte){
    	var compt = self.cartes.count
    	if !self.estvideCollection(){
    		var i = 0
    		var foundcarte = false
    		var cardremoved : Carte
    		while !foundcarte && i<compt{
    			if cartes[i] === carte{
    				cardremoved = cartes[i]
    				self.cartes.remove(at : i)
    				foundcarte = true
    			}
    			i += 1
    		}
    		return (self, cardremoved)
    	}
    	else {
			
    		return self; nil
    	}
    }

    public mutating func sortirCarteCollection() -> (CollectionDeCartes, Carte?){
		var cardremoved : Carte
    	if !self.estvideCollection(){
    		cardremoved = self.cartes[self.cartes.count - 1]
    		self.cartes.remove(at : self.cartes.count - 1)
    		return (self, cardremoved)
    	}
    	else {
    		return (self, nil)
    	}
    }

    public func nombreCarteCollection () -> Int{
    	return self.cartes.count
    }

    public func makeIterator() -> ItCollection{
    	return ItCollection(main : self)
    }

    public mutating func getFirst() -> (CollectionDeCartes, Carte?){
		var cardremoved : Carte
    	if !self.estvideCollection(){
    		cardremoved = self.cartes[0]
    		self.cartes.remove(at : 0)
    		return self; cardremoved
    	}
    	else{
			
    		return self; nil
    	}
    }

	public func comparer(carte1 : Carte, carte2 : Carte) -> Bool{
		return carte1.nbattaque == carte2.nbattaque && carte1.nbdefenseendefense == carte2.nbdefenseendefense && carte1.nbdefenseenattaque == carte2.nbdefenseenattaque && carte1.nbdegat == carte2.nbdegat && carte1.estpositiondef == carte2.estpositiondef && carte1.appartientJ1 == carte2.appartientJ1

	}

}

public struct ItCollection : IteratorProtocol {
	fileprivate var indexCourant : Int = 0
	fileprivate let carte : Carte?
	fileprivate var main : CollectionDeCartes

	init(main : CollectionDeCartes) {
		self.main = main
	}

	public mutating func next() -> Carte?{
		guard self.indexCourant  < 6 else { return nil }
		guard let carte = self.main.cartes[self.indexCourant] else {
			self.indexCourant += 1
			return self.next()
		}
		self.indexCourant += 1
		return carte 
	}
}
