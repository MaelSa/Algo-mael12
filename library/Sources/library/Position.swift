import Foundation 

public struct Position : PositionProtocol{
    public typealias CarteProtocol = Carte

	
	internal var nomposition : NomPosition
    internal var carte : Carte?

    public init(nom : NomPosition, carte : Carte?) {
        self.nomposition = nom
        self.carte = carte
    }

    public func getNomPos() -> String {
        switch self.nomposition {
            case .F1 :
                return "F1"
            case .F2 :
                return "F2"
            case .F3 :
                return "F3"
            case .A1 :
                return "A1"
            case .A2 :
                return "A2"
            case .A3 :
                return "A3"
        }
    }

    public func estPositionVide() -> Bool {
    	return self.carte == nil
    }

    public func getCarte() -> Carte? {
        if let carte = self.carte {
            return carte
        }
        else {
            return nil
        }
    }

    public func getCarteAdverse() -> Bool {
        if self.estPositionVide() {
            return false
        }
        else {
            return self.getCarte()!.getAppartientJ1()
        }
        
    }

}