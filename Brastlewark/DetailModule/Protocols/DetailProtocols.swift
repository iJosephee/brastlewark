//
//  DetailProtocols.swift
//  Brastlewark
//
//  Created by Arnold Giuseppe Dominguez Eusebio on 10/3/19.
//  Copyright © 2019 Chimparon. All rights reserved.
//

import Foundation
import UIKit

protocol DetailViewToPresenterProtocol: class {
    var view: DetailPresenterToViewProtocol? {get set}
    var router: DetailPresenterToRouterProtocol? {get set}
    var interactor: DetailPresenterToInteractorProtocol? {get set}
    var gnome: GnomeView? {get set}
    func goBackToHome()
    func getProfilePhoto() -> URL?
    func getName() -> String
    func getAge() -> String
    func getWeight() -> String
    func getHeight() -> String
    func getFriends()
    func getGnomeFromName(_ name: String) -> GnomeView?
}

protocol DetailPresenterToViewProtocol: class {
    var presenter: DetailViewToPresenterProtocol? {get set}
    func refreshCollection(_ newList: [String])
}

protocol DetailInteractorToPresenterProtocol: class {

}

protocol DetailPresenterToInteractorProtocol: class {
    var presenter: DetailInteractorToPresenterProtocol? {get set}
    func getGnome(_ name: String) -> GnomeView?
}

protocol DetailPresenterToRouterProtocol: class {
    static func createDetailModuleWithInfo(_ gnome: GnomeView) -> UIViewController
    func navigateBackToHomeScreen(from view: DetailPresenterToViewProtocol)
}
