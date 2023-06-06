//
//  FilmController.swift
//  DisneyMoins
//
//  Created by digital on 17/04/2023.
//

import Foundation
import UIKit

class FilmController : UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Task{
            await loadData()
        }
    }
    
    
}
