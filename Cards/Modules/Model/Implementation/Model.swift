//
//  Model.swift
//  Cards
//
//  Created by Dmitry Kurach on 14/11/2019.
//  Copyright © 2019 nikita. All rights reserved.
//

import UIKit

struct User {
    let name: String
    let age: Int
    let imageName: String
    
    func toCardsViewModel() -> CardsViewModel {
        let attributedText = NSMutableAttributedString(string: name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
        attributedText.append(NSAttributedString(string: " \(age)", attributes:
            [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
        return CardsViewModel(imageName: imageName, attributedString: attributedText, textAlignment: .left)
    }
}
