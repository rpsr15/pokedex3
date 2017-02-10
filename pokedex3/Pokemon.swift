//
//  Pokemon.swift
//  pokedex3
//
//  Created by Ravi Rathore on 2/10/17.
//  Copyright © 2017 com.banago. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon : NSObject{
    private var _name : String!
    private var _id : Int!
    private var _pokemonURL :String!
    private var _description: String!
    private var _type : String!
    private var _defense : String!
    private var _height: String!
    private var _weight: String!
    private var _attack : String!
    private var _nextEvolutionTxt : String!
    private var _nextEvolutionId : String!
    
    var nextEvolutionId : String{
        if _nextEvolutionId == nil{
            _nextEvolutionId = ""
        }
        return _nextEvolutionId
    }
    
    
    var details : String{
        if _description == nil {
            _description =  ""
        }
        return _description
    }
    var weight : String{
        if _weight == nil {
            _weight =  ""
        }
        return _weight
    }
    var height : String{
        if _height == nil {
            _height =  ""
        }
        return _height
    }
    var defense : String{
        if _defense == nil {
            _defense =  ""
        }
        return _defense
    }
    var type : String{
        if _type == nil {
            _type =  ""
        }
        return _type
    }
    var attack : String{
        if _attack == nil {
            _attack =  ""
        }
        return _attack
    }
    var nextEvolutoinText : String{
        if _nextEvolutionTxt == nil {
            _nextEvolutionTxt =  ""
        }
        return _nextEvolutionTxt
    }
    var name : String{
        return _name
    }
    var id : Int{ 
        return _id
    }
    
    init(name: String , pokeid : Int) {
        self._id = pokeid
        self._name = name
        self._pokemonURL = URL_BASE + URL_POKEMON + "\(pokeid)"
    }
    override var description: String{
        return "\(_name) and \(_id) "
    }
    func downloadPokemonDetails(completed : @escaping DownloadComplete){
        print(#function)
        print(self._pokemonURL)
        Alamofire.request(
            URL(string: self._pokemonURL)!,
            method: .get,
            parameters: ["include_docs": "true"])
            .validate()
            .responseJSON { (response) -> Void in
                
                if let dict = response.result.value as? [String : Any]{
                
                    if let descArr = dict["descriptions"] as? [[String : Any]]{
                       
                      
                       if let desc = descArr.first{
                            
                            if let path = desc["resource_uri"] as? String
                            {
                                let url = URL_BASE + path
                                print(url)
                                Alamofire.request(URL(string: url)!, method: .get, parameters: ["include_docs" : "true"]).validate().responseJSON(completionHandler: { (response) in
                                    
                                    if let jsonData = response.result.value as? [String:Any]{
                                        if let dString = jsonData["description"] as? String{
                                            self._description = dString
                                        }
                                    }
                                    completed()
                                })
                                
                                
                            }
                        }
                       
                    }
                    
                    if let evolutions = dict["evolutions"] as? [[String : Any]]{
                        if let evolution = evolutions.first{
                            if let name = evolution["to"] as? String {
                                self._nextEvolutionTxt = "Next Evolutioin is \(name)"
                            }
                            if let path = evolution["resource_uri"] as? String{
                                if let id = getId(path: path){
                                    self._nextEvolutionId = id
                                }
                            }
                        }
                    }
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
                    var typeString = ""
                    if let types = dict["types"] as? [[String : Any]]{
                        for type in types{
                            if let typeName = type["name"] as? String{
                                if typeString == ""{
                                typeString.append(typeName)
                            }
                                else{
                                    typeString.append("/\(typeName)")
                                }
                                
                                
                        }
                    }
                       self._type = typeString.capitalized
                        print(typeString)
                    
                }
                
                completed()
                    return
                }
}
    }
}
