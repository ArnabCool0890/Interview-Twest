//
//  TruckViewCell.swift
//  TestAssignment
//
//  Created by Arnab Maity on 14/11/21.
//

import UIKit

class TruckViewCell: UITableViewCell {

    @IBOutlet weak var truckNumberLabel: UILabel!
    
    @IBOutlet weak var truckIdelImage: UIImageView!
    @IBOutlet weak var DayLabel: UILabel!
    @IBOutlet weak var truckDescriptionLabel: UILabel!
    @IBOutlet weak var kmLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
