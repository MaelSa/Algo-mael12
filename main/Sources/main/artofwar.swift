// Programme principal
// Art of War
// Ognard-Smague
// 01/12/2018

import Foundation
import carteProtocol
import champDeBatailleProtocol
import collectiondeCarteProtocol
import joueurProtocol
import positionProtocol

//Fonction d'interaction avec l'utilisateur. Demande à l'utilisateur d'entrer un entier pour répondre
// Si il entre 0, il lui sera demander de valider pour quitter le jeu
// Paramètre en entré: text:String --> contient la question posé à l'utilisateur
//					   valMax:Int --> contient l'entier maximum que l'utilisateur peut entré
// Valeur retournée: Int --> retourne la réponse de l'utilisateur qui est obligatoirement un entier
func demande(text:String, valMax:Int)->Int{
	print(text)
	while let rep = readLine(){
		if let ret = Int(rep){
			if  ret <= valMax && ret > 0 {
				return ret
			}
			if ret == 0 {
				print("Voulez-vous vraiment annuler? (o/O pour valider)")
				let val = readLine()
				if val == "o" || val == "O" {
					return 0
				}
			}
		}
		print("Erreur de saisie. Veuillez saisir un nombre correspondant a la reponse de votre choix ou 0 pour annuler\n")
		print(text)
	}
	return 0
}




//----------------------------------------Partie deploiement-----------------------------------------------------------
// Deployer une carte de la main du joueur sur le champ de bataille si il le peut

mutating func deployer(joueur: Joueur) -> Bool {
	if joueur.estMainVide(){
		return false
	}
	var main : CollectiondeCarte
	main = joueur.getMain()
	var itCarte : ItCollection
	var cartes : [Carte]
	itCarte = main.makeIterator()
	var i : Int = 0
	var carte : Carte
	while let carte = itCarte.next(){
		i = i + 1
		print(i,":",carte.getNomCarte())
		cartes.append(carte)
	}
	val = demande(text:"Quel carte voulez-vous deployer?",valMax:i)
	while val == 0 && i > 5{
		val = demande(text: "Vous devez obligatoirement choisir une carte:",valMax:i)
	}
	if val == 0 {
		return false
	}
	cartechoisie = main.supprimerCarteCollection(cartes[val-1])
	var cdbJ : ChampDeBataille
	cdbJ = joueur.getCdB() 
	var royaumeJ : CollectiondeCarte
	royaumeJ = joueur.getRoyaume() 
	while cdbJ.estPlein(){
		suppCarteCDB(joueur: joueur)
		joueur.getRoyaume(carteMV)
	}

	ajoutCarteCDB(joueur: joueur, cartechoisie: cartechoisie)
	return true
}

//Afficher le champ de bataille des deux joueurs
func afficherChampDeBataille(j1: Joueur, j2: Joueur){
	afficherChampDeBatailleJoueur(joueur:j1)
	afficherChampDeBatailleJoueur(joueur:j2)
}

//Aficher le champ de bataille d'un joueur
func afficherChampDeBatailleJoueur(joueur:Joueur){
	var i :Int = 0
	print("Champ de bataille Joueur",joueur.getNom())
	var cdbJ : ChampDeBataille
	cdbJ = joueur.getCdB()
	var itPos = ItCDB
	itPos = cdbJ.makeIterator()
	var carte : Carte

	while let pos = itPos.next(){
		if !pos.getCarteAdverse(){
			carte = pos.getCarte()
			tabPos[pos.getNomPos()] = carte.getNomCarte()
		}
	}
	print("Joueur",joueur.getNom())
	print("\nFront")
	print("F1    F2    F3")
	print(tabPos[NomPosition.F1],"  ",tabPos[NomPosition.F2],"  ",tabPos[NomPosition.F3])
	print("Arriere")
	print("A1   A2   A3")
	print(tabPos[NomPosition.A1],"  ",tabPos[NomPosition.A2],"  ",tabPos[NomPosition.A3])
}


//-------------------------------------------Partie attaque -------------------------------------------------------------------

mutating func attaquer(j1: Joueur, j2: Joueur){
	var attaque : Bool = true
	var i : Int 
	var j : Int 

	var tabPos : [Position]
	var cdbJ1 : ChampDeBataille
	cdbJ1 = j1.getCdB()
	var itPos = ItCDB
	itPos = cdbJ1.makeIterator()
	var cdbJ2 : ChampDeBataille
	cdbJ2 = j2.getCdB()
	var itJ2 = ItCDB
	itJ2 = cdbJ2.makeIterator()
	var tabposAtt = [Position]
	
	cdbJ2.reinitCartes()

	while let pos = itPos.next(){
		tabPos.append(pos)
	}

	while let p = itJ2 = itPos.next(){
		tabposAtt.append(p)
	}
	var carteA : Carte
	while attaque && cdbJ1.estPosDef(){
		print("Carte qui peuvent attaquer:")
		i = 0
		j = 0
		while i < tabPos.count(){
			carteA = tabPos[i].getCarte()
			if tabPos[i].estCarteAdverse() && tabPos[i].estPositionVide() && carteA.estPosDef(){
				j = j + 1
				print(j,":",tabPos[i].getNomPos(), "-->",tabPos[i].getCarte().getNomCarte())
			}
			i = i + 1
		}
		val = demande(text: "Choix de la carte avec laquelle vous souhaitez attaquer", valMax: j)
		if val==0 {
			v = demande(text:"Voulez-vous interrompre la phase d'action?(0:Non / 1: Oui)",valMax:1)
			if v == 1 {
				return
			}
		}
		else{
			var carteattaque : Carte
			carteattaque = tabPos[val-1]
			i = 0
			j = 0
			while i < tabposAtt[i].count(){
				if tabposAtt[i].estCible(carte: carteattaque){
					j = j + 1 
					carteA = tabPos[i]
					print(j,":",tabPos[i].getNomPos(), "-->",carteA.getNomCarte())
				}
				i = i + 1
			}
			if j == 0 {
				print("Aucune cible disponible")
			}
			else{
				val = demande(text : "Choix de la carte que vous souhaitez attaquer", valMax : j)
				if val==0 {
					v = demande(text :"Voulez-vous interrompre la phase d'action?(0:Non / 1: Oui)",valMax:1)
					if v == 1 {
						return
					}
				}
				cdbJ1.mettrePositionOffensive(pos: carteattaque)
				var cartem : Carte?
				var c : Carte
				cartem = cdbJ2.subirAttaque(carteA: carteattaque.getCarte(), posSubit: tabposAtt[val-1])
				if let c = cartem{
					var cimetiere : CollectiondeCarte 
					cimetiere = j1.getCimetiere()
					cimetiere.ajouterCarteCollection(carte: c)
				}

			}
		}
		rep = demande(text: "Voulez-vous poursuivre la phase d'attaque? (0: Non / 1: Oui)",valMax : 1)
		if rep == 0{
			attaque = false
		}
		if partieFinit(j1: j1, j2: j2){
			return
		}

	}
	print("Fin de l'attaque")
}


//--------------------------------------------------------------------Mouvement --------------------------------------------------------------

//Le joueur replace une carte de son Royaume sur le champ de bataille
mutating func replacer(joueur: Joueur) -> Bool {
	var royaumeJ : CollectiondeCarte
	var cartemv : Carte
	royaumeJ = joueur.getRoyaume()
	if royaumeJ.estvideCollection(){
		return false
	}

	cartemv = royaumeJ.sortirCarteCollection()
	royaumeJ.supprimerCarteCollection(carte:cartemv)
	ajoutCarteCDB(joueur: joueur, carte: cartemv)
	return true
}


//Supprime un carte du champ de bataille du joueur
mutating func suppCarteCDB(joueur: Joueur)->Carte{
	var i :Int = 0
	var tabPos : [Position]
	var cdbJ = ChampDeBataille
	cdbJ = joueur.getCdB()
	var itPos : ItCDB 
	itPos = cdbJ.makeIterator()
	while let pos = itPos.next(){
		tabPos.append(pos)
	}
	var carteJ : Carte
	print("Champ de bataille du Joueur", joueur.getNom())
	for position in tabPos{
		if !position.estCarteAdverse(){
			i = i + 1
			carteJ = position.getCarte()
			print(i,": Carte",carteJ.getNomCarte(),"en",position.getNomPos())
		}
			
	}
	val = demande(text:"Quel carte voulez-vous mettre au Royaume?",valMax:i)
	while val == 0 {
		print("Vous devez obligatoirement choisir une carte")
		val = demande(text:"Quel carte voulez-vous mettre au Royaume?",valMax:i )
	}
	carteMV =  cdbJ.enleverCarte(position:tabPos[val-1])
	return carteMV
}


//ajoute une carte sur le champ de bataille
mutating func ajoutCarteCDB(joueur: Joueur, cartechoisie: Carte){
	var i : Int = 0
	var tabPos : [Position]
	print("Position disponible:")
	var cdbJ : ChampDeBataille
	cdbJ = joueur.getCdB()
	var itPos = ItCDB 
	itPos = cdbJ.makeIterator()

	while let pos = itPos.next(){
		if !pos.estCarteAdverse() && pos.estPositionVide(){
			tabPos.append(pos)
			i = i + 1
			print(i,":",pos.getNomPos())
		}
	}

	var cartePose : Bool = false
	while !cartePose{
		val = demande(text:"Position de deploiement?",valMax: i)
		if val != 0{	
			cdbJ.ajoutCarteCDB(carte:cartechoisie, position: tabPos[val-1])
			cartePose = true	
		}
	}
}


//---------------------------------------------Fin de partie -----------------------------------------------------------------------


func partieFinit(j1: Joueur, j2: Joueur)->Bool{
	if j2.estRoiMort(){
		print("Le joueur", j2.getNom(), "a perdu")
		return true
	}
	var cdbJ2 : ChampDeBataille 
	cdbJ2 = j2.getCdB()

	if cdbJ2.estvideCDB(){
		if !remplacer(joueur: j2) {
			if !deployer(joueur:j2) {
				print("Le joueur", j2.getNom(), "a perdu")
    			return true
    		}
    	}
    }
	var piocheJ1 : CollectiondeCarte
	piocheJ1 = j1.getPioche()
	var piocheJ2 : CollectiondeCarte 
	piocheJ2 = j2.getPioche()
	var royaumeJ1 : CollectiondeCarte 
	royaumeJ1 = j1.getRoyaume()
	var royaumeJ2 : CollectiondeCarte 
	royaumeJ2 = j2.getRoyaume()

    if piocheJ1.estvideCollection() || piocheJ2.estvideCollection(){
    	if royaumeJ1.nombreCarteCollection() == royaumeJ2.nombreCarteCollection(){
    		print("Egalité entre les deux joueurs")
    		return true
    	}
    	else if royaumeJ1.nombreCarteCollection() < royaumeJ2.nombreCarteCollection(){
    		print("Le joueur", j2.getNom(), "a gagné")
    		return true
    	}
    	else {
    		print("Le joueur", j1.getNom(), "a gagné")
    		return true
    	}
    }
    return false
}


//-----------------------------------------------------------Programme Principal------------------------------------------------------------------

//Programme principal qui fait jouer une partie du jouer
func programmePrincipal(){
	print("Debut du jeu Art of War.")

	//Création des joueurs
	var j1 : Joueur 
	j1 = Joueur.init("1")
	var j2 : Joueur
	j2 = Joueur.init("2")

	// Initialise la pioche et la main des joueurs
	j1.initialisationJoueur()
	j2.initialisationJoueur()

	// Demande aux joueurs de placer une carte de leur main sur le champ de bataille
	while !deployer(j1){
		print("Deploiement obligatoire")
	}
	while !deployer(j2){
		print("Deploiement obligatoire")
	}

	var partieF : Bool = false
	var joueurActuel : Joueur
	joueurActuel = j1
    var joueurAdverse : Joueur
	joueurAdverse = j2
	print("Debut de la partie")
	var main : CollectiondeCarte
	var tmp : Joueur
	//Debut du tour d'un joueur
	while !partieF{
		print("\nAu tour de", joueurActuel.getNom())

		//Preparation
		passerCartesModeDefensive(joueurActuel.getCdB())
		print("Cartes en position defensive")

		joueurActuel.piocherCarte()

		// Phase d'action
		print("Phase d'action")
		main = joueurActuel.getMain()

		if main.nbCartes() == 6{
			print("Vous avez trop de cartes en main, il va falloir deployer une carte")
			rep = 2
		}
		else {
			rep = demande(text:"Que voulez-vous faire? \n1: Ne rien faire \n2: Deployer une carte \n3:Attaquer\n", valMax:3)
		}
		if rep == 0 {
			print("Le joueur a décidé de quitter la partie")
			return
		}
		if rep == 2{
			if !deployer(joueurActuel){
				print("Deploiement impossible vous allez pouvoir attaquer")
				rep = 3
			}
		}
		if rep == 3{
			attaquer(j1 :joueurActuel, j2: joueurAdverse)
		}
		if partieFinit(j1:joueurActuel, j2:joueurAdverse){
			partieF = true
		}
		tmp = joueurActuel
		joueurActuel = joueurAdverse
		joueurAdverse = tmp
	}
	print("Partie finit")
}


func main(){
	programmePrincipal()
}
