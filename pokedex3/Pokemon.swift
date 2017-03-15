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
    private var _defense:String!
    private var _height: String!
    private var _weight:String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionName: String!
    private var _nextEvolutionId:String!
    private var _nextEvolutionLevel : String!
    private var _pokemonUrl : String!
    
    
    
    
    var nextEvolutionName : String {
        if _nextEvolutionName == nil{
            _nextEvolutionName = ""
        }
        return _nextEvolutionName
    }
    
    
    var nextEvolutionId : String {
        if _nextEvolutionId == nil{
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    var nextEvolutionLevel :String{
        if _nextEvolutionLevel == nil{
            _nextEvolutionLevel = ""
        }
        return _nextEvolutionLevel
    }
    
    var name:String{
        return _name
    }
    
    var pokeDexId: Int{
        return _pokeDexId
    }
    
    var nextEvolutionTxt : String {
        if _nextEvolutionTxt == nil{
            _nextEvolutionTxt = ""
        }
            return _nextEvolutionTxt
    }
    
    
    var attack : String {
        if _attack == nil{
            _attack = ""
        }
            return _attack
    }
    
    var weight :String{
        if _weight == nil{
            _weight = ""
        }
            return _weight
    }
    
    var height : String {
        if _height == nil{
            _height = ""
        }
        return _height
    }
    
    
    var defense : String {
        if _defense == nil{
            _defense = ""
        }
        return _defense
    }
    
    var type :String{
        if _type == nil{
            _type = ""
        }
        return _type
    }
    var description: String{
        if _description == nil{
            _description = ""
        }
        return _description
    }
    
    
    init(name: String , pokeDexID: Int) {
        self._name = name
        self._pokeDexId = pokeDexID
        self._pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokeDexId!)/"
    }
    
    
    func downloadPokemonDetail(completed: @escaping Downloadcomplete){
        
        Alamofire.request(_pokemonUrl).responseJSON { (response) in
           if let dict = response.result.value as? Dictionary<String , AnyObject> {
                if let weight = dict["weight"] as? String{
                    self._weight = weight
                }
            
                if let height = dict["height"] as? String{
                    
                    self._height = height
                }
            
                if let attack = dict["attack"] as? Int{
                    
                        self._attack = "\(attack)"
                }
            
                if let defense = dict["defense"] as? Int{
                    
                    self._defense = "\(defense)"
                }
            
            if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                if let name = types[0]["name"] {
                    self._type = name.capitalized
                }
                
                if types.count > 1{
                    for x in 1..<types.count{
                        if let name = types[x]["name"]{
                            self._type! += "/\(name.capitalized)"
                        }
                    }
                    
                }
                print(self._type)
                
            }else{
                self._type = ""
            }
            
            
            if let descriptions = dict["descriptions"] as? [Dictionary<String, String>], descriptions.count > 0{
                if let url = descriptions[0]["resource_uri"]{
                    
                    let descrURL = "\(URL_BASE)\(url)"
                    Alamofire.request(descrURL).responseJSON(completionHandler: { (response) in
                        if let dictResult = response.result.value as? Dictionary<String, AnyObject>{
                            if let descpt = dictResult["description"] as? String{
                                let newDescription = descpt.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                
                                self._description = newDescription
                            }
                            
                        }
                           completed()
                        }
                    )
                }
                
            }else{
                self._description = nil
            }
            if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] , evolutions.count > 0 {
                if let nextEvo = evolutions[0]["to"] as? String{
                    if nextEvo.range(of: "mega") == nil{
                        self._nextEvolutionName = nextEvo
                        
                        if let uri = evolutions[0]["resource_uri"] as? String{
                            let newString = uri.replacingOccurrences(of:"/api/v1/pokemon/", with:"")
                            let nextEvoid = newString.replacingOccurrences(of:"/", with:"")
                            
                            self._nextEvolutionId = nextEvoid
                            
                            if let levelExist = evolutions[0]["level"]{
                                if let level = levelExist as? Int{
                                    
                                    self._nextEvolutionLevel = "\(level)"
                                }
                            }else{
                                self._nextEvolutionLevel = ""
                            }
                            
                        }
                    }
                }
                
                
                
            }
            
           // print("The Evolution levels are: \(self._nextEvolutionLevel!) -> \(self._nextEvolutionName!) -> \(self.nextEvolutionId) ")
            }
            
        }
       completed()
    }
}
