//
//  SongTableViewCell.swift
//  MusicListHomeWork
//
//  Created by Hana  Demas on 02/07/16.
//  Copyright © 2016 ___HANADEMAS___. All rights reserved.
//

import Foundation
import UIKit

// a custom tableview class, constraintes are set using interface builder
class SongTableViewCell: UITableViewCell {
    
    //MARK:custom tableview cell properties
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var singerImageView:UIImageView!
    @IBOutlet var bandName:UILabel!
}
