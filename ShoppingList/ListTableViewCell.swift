//
//  ListTableViewCell.swift
//  ShoppingList
//
//  Created by Joseph Hansen on 7/15/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var haveItem: UIButton!
    
    weak var delegate: ListTableViewCellDelegate?
    
    var list: List?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func updateWithItem(list: List) {
        self.list = list
        itemLabel.text = list.name
        
        if list.haveItem == true {
            haveItem.setImage(UIImage(named: "complete"), forState: .Normal)
        } else {
            haveItem.setImage(UIImage(named: "incomplete"), forState: .Normal)
        }
    }
    @IBAction func haveItemBoxChecked(sender: AnyObject) {
        guard let list = list else { return }
        delegate?.haveItemValueChanged(self, haveItem: list.haveItem.boolValue)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
}
protocol ListTableViewCellDelegate: class {
    func haveItemValueChanged(cell: ListTableViewCell, haveItem: Bool)
}
