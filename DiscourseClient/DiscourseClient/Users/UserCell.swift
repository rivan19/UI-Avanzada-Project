//
//  UserCell.swift
//  DiscourseClient
//
//  Created by Ivan Llopis Guardado on 31/05/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class UserCell: UICollectionViewCell {

    @IBOutlet weak var imagen: UIImageView!
    @IBOutlet weak var labelUser: UILabel!
    
    
    static let cellIdentifier : String = String(describing: UserCell.self)
    var viewModel: UserCellViewModel? {
        didSet {
            guard let viewModel = viewModel else {return}
            self.imagen.layer.cornerRadius = imagen.frame.height/2
            labelUser.font = .textStyle
            labelUser.tintColor = .black
            
            labelUser.text = viewModel.textLabelText
            self.imagen.image = viewModel.imageString
        }
    }
    
    

}
