//
//  SectionHeaderCollectionReusableView.swift
//  MovieApp
//
//  Created by O'lmasbek on 12/04/24.
//

import UIKit

class SectionTitleCollectionReusableView: UICollectionReusableView {
    static let identifier = "SectionTitleCollectionReusableView"
    
    let title: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.montserratBlack(size: 20)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let moreButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(UIColor(hex: "FFB703"), for: .normal)
        button.titleLabel?.montserratBlack(size: 20)
        button.setTitle("More", for: .normal)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var moreButtonAction: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(title)
        addSubview(moreButton)
        
        setUpConstraints()
        
        moreButton.addTarget(self, action: #selector(moreButtonTap), for: .touchUpInside)
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            title.leftAnchor.constraint(equalTo: leftAnchor),
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            moreButton.rightAnchor.constraint(equalTo: rightAnchor),
            moreButton.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
    
    func configure(title: String, buttonHide: Bool = true) {
        self.title.text = title
        
        if buttonHide {
            moreButton.alpha = 0
        }
    }
    
    @objc func moreButtonTap() {
        moreButtonAction?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//#Preview {
//    HomeViewController()
//}
