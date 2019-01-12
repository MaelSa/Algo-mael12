import Foundation


struct Carte : CarteProtocol {

    internal var nomcarte : TypedeCarte
    internal var nbattaque : Int
    internal var nbdefense : Int
    internal var nbdefenseendefense :  Int
    internal var nbdefenseenattaque : Int
    internal var listeporte : [NomPosition]
    internal var nbdegat : Int
    internal var estpositiondef : Bool
    internal var appartientJ1 : Bool

    init(type : TypedeCarte){
    	nbdegat = 0
    	nomcarte = type
        estpositiondef = true

    	switch type{
    	 case .Roi1:
    	 	nbattaque = 1
    	 	nbdefenseendefense = 4
    	 	nbdefenseenattaque = 4
    	 case .Roi2:
    	 	nbattaque = 1
    	 	nbdefenseendefense = 5
    	 	nbdefenseenattaque = 4
    	 case .Garde:
    	 	nbattaque = 1
    	 	nbdefenseendefense = 2
    	 	nbdefenseenattaque = 1
    	 case .Soldat:
    	 	nbattaque = 0
    	 	nbdefenseendefense = 2
    	 	nbdefenseenattaque = 1
    	 case .Archer:
    	 	nbattaque = 1
    	 	nbdefenseendefense = 2
    	 	nbdefenseenattaque = 1

            
    	 }
        var nbdefense = nbdefenseenattaque 
    	}
    public func getNomCarte() -> TypedeCarte{
    	return self.nomcarte
    	}

    
    public func getValDef() -> Int{
    	return self.nbdefense
    	}
    

    public func getValAtq() -> Int{
    	return self.nbattaque
    } 

    public func getEstPositionDef() -> Bool{
    	return !self.estpositiondef
    }

    public func getPortee () -> String?{
        if self.listeporte.count == 0{
            return nil
	    }
        else{
            var stringportee = ""
            for i in self.listeporte{
                    stringportee += i.getNomPos
                }
            return stringportee
            }
        }
    

    public mutating func mettrepositionOff() -> Carte{
        self.estpositiondef = true
        self.nbdefense = self.nbdefenseenattaque
        return self
        }

    public mutating func mettrepositionDef() -> Carte{
        self.estpositiondef = false
        self.nbdefense = self.nbdefenseendefense
        return self
    }
    public mutating func subirDegats(nombreDegats : Int) throws -> Carte{
        self.nbdefense -= nombreDegats
        self.nbdegat += nombreDegats
        return self
    }

    public func nombreDegats() -> Int{
        return self.getValAtq()
    }
	
    public func getnbdegats() ->Int{
	    return self.nbdegat
    }

    public mutating func setnbdegats(val : Int) -> Carte{
        self.nbdegat += val
        return self
    }
    
    public mutating func reinitCarte()-> Carte{
        if self.getEstPositionDef(){
            self.nbdefense = self.nbdefenseendefense
        }
        else {
            self.nbdefense = self.nbdefenseenattaque
        }
        self.nbdegat = 0
        return self
    }

    public mutating func changeValAtq (val: Int) throws -> Carte{
        self.nbattaque += val
        return self
    }

    public func getnbdefenseendefense() -> Int{
        return self.nbdefenseendefense
    }
    
    public func getnbdefenseenattaque() -> Int{
        return self.nbdefenseenattaque
    }

    public func getAppartientJ1() -> Bool {
        return self.appartientJ1
    }

    public mutating func setAppartientJ1(boolJ1 : Bool) -> Carte {
        self.appartientJ1 = boolJ1
        return self
    }
}

    
    
