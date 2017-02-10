//
//  PokeCell.swift
//  pokedex3
//
//  Created by Ravi Rathore on 2/10/17.
//  Copyright © 2017 com.banago. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var thumbImage : UIImageView!
    @IBOutlet weak var nameLabel : UILabel!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 5.0
       
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 5.0
        
    }
    
    func configureCell(pokemon : Pokemon){
        self.thumbImage.image = UIImage(named: "\(pokemon.id)")
        self.nameLabel.text = pokemon.name
        
    }
}
