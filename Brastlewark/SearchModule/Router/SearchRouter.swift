//
//  SearchRouter.swift
//  Brastlewark
//
//  Created by Arnold Giuseppe Dominguez Eusebio on 10/4/19.
//  Copyright © 2019 Chimparon. All rights reserved.
//

import Foundation
import UIKit

final class SearchRouter {
    
}

extension SearchRouter: SearchPresenterToRouterProtocol {
    
    static func createSearchModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "SearchModule", bundle: Bundle.main)
        let searchNav = storyboard.instantiateViewController(withIdentifier: "SearchNav") as? UINavigationController
        let view = searchNav?.topViewController as? SearchViewController
        
        let presenter: SearchViewToPresenterProtocol & SearchInteractorToPresenterProtocol = SearchPresenter()
        let router: SearchPresenterToRouterProtocol = SearchRouter()
        let interactor: SearchPresenterToInteractorProtocol = SearchInteractor()
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        view?.presenter = presenter
        
        return searchNav!
    }
    
    func presentDetailScreenFrom(_ view: SearchPresenterToViewProtocol, withData gnome: GnomeView) {
        let detail = DetailRouter.createDetailModuleWithInfo(gnome)
        guard let search = view as? UIViewController else {
            return
        }
        search.navigationController?.pushViewController(detail, animated: true)
    }
    
}
