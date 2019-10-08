//
//  HomePresenter.swift
//  Brastlewark
//
//  Created by Arnold Giuseppe Dominguez Eusebio on 10/2/19.
//  Copyright © 2019 Chimparon. All rights reserved.
//

import Foundation

enum Filter: Int {
    case ageAscending
    case ageDescending
    case none
}

final class HomePresenter {
    var view: HomePresenterToViewProtocol?
    var router: HomePresenterToRouterProtocol?
    var interactor: HomePresenterToInteractorProtocol?
}

extension HomePresenter: HomeViewToPresenterProtocol {
    
    func viewDidLoad() {
        view?.showLoading()
        // validate if already has population
        checkPopulationWith(.none)
    }
    
    func checkPopulationWith(_ filter: Filter) {
        interactor?.checkBrastlewarkPopulation(filter)
    }
    
    func selectedGnome(_ gnome: GnomeView) {
        router?.presentDetailScreenFrom(view!, withData: gnome)
    }
    
    func searchTerm(_ term: String) {
        router?.presentSearchScreenFrom(view!, withSearchTerm: term)
    }
    
}

extension HomePresenter: HomeInteractorToPresenterProtocol {
    
    func checkPopulationResult(_ population: [GnomeView]) {
        if population.count > 0 {
            view?.refreshCollection(population)
            view?.hideLoading()
        } else {
            interactor?.fetchBrastlewarkPopulation()
        }
    }
    
    func fetchGnomesDidSuccess(_ population: [GnomeView]) {
        DispatchQueue.main.sync {
            view?.refreshCollection(population)
            view?.hideLoading()
        }
        // save population in local storag
        DispatchQueue.global(qos: .background).async {
            self.interactor?.saveBrastlewarkPopulation(population)
        }
    }
    
    func fetchGnomesDidFailWithError(_ error: String) {
        DispatchQueue.main.sync {
            view?.hideLoading()
            view?.showErrorMessage("Error", message: error)
        }
    }
    
}
