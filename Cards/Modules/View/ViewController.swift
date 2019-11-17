//
//  ViewController.swift
//  Cards
//
//  Created by nikita on 10/11/2019.
//  Copyright © 2019 nikita. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let cardsView = CardsView()
    var cardsViewModels: [CardsViewModel] = [
        User(name: "Беленькая", age: 18, imageName: "white").toCardsViewModel(),
        User(name: "Чёрненькая", age: 20, imageName: "black").toCardsViewModel(),
        User(name: "Азиаточка", age: 21, imageName: "asian").toCardsViewModel()
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardsSetup()
        stackViewSetup()
        // Do any additional setup after loading the view.
    }
    

}

extension ViewController {
    
    func cardsSetup() {
          cardsViewModels.forEach { viewModel in
              let cardView = CardsView()
              cardView.imageView.image = UIImage(named: viewModel.imageName)
              cardView.label.attributedText = viewModel.attributedString
              cardView.label.textAlignment = viewModel.textAlignment
              cardsView.addSubview(cardView)
              cardView.fillSuperview()
          }
      }
    
        func stackViewSetup () {
            let CardsStackView = UIStackView(arrangedSubviews: [cardsView])
            view.addSubview(CardsStackView)
            CardsStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
            CardsStackView.bringSubviewToFront(cardsView)
        }
}

