//
//  NeuView.swift
//  MovieApp
//
//  Created by O'lmasbek on 03/05/24.
//

import UIKit

class NeuView: UIView {
    
    var imgView = UIImageView()
    
    // "outer" shadows
    private let darkShadow = CALayer()
    private let lightShadow = CALayer()
    
    // "inner" shadow
    private let innerShadowLayer = CAShapeLayer()
    private let innerShadowMaskLayer = CAShapeLayer()

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    private func commonInit() -> Void {
        
        // add sublayers
        self.layer.addSublayer(darkShadow)
        self.layer.addSublayer(lightShadow)
        self.layer.addSublayer(innerShadowLayer)
        
        darkShadow.shadowColor = UIColor.black.withAlphaComponent(0.2).cgColor
        darkShadow.shadowOffset = CGSize(width: 5, height: 5)
        darkShadow.shadowOpacity = 1
        darkShadow.shadowRadius = 10
        
        lightShadow.shadowColor = UIColor.black.withAlphaComponent(0.8).cgColor
        lightShadow.shadowOffset = CGSize(width: -5, height: -5)
        lightShadow.shadowOpacity = 1
        lightShadow.shadowRadius = 10
        
        self.layer.borderColor = UIColor.black.withAlphaComponent(0.35).cgColor
        //layer.borderWidth = 3
        
        // very light gray background color
        let bkgColor = UIColor.black // UIColor(white: 0.95, alpha: 1.0)
        
        darkShadow.backgroundColor = bkgColor.cgColor
        lightShadow.backgroundColor = bkgColor.cgColor // UIColor(white: 0.98, alpha: 1.0).cgColor
        
        // image view properties
        imgView.contentMode = .scaleAspectFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        //imgView.layer.masksToBounds = true
        
        addSubview(imgView)
        imgView.clipsToBounds = true
        imgView.layer.cornerRadius = 110
        NSLayoutConstraint.activate([
            // let's make the image view 60% of self
            imgView.leftAnchor.constraint(equalTo: leftAnchor),
            imgView.rightAnchor.constraint(equalTo: rightAnchor),
            imgView.topAnchor.constraint(equalTo: topAnchor),
            imgView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
    }
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        
        // set dark and light shadow layers' frames to bounds
        darkShadow.frame = bounds
        lightShadow.frame = bounds
        
        // set self.layer and dark and light shadow layers' cornerRadius to one-half height
        let cr = bounds.height * 0.5
        darkShadow.cornerRadius = cr
        lightShadow.cornerRadius = cr
        self.layer.cornerRadius = cr
        
        // for the "inner" shadow,
        // rectangle path needs to be larger than
        //  bounds + shadow offset + shadow raidus
        // so the shadow doesn't "bleed" from all sides
        let path = UIBezierPath(rect: bounds.insetBy(dx: -40, dy: -40))

        // create a path for the "hole" in the layer
        let circularHolePath = UIBezierPath(ovalIn: bounds)
        
        // this "cuts a hole" in the path
        path.append(circularHolePath)
        path.usesEvenOddFillRule = true
        
        innerShadowLayer.path = path.cgPath
        innerShadowLayer.fillRule = .evenOdd
        
        // fillColor doesn't matter - just needs to be opaque
        innerShadowLayer.fillColor = UIColor.white.cgColor

        // mask the layer, so we only "see through the hole"
        innerShadowMaskLayer.path = circularHolePath.cgPath
        innerShadowLayer.mask = innerShadowMaskLayer

        // adjust properties as desired
        innerShadowLayer.shadowOffset = CGSize(width: 15, height: 15)
        innerShadowLayer.shadowColor = UIColor(white: 0.0, alpha: 1.0).cgColor
        innerShadowLayer.shadowRadius = 5
        
        // setting .shadowOpacity to a very small value (such as 0.025)
        //  results in very light shadow
        // set .shadowOpacity to 1.0 to clearly see
        //  what the shadow is doing
        innerShadowLayer.shadowOpacity = 0.025

    }

}
