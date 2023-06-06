//
//  Video.swift
//  DisneyMoins
//
//  Created by digital on 22/05/2023.
//

import Foundation

struct Video : Hashable
{
    let key : String;
    let type : String;
    
    init(key: String, type: String) {
        self.key = key
        self.type = type
    }
}
