//
//  PokemonDetailedVC.swift
//  pokedex3
//
//  Created by OKUSANYA KAYODE DAMILARE on 3/13/17.
//  Copyright © 2017 OKUSANYA KAYODE DAMILARE. All rights reserved.
//

import UIKit

class PokemonDetailedVC: UIViewController {

    var pokemon : Pokemon!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var mainImg: UIImageView!
    @IBOutlet weak var descriptionLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var defenceLbl: UILabel!
    @IBOutlet weak var heightLbl: UILabel!
    @IBOutlet weak var pokedexLbl: UILabel!
    @IBOutlet weak var weightLbl: UILabel!
    @IBOutlet weak var attackLbl: UILabel!
    @IBOutlet weak var currentEvoImagee: UIImageView!
    @IBOutlet weak var nextEvoImage: UIImageView!
    @IBOutlet weak var evoLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLbl.text = pokemon.name.capitalized
        let img = UIImage(named: "\(pokemon.pokeDexId)")
        mainImg.image = img
        currentEvoImagee.image = img
        pokedexLbl.text = "\(pokemon.pokeDexId)"
        
        pokemon.downloadPokemonDetail {
            print("Did Arrived here")
            //what ever we rite here will only be called after the network is completed
            self.updateUI()
        }
    
    }
    
    func updateUI(){
        attackLbl.text = pokemon.attack
        defenceLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        typeLbl.text    = pokemon.type
        descriptionLbl.text = pokemon.description
        
        if pokemon.nextEvolutionId == ""{
            evoLbl.text = "No Evolution"
            nextEvoImage.isHidden = true
        }else{
            nextEvoImage.isHidden = false
            nextEvoImage.image = UIImage(named: pokemon.nextEvolutionId)
            let str = "Next Evololution: \(pokemon.nextEvolutionName) - LVL \(pokemon.nextEvolutionLevel)"
            evoLbl.text = str
            
        }
        
    }
    @IBAction func backbButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
