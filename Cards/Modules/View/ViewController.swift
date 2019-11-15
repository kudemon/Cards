//
//  ViewController.swift
//  Cards
//
//  Created by nikita on 10/11/2019.
//  Copyright © 2019 nikita. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let cardsView = CardTableView()
    var cardsViewModels: [CardsViewModel] = [
        User(name: "Беленькая", age: 18, imageName: "white").toCardsViewModel(),
        User(name: "Чёрненькая", age: 20, imageName: "black").toCardsViewModel(),
        User(name: "Азиаточка", age: 21, imageName: "panda").toCardsViewModel()
    ]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        cardsSetup()
        setupConstraints()        
        // Do any additional setup after loading the view.
    }
    

}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardsViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func cardsSetup() {
          
          cardsViewModels.forEach { viewModel in
              let cardView = CardTableView()
              cardView.imageView.image = UIImage(named: viewModel.imageName)
              cardView.label.attributedText = viewModel.attributedString
              cardView.label.textAlignment = viewModel.textAlignment
              cardsView.addSubview(cardView)
          }
          
      }
    
        func setupConstraints () {
            view.addSubview(cardsView)
            cardsView.translatesAutoresizingMaskIntoConstraints = false
            cardsView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            cardsView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            cardsView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            cardsView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        }
    
    
}

