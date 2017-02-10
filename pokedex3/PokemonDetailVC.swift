//
//  PokemonDetailVC.swift
//  pokedex3
//
//  Created by Ravi Rathore on 2/10/17.
//  Copyright © 2017 com.banago. All rights reserved.
//

import UIKit

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
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
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
