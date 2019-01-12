import Foundation

public struct ChampDeBataille : ChampDeBatailleProtocol {
    public typealias PositionProtocol = Position
    public typealias CarteProtocol = Carte
    public typealias CollectiondeCarteProtocol = CollectionDeCartes



    internal var positionT : [Position]

    public init(){
    	self.positionT = [Position](repeating: nil, count: 6)
    }

    public func estVideCDB() -> Bool {
    	var res = true
        for pos in self.positionT {
            if !pos.estPositionVide() {
                res = false
            }
        }
        return res
    }

    public func estPlein() -> Bool {
    	var res = true
        for pos in self.positionT {
            if pos.estPositionVide() {
                res = false
            }
        }
        return res
    }

    public mutating func ajouterCarteCDB(carte : Carte, position : Position, main : CollectionDeCartes) -> ChampDeBataille {
        var index = -1
        for pos in self.positionT {
            index += 1
            if pos.getNomPos() == position.getNomPos() {
                if position.estPositionVide() {
                    self.positionT[index] = carte
                }
                else { //s'il y a deja une carte sur le board on fait l'echange des 2 cartes
                    var cartearenvoyer = pos.getCarte()
                    self = self.enleverCarteCDB(position : position)
                    main = main.ajouterCarteCollection(cartearenvoyer : Carte) //ya une couy
                    self.positionT[index] = carte
                }
            }
        }
        return self
    }

    public mutating func enleverCarteCDB(position : Position) -> ChampDeBataille {
        var index = 0
        for pos in self.positionT {
            index += 1
            if pos.getnomPos() == position.getNomPos() {
                self.positionT[] = nil
            }
        }
        return self
    }

    public func getcarteCDB(position : Position) -> Carte? {
        return position.getCarte()
    }

    public func makeIterator() -> ItCDB {
        return ItCDB(champ : self)
    }

    public mutating func reinitCartes() -> ChampDeBataille {
        var index = 0
        for pos in self.positionT {
            if !pos.estPositionVide() {
                self.positionT[index] = pos.getCarte()!.reinitCarte()
            }
            else {
                self.positionT[index] = pos
            }
            index += 1
        }
        return self
    }

    public func estPosDef() -> Bool {
        var res = true
        for pos in self.positionT {
            if let carte = pos.getCarte() {
                if !pos.estPositionVide() && !carte.getEstPositionDef() {
                    res = false
                }
        }
        return res
    }

    public mutating func mettrePositionOffensive(pos : Position) -> ChampDeBataille {
        if let carte = pos.getCarte() {
            var index = 0
            for posi in self.positionT {
                if posi.getNomPos() == pos.getNomPos() {
                    var newcarte = carte
                    self.positionT[index] = Position(nom : carte.getNomPos(), carte : newcarte).mettrepositionOff()
                }
                index += 1
            }
        }
        return self
    }

    public mutating func subirattaque(carteA : Carte, posSubie : Position) -> Bool {
        var index = 0
        for pos in self.positionT {
            if pos.getNomPos() == posSubie.getNomPos() {
                if let temp = self.positionT[index].getCarte() {
                    var carte = temp
                    if carte.getEstPositionDef() {
                        if carte.getnbdegats() == 0 && carte.getnbdefenseendefense() == carteA.getValAtq() {
                            carte.setnbdegats(val : 0)
                            self = self.enleverCarteCDB(position : posSubie)
                            //ajouter a la carte detruite au royaume du joueur attaquant
                        }else {
                            carte.setnbdegats(val : carte.getnbdegats() + carteA.getValAtq())
                            if carte.getnbdefenseendefense() <= carte.getnbdegats() + carteA.getValAtq() {
                                carte.setnbdegats(val : 0)
                                self = self.enleverCarteCDB(position : posSubie)
                            }else {
                                carte.setnbdegats(val : carte.getnbdegats() + carteA.getValAtq())
                            }
                        }
                    } else {
                        if carte.getnbdegats() == 0 && carte.getnbdefenseenattaque() == carteA.getValAtq() {
                            carte.setnbdegats(val : 0)
                            self = self.enleverCarteCDB(position : posSubie)
                            //ajouter a la carte detruite au royaume du joueur attaquant
                        }else {
                            carte.setnbdegats(val : carte.getnbdegats() + carteA.getValAtq())
                            if carte.getnbdefenseenattaque() <= carte.getnbdegats() + carteA.getValAtq() {
                                carte.setnbdegats(val : 0)
                                self = self.enleverCarteCDB(position : posSubie)
                            }else {
                                carte.setnbdegats(val : (carte.getnbdegats() + carteA.getValAtq()))
                            }
                        }
                    }
                    return true
                }
                else {
                    return false
                }
            }
        index += 1
        }
        
    }


}

public struct ItCDB : IteratorProtocol {

    fileprivate var indexCourant : Int = 0
	fileprivate let cdb : ChampDeBataille

    fileprivate init(champ : ChampDeBataille) {
        self.cdb = champ
    }

    public mutating func next() -> Position? {
        guard self.indexCourant < 6 else { return nil }
	    guard let pos = self.cdb.positionT[self.indexCourant] else {
		    self.indexCourant += 1
		    return self.next()
	    }
	    self.indexCourant += 1
	    return pos
    }
}
