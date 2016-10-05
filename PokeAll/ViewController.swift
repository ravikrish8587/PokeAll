//
//  ViewController.swift
//  PokeAll
//
//  Created by Ravi Krishna on 10/1/16.
//  Copyright © 2016 rk. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UISearchBarDelegate{
    lazy var pokemonArr = [Pokemon]()
    lazy var resultArr:[Pokemon] = [Pokemon]()
    var isSearchEnabled:Bool = false
    @IBOutlet weak var collection:UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        collection.delegate=self
        collection.dataSource=self
        searchBar.delegate = self
        searchBar.enablesReturnKeyAutomatically = false
        searchBar.returnKeyType = UIReturnKeyType.done
        parseCSV()
    }
    
    func parseCSV() {
        let path = Bundle.main.path(forResource: "pokemon", ofType: "csv")
        do {
            let csv = try CSV(contentsOfURL: path!)
            let rows = csv.rows
            //print(rows)
            for pokemon in rows {
                let name = pokemon["identifier"]
                let pokeID = Int(pokemon["id"]!)
                let pokeData = Pokemon(name: name!,pokeID: "\(pokeID!)")
                pokemonArr.append(pokeData)
            }
        } catch let err  {
            print(err.localizedDescription)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark - UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isSearchEnabled{
            return resultArr.count
        }
        return pokemonArr.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pokeCell", for: indexPath) as? PokeCell{
            if isSearchEnabled{
                return cell.configureCell(pokemon: resultArr[indexPath.row])
            }
            return cell.configureCell(pokemon: pokemonArr[indexPath.row])
        }
        return UICollectionViewCell()
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: 88, height: 88)
    }
    
    //Mark - UISearchBarDelegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(!searchText.isEmpty || searchText.trimmingCharacters(in: .newlines) != "") {
            isSearchEnabled = true
            //searchBar.showsCancelButton = true
            resultArr = pokemonArr.filter({ ($0.name.lowercased().range(of: searchText.lowercased()) != nil) })
        }else{
            isSearchEnabled = false
            view.endEditing(true) //close the keyboard
        }
        collection.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        isSearchEnabled = false
//        searchBar.text = ""
//        searchBar.resignFirstResponder()
//        collection.reloadData()
//        searchBar.showsCancelButton = false
//    }
  
    
}

