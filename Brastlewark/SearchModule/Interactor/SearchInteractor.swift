//
//  SearchInteractor.swift
//  Brastlewark
//
//  Created by Arnold Giuseppe Dominguez Eusebio on 10/4/19.
//  Copyright © 2019 Chimparon. All rights reserved.
//

import Foundation

final class SearchInteractor {
    var presenter: SearchInteractorToPresenterProtocol?
}

extension SearchInteractor: SearchPresenterToInteractorProtocol {
    
    func fetchCitizensByTerm(_ term: String) {
        let matches = StorageServices.shared.fetchGnomesByTerm(term)
        var result : [GnomeView] = []
        for gnome in matches {
            let gnomeView = GnomeView(Int(gnome.id), name: gnome.name, thumbnail: gnome.thumbnail, age: Int(gnome.age), weight: gnome.weight, height: gnome.height, hair_color: gnome.hair_color, professions: gnome.professions as? [String], friends: gnome.friends as? [String])
            result.append(gnomeView)
        }
        presenter?.searchResults(result)
    }
    
}
