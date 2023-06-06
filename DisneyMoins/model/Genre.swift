//
//  Genre.swift
//  DisneyMoins
//
//  Created by digital on 18/04/2023.
//

import Foundation

struct Genre : Hashable
{
    let id : Int;
    let name : String;
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}
