//
//  DetailPresenter.swift
//  Brastlewark
//
//  Created by Arnold Giuseppe Dominguez Eusebio on 10/3/19.
//  Copyright © 2019 Chimparon. All rights reserved.
//

import Foundation

final class DetailPresenter {
    var view: DetailPresenterToViewProtocol?
    var router: DetailPresenterToRouterProtocol?
    var interactor: DetailPresenterToInteractorProtocol?
    var gnome: GnomeView?
}

extension DetailPresenter: DetailViewToPresenterProtocol {
    
    func goBackToHome() {
        router?.navigateBackToHomeScreen(from: view!)
    }
    
    func getProfilePhoto() -> URL? {
        return URL(string: gnome!.thumbnail!)
    }
    
    func getName() -> String {
        if let a = gnome?.name {
            return a
        } else {
            return ""
        }
    }
    
    func getAge() -> String {
        if let a = gnome?.age {
            return String(a)
        } else {
            return ""
        }
    }
    
    func getWeight() -> String {
        if let w = gnome?.weight {
            return String(format: "%.2f kg", w)
        } else {
            return ""
        }
    }
    
    func getHeight() -> String {
        if let h = gnome?.height {
            return String(format: "%.2f cm", h)
        } else {
            return ""
        }
    }
    
    func getFriends(){
        if let friends = gnome?.friends {
            view?.refreshCollection(friends)
        }
    }
    
    func getGnomeFromName(_ name: String) -> GnomeView? {
        return interactor?.getGnome(name)
    }
}

extension DetailPresenter: DetailInteractorToPresenterProtocol {
    
}
