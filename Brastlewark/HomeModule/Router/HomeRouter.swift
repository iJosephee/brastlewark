//
//  HomeRouter.swift
//  Brastlewark
//
//  Created by Arnold Giuseppe Dominguez Eusebio on 10/2/19.
//  Copyright © 2019 Chimparon. All rights reserved.
//

import Foundation
import UIKit

final class HomeRouter {
    
}

extension HomeRouter: HomePresenterToRouterProtocol {
    
    static func createHomeModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "HomeModule", bundle: Bundle.main)
        let homeNav = storyboard.instantiateViewController(withIdentifier: "HomeNav") as? UINavigationController
        let view = homeNav?.topViewController as? HomeCollectionViewController
        
        let presenter: HomeViewToPresenterProtocol & HomeInteractorToPresenterProtocol = HomePresenter()
        let router: HomePresenterToRouterProtocol = HomeRouter()
        let interactor: HomePresenterToInteractorProtocol = HomeInteractor()
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        view?.presenter = presenter
        
        return homeNav!
    }
    
    func presentDetailScreenFrom(_ view: HomePresenterToViewProtocol, withData gnome: GnomeView) {
        let detail = DetailRouter.createDetailModuleWithInfo(gnome)
        guard let home = view as? UIViewController else {
            return
        }
        home.navigationController?.pushViewController(detail, animated: true)
    }
    
    func presentSearchScreenFrom(_ view: HomePresenterToViewProtocol, withSearchTerm term: String) {
        let search = SearchRouter.createSearchModule()
        guard let home = view as? UIViewController else {
            return
        }
        home.present(search, animated: true, completion: nil)
    }
    
}
