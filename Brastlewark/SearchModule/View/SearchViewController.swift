//
//  SearchViewController.swift
//  Brastlewark
//
//  Created by Arnold Giuseppe Dominguez Eusebio on 10/4/19.
//  Copyright © 2019 Chimparon. All rights reserved.
//

import UIKit

private let reuseIdentifier = "SearchCell"

final class SearchViewController: UIViewController {

    var presenter: SearchViewToPresenterProtocol?
    var results: [GnomeView] = []
    
    @IBOutlet weak var searchTextField: UITextField?
    @IBOutlet weak var resultsTableView: UITableView?
    @IBOutlet weak var noResults: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Buscar"
        searchTextField?.becomeFirstResponder()
        resultsTableView?.register(UINib(nibName: "SearchCell", bundle: Bundle.main), forCellReuseIdentifier: reuseIdentifier)
    }
    
    @IBAction func searchButtonTapped() {
        if let term = searchTextField?.text {
            presenter?.searchTerm(term)
        }
    }

}

extension SearchViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as? SearchCell
        let gnome = results[indexPath.row]
        if let thumbnail = URL(string: gnome.thumbnail!) {
            cell?.photo?.loadImageURL(thumbnail, completion: { (success) in
                // do something
            })
            cell?.photo?.layer.cornerRadius = 30.0
        }
        cell?.name?.text = gnome.name
        cell?.age?.text = String(gnome.age ?? -1)
        return cell!
    }
    
}

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gnome = results[indexPath.row]
        presenter?.selectedGnome(gnome)
    }
    
}

extension SearchViewController: SearchPresenterToViewProtocol {
    
    func refreshSearchResults(_ results: [GnomeView]) {
        self.results = results
        resultsTableView?.isHidden = false
        noResults?.isHidden = true
        resultsTableView?.reloadData()
    }
    
    func setNotResults() {
        resultsTableView?.isHidden = true
        noResults?.isHidden = false
    }
    
}
