//
//  SearchProtocols.swift
//  Brastlewark
//
//  Created by Arnold Giuseppe Dominguez Eusebio on 10/4/19.
//  Copyright © 2019 Chimparon. All rights reserved.
//

import Foundation
import UIKit

protocol SearchViewToPresenterProtocol: class {
    var view: SearchPresenterToViewProtocol? {get set}
    var router: SearchPresenterToRouterProtocol? {get set}
    var interactor: SearchPresenterToInteractorProtocol? {get set}
    func searchTerm(_ term: String)
    func selectedGnome(_ gnome: GnomeView)
}

protocol SearchPresenterToViewProtocol: class {
    var presenter: SearchViewToPresenterProtocol? {get set}
    func refreshSearchResults(_ results: [GnomeView])
    func setNotResults()
}

protocol SearchInteractorToPresenterProtocol: class {
    func searchResults(_ results: [GnomeView])
}

protocol SearchPresenterToInteractorProtocol: class {
    var presenter: SearchInteractorToPresenterProtocol? {get set}
    func fetchCitizensByTerm(_ term: String)
}

protocol SearchPresenterToRouterProtocol: class {
    static func createSearchModule() -> UIViewController
    func presentDetailScreenFrom(_ view: SearchPresenterToViewProtocol, withData gnome: GnomeView)
}
