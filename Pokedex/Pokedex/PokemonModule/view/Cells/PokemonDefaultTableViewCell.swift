//
//  PokemonDefaultTableViewCell.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 26/06/22.
//

import UIKit

class PokemonDefaultTableViewCell: UITableViewCell {

    static let identifier = "PokemonDefaultTableViewCell"
    @IBOutlet weak var pokemonTitleInfo: UILabel!
    @IBOutlet weak var pokemonDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
