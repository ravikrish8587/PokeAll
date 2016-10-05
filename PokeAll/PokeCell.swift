//
//  PokeCell.swift
//  PokeAll
//
//  Created by Ravi Krishna on 10/1/16.
//  Copyright © 2016 rk. All rights reserved.
//

import UIKit

class PokeCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    var pokemon:Pokemon!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.layer.cornerRadius = 5.0
    }
    func configureCell(pokemon:Pokemon) -> PokeCell {
        self.pokemon = pokemon
        imageView.image = UIImage(named:pokemon.pokeID)
        nameLbl.text = pokemon.name.capitalized
        return self
    }
}
