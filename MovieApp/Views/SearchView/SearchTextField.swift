//
//  SearchTextField.swift
//  MovieApp
//
//  Created by O'lmasbek on 30/04/24.
//

import UIKit

class SearchTextField: UITextField {
    
    private let searchIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "magnifyingglass", withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold))
        imageView.tintColor = #colorLiteral(red: 0.4788632989, green: 0.4296241999, blue: 0.4735003114, alpha: 1)
        imageView.contentMode = .scaleAspectFill
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
  
    private let padding = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 40)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        rightView?.frame.size.width = 50
        leftView?.frame.size.width = 16
        font = UIFont(name: "Montserrat-Black", size: 16)
        placeholder = "Search movie"
        
        addSubview(searchIcon)
        backgroundColor = #colorLiteral(red: 0.2891496122, green: 0.220874697, blue: 0.2652337849, alpha: 1)
        layer.cornerRadius = 12
        SearchTextField.appearance().tintColor = .white

        NSLayoutConstraint.activate([
            searchIcon.rightAnchor.constraint(equalTo: rightAnchor, constant: -8),
            searchIcon.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchIcon.widthAnchor.constraint(equalToConstant: 24),
            searchIcon.heightAnchor.constraint(equalToConstant: 24),
            
        ])
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
