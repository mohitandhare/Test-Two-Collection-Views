//
//  OneCollectionViewCell.swift
//  Test Two Collection Views
//
//  Created by Developer Skromanglobal on 22/07/22.
//

import UIKit
import NeumorphismKit

class OneCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cell_view: UIView!
   
    @IBOutlet weak var on_off_button: NeumorphismButton!
    
    @IBOutlet weak var on_off_image: UIImageView!
    var on_off_value : String! = nil
    
    @IBOutlet weak var config_button_image: UIImageView!
    var config_button_value : String!
    
    @IBOutlet weak var light_number: UILabel!
    
    @IBOutlet weak var initial_values_label: UILabel!
    
    var master_value : String!
    var fan_value : String!
    var fan_one_more_value : String!
    
}
