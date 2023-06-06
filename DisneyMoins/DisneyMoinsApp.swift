//
//  DisneyMoinsApp.swift
//  DisneyMoins
//
//  Created by digital on 04/04/2023.
//

import SwiftUI

@main
struct DisneyMoinsApp: App {
    @StateObject var viewModel = FilmViewModel()
    
    var body: some Scene {
        WindowGroup {
            ListView().environmentObject(viewModel)
        }
    }
}
