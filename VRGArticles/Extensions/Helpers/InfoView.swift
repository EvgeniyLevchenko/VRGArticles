//
//  InfoView.swift
//  VRGArticles
//
//  Created by QwertY on 05.12.2022.
//

import UIKit

class InfoView: UIView {

    let titleLabel = UILabel(text: "", font: .avenirMedium18())
    let infoLabel = UILabel(text: "", font: .avenir18(), numberOfLines: 0)

    convenience init(title: String, info: String) {
        self.init()
        self.titleLabel.text = title
        self.infoLabel.text = info
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupConstraints() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleLabel)
        addSubview(infoLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            infoLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            infoLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            infoLabel.widthAnchor.constraint(equalTo: self.widthAnchor)
        ])
    }
}
