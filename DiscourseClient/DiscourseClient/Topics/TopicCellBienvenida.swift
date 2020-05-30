//
//  TopicCellBienvenida.swift
//  DiscourseClient
//
//  Created by Ivan Llopis Guardado on 30/05/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class TopicCellBienvenida: UITableViewCell {
    @IBOutlet weak var labelBienvenida: UILabel!
    @IBOutlet weak var labelDetail: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    
    static let cellIdentifier : String = String(describing: TopicCellBienvenida.self)
    
    var viewModel: TopicCellViewModelBienvenida?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        labelBienvenida.font = .textStyle4
        labelDetail.font = .textStyle8
        containerView.layer.cornerRadius = 8
        
    }

    
}
