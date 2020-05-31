//
//  TopicCellViewModel.swift
//  DiscourseClient
//
//  Created by Roberto Garrido on 08/02/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation
import UIKit

/// ViewModel que representa un topic en la lista
class TopicCellViewModel: TopicCellViewModelBase {
    let topic: Topic
    var textLabelText: String?
    var postsCount: String?
    var replyCount: String?
    var createdAt: String?
    var imageUrl: UIImage?
    
    init(topic: Topic, imagen: Data?) {
        self.topic = topic
        // TODO: Asignar textLabelText, el título del topic
        self.textLabelText = topic.title
        //self.imageUrl = topic.imageUrl
        self.postsCount = "\(topic.postsCount)"
        self.replyCount = "\(topic.replyCount)"
        self.createdAt = topic.createdAt
        super.init()
        DispatchQueue.global(qos: .userInitiated).async{ [weak self] in
            guard let self = self else {
                return
            }
            if let imagen = imagen {
                self.imageUrl = UIImage(data: imagen)
            }
        }
        
        
        
        
    }
}
