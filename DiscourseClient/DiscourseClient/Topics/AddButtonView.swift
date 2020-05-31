//
//  AddButtonView.swift
//  DiscourseClient
//
//  Created by Ivan Llopis Guardado on 31/05/2020.
//  Copyright © 2020 Roberto Garrido. All rights reserved.
//

import UIKit

class AddButtonView: UIView {
    
    
    @IBOutlet weak var addButton: UIButton!
    var addTopicBlock: (()->Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    fileprivate func commonInit() {
        
        let bundle = Bundle.init(for: AddButtonView.self)
        if let bundleViews = bundle.loadNibNamed("AddButtonView", owner: self, options: nil){
            
        
            if let contentView = bundleViews.first as? UIView {

                contentView.translatesAutoresizingMaskIntoConstraints = false
                addSubview(contentView)
                NSLayoutConstraint.activate([
                    contentView.topAnchor.constraint(equalTo: topAnchor),
                    contentView.leftAnchor.constraint(equalTo: leftAnchor),
                    contentView.rightAnchor.constraint(equalTo: rightAnchor),
                    contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
                ])
            }
        }
    }
    
    @IBAction func addTopic(_ sender: Any) {
        self.addTopicBlock?()
    }
    
    
}
