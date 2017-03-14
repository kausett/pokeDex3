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
        nameLbl.text = pokemon.name
        pokemon.downloadPokemonDetail {
            //what ever we rite here will only be called after the network is completed
            self.updateUI()
        }
    
    }
    
    func updateUI(){
        
        
    }
    @IBAction func backbButtonPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}
