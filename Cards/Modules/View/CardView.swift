//
//  CardView.swift
//  Cards
//
//  Created by nikita on 10/11/2019.
//  Copyright © 2019 nikita. All rights reserved.
//

import UIKit

class CardsView: UIView {
    let imageView = UIImageView()
    let label = UILabel()
    private var startPoint: CGPoint = .zero
    private var threshold: CGFloat = 180
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.fillSuperview()
        imageView.contentMode = .scaleAspectFit
        
        addSubview(label)
        label.textColor = .red
    }
    
    override func layoutSubviews() {
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width - 100, height: frame.height - 100)
        label.frame = CGRect(x: 50, y: 150, width: frame.width - 100, height: frame.height - 100)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        addGestureRecognizer(panGestureRecognizer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CardsView {
    @objc func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        
        switch gestureRecognizer.state {
        case .began:
            startPoint = gestureRecognizer.translation(in: nil)
        case .changed:
            let translation = gestureRecognizer.translation(in: nil)
            let degrees: CGFloat = translation.x / 20
            let angle = degrees * .pi / 180
            
            let rotationTranform = CGAffineTransform(rotationAngle: angle)
            self.transform = rotationTranform.translatedBy(x: translation.x, y: 0)
            break
        case .ended:
            startPoint = .zero
            imageView.frame.origin.x = .zero
            label.frame.origin.x = 50
            
            let dismissRight = gestureRecognizer.translation(in: nil).x > threshold
            let dismissLeft = gestureRecognizer.translation(in: nil).x < threshold * -1
            
            UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseInOut, animations: {
                if dismissRight {
                    self.frame = CGRect(x: 300, y: 0, width: self.frame.width, height: self.frame.height)
                } else if dismissLeft {
                    self.frame = CGRect(x: -300, y: 0, width: self.frame.width, height: self.frame.height)
                } else {
                    self.transform = .identity
                }
                
            }) { (_) in
                    if dismissLeft || dismissRight {
                        self.removeFromSuperview()
                    }
                    
                }
        @unknown default:
            break
        }
    }
    
    
}

struct AnchoredConstraints {
    var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
}


extension UIView {
    
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, trailing: NSLayoutXAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) -> AnchoredConstraints {
        
        translatesAutoresizingMaskIntoConstraints = false
        var anchoredConstraints = AnchoredConstraints()
        
        if let top = top {
            anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top)
        }
        
        if let leading = leading {
            anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)
        }
        
        if let bottom = bottom {
            anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom)
        }
        
        if let trailing = trailing {
            anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)
        }
        
        if size.width != 0 {
            anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width)
        }
        
        if size.height != 0 {
            anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height)
        }
        
        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach{ $0?.isActive = true }
        
        return anchoredConstraints
    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
}


