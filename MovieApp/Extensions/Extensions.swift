//
//  Extensions.swift
//  MovieApp
//
//  Created by O'lmasbek on 14/04/24.
//

import UIKit

/// ImageView + Extension

extension UIImageView {
    func loadImage(from url: URL) {
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self else { return }
            if let error = error {
                print("Failed to load image with error: \(error.localizedDescription)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                print("Failed to load image: Invalid response")
                return
            }
            
            if let data = data, let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.image = image
                }
            } else {
                print("Failed to load image: Data is empty or invalid")
            }
        }
        task.resume()
    }
}

extension UIView {
    func addGradientBackground(topColor: UIColor, bottomColor: UIColor) {
        // Gradient layer yaratiladi
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.frame = bounds
        
        // Eski gradient layerlarni o'chirish
        if let sublayers = layer.sublayers {
            for layer in sublayers {
                if layer is CAGradientLayer {
                    layer.removeFromSuperlayer()
                }
            }
        }
        
        // Gradient layerni view'ga qo'shish
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func addBlurEffect(style: UIBlurEffect.Style = .light) {
        let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: style))
        blurEffectView.frame = bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        addSubview(blurEffectView)
    }
}

extension UILabel {
    func akiraExpanded(size: CGFloat) {
        self.font = UIFont(name: "Akira-Expanded", size: size)
    }
    
    func gruppoRegular(size: CGFloat) {
        self.font = UIFont(name: "Gruppo-Regular", size: size)
    }
    
    func montserratBlack(size: CGFloat) {
        self.font = UIFont(name: "Montserrat-Black", size: size)
    }
    
    func montserratLight(size: CGFloat) {
        self.font = UIFont(name: "Montserrat-Light", size: size)
    }
    
    func montserratSemiBold(size: CGFloat) {
        self.font = UIFont(name: "Montserrat-SemiBold", size: size)
    }
    
   
}

extension UIViewController {
    
    func setBackground(imageStr: String) {
        let bgImage: UIImageView = {
            let imageV = UIImageView()
            imageV.image = UIImage(named: imageStr)
            imageV.contentMode = .scaleToFill
            imageV.translatesAutoresizingMaskIntoConstraints = false
            return imageV
        }()
        
        self.view.addSubview(bgImage)
        
        NSLayoutConstraint.activate([
            bgImage.topAnchor.constraint(equalTo: view.topAnchor),
            bgImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            bgImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            bgImage.bottomAnchor.constraint(equalTo: view.bottomAnchor),

        ])
    }
}

//MARK: - UICOLOR
extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        var hexFormatted: String = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        hexFormatted = hexFormatted.replacingOccurrences(of: "#", with: "")

        var rgb: UInt64 = 0

        Scanner(string: hexFormatted).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}
