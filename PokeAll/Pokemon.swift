//
//  PokeData.swift
//  PokeAll
//
//  Created by Ravi Krishna on 10/1/16.
//  Copyright © 2016 rk. All rights reserved.
//

import Foundation

class Pokemon {
    var name:String!
    var pokeID:String!
    var height:String!
    var weight:String!
    
    init(name:String,pokeID:String) {
        self.name = name
        self.pokeID = pokeID
    }
}

