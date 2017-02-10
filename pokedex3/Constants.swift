//
//  Constants.swift
//  pokedex3
//
//  Created by Ravi Rathore on 2/10/17.
//  Copyright © 2017 com.banago. All rights reserved.
//

import Foundation
let URL_BASE = "http://pokeapi.co"
let URL_POKEMON = "/api/v1/pokemon/"
typealias DownloadComplete = () -> ()

func getId( path : String) -> String?{
    var test = path
    if  let range = test.range(of: "/api/v1/pokemon/") {
    test.removeSubrange(range)
    return test.replacingOccurrences(of: "/", with: "")
    }
    else{
        return nil
    }
}
