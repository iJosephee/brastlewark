//
//  SearchPresenter.swift
//  Brastlewark
//
//  Created by Arnold Giuseppe Dominguez Eusebio on 10/4/19.
//  Copyright © 2019 Chimparon. All rights reserved.
//

import Foundation

final class SearchPresenter {
    var view: SearchPresenterToViewProtocol?
    var router: SearchPresenterToRouterProtocol?
    var interactor: SearchPresenterToInteractorProtocol?
}

extension SearchPresenter: SearchViewToPresenterProtocol {

    func searchTerm(_ term: String) {
        interactor?.fetchCitizensByTerm(term)
    }
    
    func selectedGnome(_ gnome: GnomeView) {
        router?.presentDetailScreenFrom(view!, withData: gnome)
    }
    
}

extension SearchPresenter: SearchInteractorToPresenterProtocol {
    
    func searchResults(_ results: [GnomeView]) {
        if results.count == 0 {
            view?.setNotResults()
        } else {
            view?.refreshSearchResults(results)
        }
    }
    
}
