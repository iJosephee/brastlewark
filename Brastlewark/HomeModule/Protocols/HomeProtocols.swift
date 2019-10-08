//
//  HomeProtocols.swift
//  Brastlewark
//
//  Created by Arnold Giuseppe Dominguez Eusebio on 10/2/19.
//  Copyright © 2019 Chimparon. All rights reserved.
//

import Foundation
import UIKit

protocol HomeViewToPresenterProtocol: class {
    var view: HomePresenterToViewProtocol? {get set}
    var router: HomePresenterToRouterProtocol? {get set}
    var interactor: HomePresenterToInteractorProtocol? {get set}
    func viewDidLoad()
    func checkPopulationWith(_ filter: Filter)
    func selectedGnome(_ gnome: GnomeView)
    func searchTerm(_ term: String)
}

protocol HomePresenterToViewProtocol: class {
    var presenter: HomeViewToPresenterProtocol? {get set}
    func refreshCollection(_ pupulation: [GnomeView])
    func showLoading()
    func hideLoading()
    func showErrorMessage(_ title: String?, message: String?)
}

protocol HomeInteractorToPresenterProtocol: class {
    func checkPopulationResult(_ population: [GnomeView])
    func fetchGnomesDidSuccess(_ population: [GnomeView])
    func fetchGnomesDidFailWithError(_ errror: String)
}

protocol HomePresenterToInteractorProtocol: class {
    var presenter: HomeInteractorToPresenterProtocol? {get set}
    func checkBrastlewarkPopulation(_ filter: Filter)
    func fetchBrastlewarkPopulation()
    func saveBrastlewarkPopulation(_ population: [GnomeView])
}

protocol HomePresenterToRouterProtocol: class {
    static func createHomeModule() -> UIViewController
    func presentDetailScreenFrom(_ view: HomePresenterToViewProtocol, withData gnome: GnomeView)
    func presentSearchScreenFrom(_ view: HomePresenterToViewProtocol, withSearchTerm term: String)
}
