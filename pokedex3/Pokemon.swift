//
//  Pokemon.swift
//  pokedex3
//
//  Created by OKUSANYA KAYODE DAMILARE on 3/7/17.
//  Copyright © 2017 OKUSANYA KAYODE DAMILARE. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    private var _name: String!
    private var _pokeDexId: Int!
    private var _description: String!
    private var _type: String!
    private var _defence:String!
    private var _height: String!
    private var _weight:String!
    private var _attack: String!
    private var _nextEvolution: String!
    private var _pokemonUrl : String!
    
    
    
    
    var name:String{
        return _name
    }
    
    var pokeDexId: Int{
        return _pokeDexId
    }
    
    init(name: String , pokeDexID: Int) {
        self._name = name
        self._pokeDexId = pokeDexID
        self._pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokeDexId)/"
    }
    
    
    func downloadPokemonDetail(completed: Downloadcomplete){
        Alamofire.request(_pokemonUrl).responseJSON { (response) in
           if let dict = response.result.value as? Dictionary<String , AnyObject> {
                if let weight = dict["weight"] as? String{
                    self._weight = weight
                }
            
                if let height = dict["height"] as? String{
                    
                    self._height = height
                }
            
                if let attack = dict["attack"] as? String{
                    
                    self._attack = attack
                }
            
                if let defence = dict["defence"] as? String{
                    
                    self._defence = defence
                }
            }
        }
        
    }
}
