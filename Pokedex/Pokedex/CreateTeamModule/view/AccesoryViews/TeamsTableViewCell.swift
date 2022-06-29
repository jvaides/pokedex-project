//
//  TeamsTableViewCell.swift
//  Pokedex
//
//  Created by Jose Figueroa Vaides on 28/06/22.
//

import UIKit

class TeamsTableViewCell: UITableViewCell {

    static let identifier = "TeamsTableViewCell"
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var regionTitle: UILabel!
    @IBOutlet weak var regionName: UILabel!
    @IBOutlet weak var pokeImage1: UIImageView!
    @IBOutlet weak var pokeImage2: UIImageView!
    @IBOutlet weak var pokeImage3: UIImageView!
    @IBOutlet weak var pokeImage4: UIImageView!
    @IBOutlet weak var pokeImage5: UIImageView!
    
    @IBOutlet weak var pokeImage6: UIImageView!
    @IBOutlet weak var createdBy: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setPokeImage1(data:Data?){
        self.pokeImage1.image = UIImage(data: data ?? Data())
    }
    
    func setPokeImage2(data:Data?){
        self.pokeImage2.image = UIImage(data: data ?? Data())
    }
    
    func setPokeImage3(data:Data?){
        self.pokeImage3.image = UIImage(data: data ?? Data())
    }
    
    func setPokeImage4(data:Data?){
        self.pokeImage4.image = UIImage(data: data ?? Data())
    }
    
    func setPokeImage5(data:Data?){
        self.pokeImage5.image = UIImage(data: data ?? Data())
    }
    
    func setPokeImage6(data:Data?){
        self.pokeImage6.image = UIImage(data: data ?? Data())
    }
}
