//
//  PokemonImageTableViewCell.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 26/06/22.
//

import UIKit

class PokemonImageTableViewCell: UITableViewCell {

    static let identifier = "PokemonImageTableViewCell"
    @IBOutlet weak var pokemonImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
