//
//  DetailInteractor.swift
//  Brastlewark
//
//  Created by Arnold Giuseppe Dominguez Eusebio on 10/3/19.
//  Copyright © 2019 Chimparon. All rights reserved.
//

import Foundation

final class DetailInteractor {
    var presenter: DetailInteractorToPresenterProtocol?
}

extension DetailInteractor: DetailPresenterToInteractorProtocol {
    
    func getGnome(_ name: String) -> GnomeView? {
        let gnomes = StorageServices.shared.fetchGnomesByName(name)
        if let gnome = gnomes.last {
            let gnomeView = GnomeView(Int(gnome.id), name: gnome.name, thumbnail: gnome.thumbnail, age: Int(gnome.age), weight: gnome.weight, height: gnome.height, hair_color: gnome.hair_color, professions: gnome.professions, friends: gnome.friends)
            return gnomeView
        } else {
            return nil
        }
    }
    
}
