//
//  Pokemon.swift
//  pokedex3
//
//  Created by OKUSANYA KAYODE DAMILARE on 3/7/17.
//  Copyright © 2017 OKUSANYA KAYODE DAMILARE. All rights reserved.
//

import Foundation

class Pokemon {
    private var _name: String!
    private var _pokeDexId: Int!
    
    
    
    var name:String{
        return _name
    }
    
    var pokeDexId: Int{
        return _pokeDexId
    }
    
    init(name: String , pokeDexID: Int) {
        self._name = name
        self._pokeDexId = pokeDexID
    }
    
}
