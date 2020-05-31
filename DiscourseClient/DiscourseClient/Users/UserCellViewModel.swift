//
//  UserCellViewModel.swift
//  DiscourseClient
//
//  Created by Ivan Llopis Guardado on 12/04/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import Foundation
import UIKit

class UserCellViewModel {
    let user: User
    var textLabelText: String?
    var imageString: UIImage?
    
    init(user: User, imagen: Data?){
        self.user = user
        self.textLabelText = self.user.name
        
        //super.init()
        
        DispatchQueue.global(qos: .userInitiated).async{ [weak self] in
            guard let self = self else {
                return
            }
            if let imagen = imagen {
                self.imageString = UIImage(data: imagen)
            }
        }
        
        
        
    }
}
