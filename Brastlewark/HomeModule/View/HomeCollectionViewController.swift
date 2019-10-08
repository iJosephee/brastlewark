//
//  HomeCollectionViewController.swift
//  Brastlewark
//
//  Created by Arnold Giuseppe Dominguez Eusebio on 10/2/19.
//  Copyright © 2019 Chimparon. All rights reserved.
//

import UIKit

private let reuseIdentifier = "HomeCell"

final class HomeCollectionViewController: UICollectionViewController {
    
    var presenter: HomeViewToPresenterProtocol?
    var population: [GnomeView] = []
    
    @IBOutlet weak var spinner: UIActivityIndicatorView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        self.collectionView!.register(UINib(nibName: "HomeCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        // Do any additional setup after loading the view.
        presenter?.viewDidLoad()
        self.title = "Brastlewark Population"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func filterButtonTapped() {
        let title = NSLocalizedString("Sheet.Title", tableName: "HomeModule", bundle: Bundle.main, value: "", comment: "")
        let message = NSLocalizedString("Sheet.Message", tableName: "HomeModule", bundle: Bundle.main, value: "", comment: "")
        let option1 = NSLocalizedString("Sheet.Option.1", tableName: "HomeModule", bundle: Bundle.main, value: "", comment: "")
        let option2 = NSLocalizedString("Sheet.Option.2", tableName: "HomeModule", bundle: Bundle.main, value: "", comment: "")
        let option3 = NSLocalizedString("Sheet.Option.3", tableName: "HomeModule", bundle: Bundle.main, value: "", comment: "")
        let option4 = NSLocalizedString("Sheet.Option.4", tableName: "HomeModule", bundle: Bundle.main, value: "", comment: "")
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        let ascendingAction = UIAlertAction(title: option1, style: .default) { ( _ ) in
            // filter by ascending age
            self.presenter?.checkPopulationWith(.ageAscending)
        }
        let descendingAction = UIAlertAction(title: option2, style: .default) { ( _ ) in
            // filter by descending age
            self.presenter?.checkPopulationWith(.ageDescending)
        }
        let noneAction = UIAlertAction(title: option3, style: .default) { ( _ ) in
            // remove all filters
            self.presenter?.checkPopulationWith(.none)
        }
        let cancelAction = UIAlertAction(title: option4, style: .cancel) { ( _ ) in
            // do nothing
        }
        alert.addAction(ascendingAction)
        alert.addAction(descendingAction)
        alert.addAction(noneAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func searchButtonTapped() {
        presenter?.searchTerm("")
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.population.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? HomeCollectionViewCell
    
        // Configure the cell
        let gnome = population[indexPath.row]
        if let thumbnail = URL(string: gnome.thumbnail!) {
            cell?.photo?.loadImageURL(thumbnail, completion: { (success) in
                // do something
            })
            cell?.photo?.layer.cornerRadius = 60.0
        }
        cell?.name?.text = gnome.name
        cell?.age?.text = String(gnome.age ?? -1)
        return cell!
    }

    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gnome = population[indexPath.row]
        presenter?.selectedGnome(gnome)
    }

}

extension HomeCollectionViewController: HomePresenterToViewProtocol {
    
    func refreshCollection(_ population: [GnomeView]) {
        self.population = population
        self.collectionView.reloadData()
    }
    
    func showLoading() {
        spinner?.isHidden = false
    }
    
    func hideLoading() {
        spinner?.isHidden = true
    }
    
    func showErrorMessage(_ title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
}
