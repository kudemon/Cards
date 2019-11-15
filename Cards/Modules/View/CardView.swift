//
//  CardView.swift
//  Cards
//
//  Created by nikita on 10/11/2019.
//  Copyright © 2019 nikita. All rights reserved.
//

import UIKit

class CardTableView: UITableView {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "white").withRenderingMode(.alwaysOriginal))
    let label = UILabel()
    private var startPoint: CGPoint = .zero
    private var threshold: CGFloat = 180
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        
        addSubview(label)
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 34, weight: .heavy)
        label.numberOfLines = 0
    }
    
    override func layoutSubviews() {
        imageView.frame = CGRect(x: 50, y: 50, width: frame.width - 100, height: frame.height - 100)
        label.frame = CGRect(x: 50, y: 50, width: frame.width - 100, height: frame.height - 100)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        addGestureRecognizer(panGestureRecognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension CardTableView {
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        switch gestureRecognizer.state {
        case .began:
            startPoint = gestureRecognizer.translation(in: self)
        case .changed:
//            let diff = 50 + gestureRecognizer.translation(in: self).x//startPoint.x
//            imageView.frame.origin.x = diff
//            label.frame.origin.x = diff
//            print(diff)
            let translation = gestureRecognizer.translation(in: self)
            let degrees: CGFloat = translation.x / 20
            let angle = degrees * .pi / 180
            
            let rotationTranform = CGAffineTransform(rotationAngle: angle)
            self.transform = rotationTranform.translatedBy(x: translation.x, y: translation.y)
            break
        case .ended:
            startPoint = .zero
            imageView.frame.origin.x = 50
            label.frame.origin.x = 50
            
            let dismissRight = gestureRecognizer.translation(in: nil).x > threshold
            let dismissLeft = gestureRecognizer.translation(in: nil).x < threshold * -1
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseInOut, animations: {
                if dismissRight {
                    self.frame = CGRect(x: 600, y: 0, width: self.frame.width, height: self.frame.height)
                } else if dismissLeft {
                    self.frame = CGRect(x: -600, y: 0, width: self.frame.width, height: self.frame.height)
                } else {
                    self.transform = .identity
                }}) { (_) in
                    if dismissLeft || dismissRight {
                        self.removeFromSuperview()
                    }
                    
                }
        @unknown default:
            break
        }
    }
    
    
}

//class CardView: UIView {
//    let firstView = UIView()
//    let secondView = UIView()
//    let thirdView = UIView()
//    private var startPoint: CGPoint = .zero
//    private var threshold: CGFloat = 80
//
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        firstView.backgroundColor = .red
//        addSubview(firstView)
//
//        secondView.backgroundColor = .blue
//        addSubview(secondView)
//
//        thirdView.backgroundColor = .black
//        addSubview(thirdView)
//
//        backgroundColor = .green
//
//        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
//        addGestureRecognizer(panGestureRecognizer)
//
//    }
//
//    override func layoutSubviews() {
//        firstView.frame = CGRect(x: 50, y: 50, width: frame.width - 100, height: frame.height - 100)
//        secondView.frame = CGRect(x: 50, y: 50, width: frame.width - 100, height: frame.height - 100)
//        thirdView.frame = CGRect(x: 50, y: 50, width: frame.width - 100, height: frame.height - 100)
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
