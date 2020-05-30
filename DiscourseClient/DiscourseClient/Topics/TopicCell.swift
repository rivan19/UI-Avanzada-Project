//
//  TopicCell.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

/// Celda que representa un topic en la lista
class TopicCell: UITableViewCell {
    
    @IBOutlet weak var imageUser: UIImageView!
    @IBOutlet weak var labelTopic: UILabel!
    @IBOutlet weak var labelNumberTopics: UILabel!
    @IBOutlet weak var labelNumberUser: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var icoSmall: UIImageView!
    @IBOutlet weak var stackViewTopics: UIStackView!
    @IBOutlet weak var stackViewUser: UIStackView!
    @IBOutlet weak var stackViewData: UIStackView!
    @IBOutlet weak var stackViewGeneral: UIStackView!
    
    static let cellIdentifier : String = String(describing: TopicCell.self)
    
    var viewModel: TopicCellViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            stackViewGeneral.spacing = 6
            //stackViewGeneral.setCustomSpacing(6, after: stackViewTopics)
            //stackViewGeneral.setCustomSpacing(6, after: stackViewUser)
            
            
            stackViewTopics.spacing = 4
            //stackViewTopics.frame.size = CGSize(width: 35.0, height: 17.0)
            self.icoSmall.frame.size = CGSize(width: 17.0, height: 14.0)
            
            stackViewUser.spacing = 4
            stackViewData.spacing = 4
            
            //self.imageUser.layer.cornerRadius = 30
            self.imageUser.layer.cornerRadius = imageUser.frame.height/2
            labelTopic.font = .textStyle5
            labelTopic?.text = viewModel.textLabelText
            labelNumberTopics.text = viewModel.replyCount
            labelNumberTopics.font = .textStyle7
            labelNumberUser.font = .textStyle7
            labelDate.font = .textStyle2
            labelNumberUser.text = viewModel.postsCount
            
            let inputFormat = "YYYY-MM-DD'T'HH:mm:ss.SSSZ"
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "es_ES")
            dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
            dateFormatter.dateFormat = inputFormat
            // Generar la fecha a partir del string y el formato de entrada
            if let createdAt = viewModel.createdAt {
                // Generar la fecha a partir del string y el formato de entrada
                if let date = dateFormatter.date(from: createdAt) {
                    // Generar el string en el format de fecha requerido
                    let outputFormat = "d MMM"
                    dateFormatter.dateFormat = outputFormat
                    let outputStringDate = dateFormatter.string(from: date)
                    labelDate.text = outputStringDate.uppercased()
                }

            }
            
            imageUser.image = viewModel.imageUrl
            
        }
    }
}
