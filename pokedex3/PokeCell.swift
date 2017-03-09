//
//  PokeCell.swift
//  pokedex3
//
//  Created by OKUSANYA KAYODE DAMILARE on 3/8/17.
//  Copyright © 2017 OKUSANYA KAYODE DAMILARE. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var thumbImg: UIImageView!
    @IBOutlet weak var namelbl: UILabel!
    
    var pokemon : Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        layer.cornerRadius = 5.0
    }

    
    
    func ConfigureCell(pokemon: Pokemon){
        self.pokemon = pokemon
        namelbl.text = self.pokemon.name.capitalized
        thumbImg.image = UIImage(named: "\(self.pokemon.pokeDexId)")
    }
    
    
}
