//
//  Pokemon.swift
//  pokedex3
//
//  Created by Ravi Rathore on 2/10/17.
//  Copyright © 2017 com.banago. All rights reserved.
//

import Foundation


class Pokemon : NSObject{
    private var _name : String!
    private var _id : Int!
    var name : String{
        return _name
    }
    var id : Int{
        return _id
    }
    
    init(name: String , pokeid : Int) {
        self._id = pokeid
        self._name = name
    }
    override var description: String{
        return "\(_name) and \(_id)"
    }
    
}
