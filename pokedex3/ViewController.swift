//
//  ViewController.swift
//  pokedex3
//
//  Created by Ravi Rathore on 2/8/17.
//  Copyright © 2017 com.banago. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource,  UISearchBarDelegate {
    // MARK: Properties
    var pokemons = [Pokemon]()
    var filteredPokemons = [Pokemon]()
    var inSearchMode = false
    
    // MARK: IBoutlets
    @IBOutlet weak var collectionView : UICollectionView!
    @IBOutlet weak var searchBar : UISearchBar!
    
    
    
    // MARK: Methods
    override func viewDidLoad() {
        print(#function)
        super.viewDidLoad()
     
            self.loadPokemons()
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func loadPokemons(){
        if let path = Bundle.main.path(forResource: "pokemon", ofType: "csv"){
           
                do{
                    let csv  = try CSV(contentsOfURL: path)
                    let rows =  csv.rows
                    for row in rows{
                        
                        if let name = row["identifier"] , let id = row["id"]{
                         let poke = Pokemon(name: name, pokeid: Int(id)!)
                            self.pokemons.append(poke)
                        }
                    }
                }
                catch let err as NSError{
                    print(err.debugDescription)
                }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
        // MARK: UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell{
            let pokemon: Pokemon!
            if inSearchMode{
                pokemon = self.filteredPokemons[indexPath.row]
            }
            else{
                pokemon = self.pokemons[indexPath.row]
            }
            cell.configureCell(pokemon: pokemon)
        return cell
        }
        else{
            return UICollectionViewCell()
        }
        
    }

        // MARK: UICollectionViewDelegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if inSearchMode{
           // print("test1")
                return self.filteredPokemons.count
        }
        else{
             return self.pokemons.count
            //print("test2")
        }
    }
        // MARK: UISearchBarDelegate
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        var poke : Pokemon!
        if inSearchMode{
            poke = self.filteredPokemons[indexPath.row]
        }
        else{
            poke = self.pokemons[indexPath.row]
        }
        
        performSegue(withIdentifier: "PokemonDetailVC", sender: poke)
        
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("search key is \(searchText.lowercased())")
        if  searchText == ""{
        view.endEditing(true)
            inSearchMode = false
        }
        else{
            inSearchMode = true
            self.filteredPokemons = pokemons.filter({ (pok) -> Bool in
                //print("checing for \(pok.name)")
                
                if(pok.name.lowercased().range(of: searchText.lowercased()) != nil){
                  //  print("adding to filered pokeons ")
                    return true
                }
                else{
                  //  print("not adding to filered pokeons ")
                    return false
                }
            })
        
            
        }
        print(self.filteredPokemons)
        self.collectionView.reloadData()
    }
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        view.endEditing(true)
        return true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "PokemonDetailVC"{
            if let detailsVC = segue.destination as? PokemonDetailVC {
                if let poke = sender as? Pokemon{
                    detailsVC.pokemon = poke
                }
            }
        
    }

}
}

