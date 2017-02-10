//
//  PokemonDetailVC.swift
//  pokedex3
//
//  Created by Ravi Rathore on 2/10/17.
//  Copyright © 2017 com.banago. All rights reserved.
//

import UIKit
import Alamofire

class PokemonDetailVC: UIViewController {
    var pokemon : Pokemon!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var thumbImage: UIImageView!
    @IBOutlet weak var defenseLabel: UILabel!
   
    @IBOutlet weak var pokedexIDLabel: UILabel!
    @IBOutlet weak var baseAttackLabel: UILabel!
    @IBOutlet weak var pokemonDetails: UILabel!
    @IBOutlet weak var weightLabel: UILabel!
    @IBOutlet weak var HeightLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var nextEvoName : UILabel!
    @IBOutlet weak var nextEvoThumb : UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        pokemon.downloadPokemonDetails {
            // only called after the network call is complere
            self.updateUI()
        }
        
        // Do any additional setup after loading the view.
    }
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func configureUI(){
        if self.pokemon != nil{
            self.nameLabel.text = pokemon.name
            self.thumbImage.image = UIImage(named: "\(pokemon.id)")
            self.pokedexIDLabel.text = "\(pokemon.id)"
            
        }
    }
    func updateUI(){
        print(#function)
        self.baseAttackLabel.text = pokemon.attack
        self.defenseLabel.text = pokemon.defense
        self.weightLabel.text = pokemon.weight
        self.HeightLabel.text = pokemon.height
        self.typeLabel.text = pokemon.type
        self.pokemonDetails.text = pokemon.details
        self.nextEvoName.text = pokemon.nextEvolutoinText
        if let image = UIImage(named: "\(self.pokemon.nextEvolutionId)"){
            self.nextEvoThumb.image = image
        }
        
        self.baseAttackLabel.isHidden = false
        self.defenseLabel.isHidden = false
        self.weightLabel.isHidden = false
        self.HeightLabel.isHidden = false
        self.typeLabel.isHidden = false
        self.pokedexIDLabel.isHidden = false
        self.pokemonDetails.isHidden = false
        self.nextEvoName.isHidden = false
        if self.pokemon.nextEvolutoinText != "" && !self.pokemon.nextEvolutoinText.lowercased().contains("mega"){
            self.nextEvoThumb.isHidden = false
    }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
