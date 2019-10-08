//
//  HomeInteractor.swift
//  Brastlewark
//
//  Created by Arnold Giuseppe Dominguez Eusebio on 10/2/19.
//  Copyright © 2019 Chimparon. All rights reserved.
//

import Foundation

final class HomeInteractor {
    var presenter: HomeInteractorToPresenterProtocol?
}

extension HomeInteractor: HomePresenterToInteractorProtocol {
    
    func checkBrastlewarkPopulation(_ filter: Filter) {
        let descriptors: [NSSortDescriptor]?
        switch filter {
        case .ageAscending:
            descriptors = [NSSortDescriptor(key: "age", ascending: true)]
        case .ageDescending:
            descriptors = [NSSortDescriptor(key: "age", ascending: false)]
        case .none:
            descriptors = nil
        }
        let population = StorageServices.shared.fetchGnomesPopulation(descriptors)
        var gnomesView : [GnomeView] = []
        for gnome in population {
            let gnomeView = GnomeView(Int(gnome.id), name: gnome.name, thumbnail: gnome.thumbnail, age: Int(gnome.age), weight: gnome.weight, height: gnome.height, hair_color: gnome.hair_color, professions: gnome.professions, friends: gnome.friends)
            gnomesView.append(gnomeView)
        }
        presenter?.checkPopulationResult(gnomesView)
    }
    
    func fetchBrastlewarkPopulation() {
        NetworkServices.shared.fetchBrastlewark("") { (success, brastlewarkResponse) in
            if success {
                if let brastlewark = brastlewarkResponse?.brastlewark {
                    var population: [GnomeView] = []
                    for gnome in brastlewark {
                        let gnomeView = GnomeView(Int(gnome.id ?? -1), name: gnome.name, thumbnail: gnome.thumbnail, age: gnome.age, weight: gnome.weight, height: gnome.height, hair_color: gnome.hair_color, professions: gnome.professions, friends: gnome.friends)
                        population.append(gnomeView)
                    }
                    self.presenter?.fetchGnomesDidSuccess(population)
                } else {
                    self.presenter?.fetchGnomesDidFailWithError(NSLocalizedString("Alert.Message", tableName: "HomeModule", bundle: Bundle.main, value: "", comment: ""))
                }
            } else {
                self.presenter?.fetchGnomesDidFailWithError(NSLocalizedString("Alert.Message", tableName: "HomeModule", bundle: Bundle.main
                    , value: "", comment: ""))
            }
        }
    }
    
    func saveBrastlewarkPopulation(_ population: [GnomeView]) {
        for gnome in population {
            print("Saving: \(gnome.iden ?? -1)")
            StorageServices.shared.saveGnome(gnome.iden ?? -1, name: gnome.name ?? "", thumbnail: gnome.thumbnail ?? "", age: gnome.age ?? -1, weight: gnome.weight ?? -1.0, height: gnome.height ?? -1.0, hair_color: gnome.hair_color ?? "", professions: gnome.professions ?? [], friends: gnome.friends ?? [])
        }
    }
    
}
