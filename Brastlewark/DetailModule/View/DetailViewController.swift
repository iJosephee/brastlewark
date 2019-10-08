//
//  DetailViewController.swift
//  Brastlewark
//
//  Created by Arnold Giuseppe Dominguez Eusebio on 10/3/19.
//  Copyright © 2019 Chimparon. All rights reserved.
//

import UIKit

private let reuseIdentifier = "DetailCell"

final class DetailViewController: UIViewController {

    var presenter: DetailViewToPresenterProtocol?
    var list: [String] = []
    
    @IBOutlet weak var close: UIButton?
    @IBOutlet weak var photo: UIImageView?
    @IBOutlet weak var name: UILabel?
    @IBOutlet weak var age: UILabel?
    @IBOutlet weak var weight: UILabel?
    @IBOutlet weak var height: UILabel?
    
    @IBOutlet weak var ageText: UILabel?
    @IBOutlet weak var weightText: UILabel?
    @IBOutlet weak var heightText: UILabel?
    @IBOutlet weak var friendsText: UILabel?
    @IBOutlet weak var collectionView: UICollectionView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        photo?.loadImageURL(presenter?.getProfilePhoto(), completion: { (success) in
            // do something
        })
        name?.text = presenter?.getName()
        age?.text = presenter?.getAge()
        weight?.text = presenter?.getWeight()
        height?.text = presenter?.getHeight()
        close?.layer.cornerRadius = 17.5
        let text = NSLocalizedString("Label.Text.Friends", tableName: "DetailModule", bundle: Bundle.main, value: "", comment: "")
        friendsText?.text = text
        let textAge = NSLocalizedString("Label.Text.Age", tableName: "DetailModule", bundle: Bundle.main, value: "", comment: "")
        ageText?.text = textAge
        let textWidth = NSLocalizedString("Label.Text.Width", tableName: "DetailModule", bundle: Bundle.main, value: "", comment: "")
        weightText?.text = textWidth
        let textHeight = NSLocalizedString("Label.Text.Height", tableName: "DetailModule", bundle: Bundle.main, value: "", comment: "")
        heightText?.text = textHeight
        collectionView?.register(UINib(nibName: "DetailCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        presenter?.getFriends()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func backButtonTapped() {
        presenter?.goBackToHome()
    }

}

extension DetailViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? DetailCollectionViewCell
        let name = list[indexPath.row]
        if let gnome = presenter?.getGnomeFromName(name) {
            if let thumbnail = URL(string: gnome.thumbnail!) {
                cell?.photo?.loadImageURL(thumbnail, completion: { (success) in
                    // do something
                })
                cell?.photo?.layer.cornerRadius = 50.0
            }
            cell?.name?.text = gnome.name
        }
        return cell!
    }
    
}

extension DetailViewController: DetailPresenterToViewProtocol {
    
    func refreshCollection(_ newList: [String]) {
        self.list = newList
        self.collectionView?.reloadData()
    }
    
}
