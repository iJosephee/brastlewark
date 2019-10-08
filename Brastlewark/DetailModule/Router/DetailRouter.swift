//
//  DetailRouter.swift
//  Brastlewark
//
//  Created by Arnold Giuseppe Dominguez Eusebio on 10/3/19.
//  Copyright © 2019 Chimparon. All rights reserved.
//

import Foundation
import UIKit

final class DetailRouter {
    
}

extension DetailRouter: DetailPresenterToRouterProtocol {
    
    static func createDetailModuleWithInfo(_ gnome: GnomeView) -> UIViewController {
        let storyboard = UIStoryboard(name: "DetailModule", bundle: Bundle.main)
        let view = storyboard.instantiateViewController(withIdentifier: "Detail") as? DetailViewController
        
        let presenter: DetailViewToPresenterProtocol & DetailInteractorToPresenterProtocol = DetailPresenter()
        let router: DetailPresenterToRouterProtocol = DetailRouter()
        let interactor: DetailPresenterToInteractorProtocol = DetailInteractor()
        
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        presenter.gnome = gnome
        interactor.presenter = presenter
        view?.presenter = presenter
        
        return view!
    }
    
    func navigateBackToHomeScreen(from view: DetailPresenterToViewProtocol) {
        guard let detail = view as? UIViewController else {
            fatalError("Invalid View Protocol type")
        }
        detail.navigationController?.popViewController(animated: true)
    }
    
}
