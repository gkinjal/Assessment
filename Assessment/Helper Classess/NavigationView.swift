//
// NavigationView.swift
//  Assessment
//
//  Created by apple on 27/04/24.
//

import UIKit

class NaviagtionView: UIView {
    
    
    let backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "back_arrow"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let tickButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "checkmark.black"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .left
        label.font = UIFont(name: "NunitoSans-Regular", size: 15.0)
        return label
    }()
    
    let languageChangeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "lang-icon"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }
    
    private func setupViews() {
        // Setup your custom navigation view
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(tickButton)
        addSubview(languageChangeButton)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8), // Adjust leading space as needed
            backButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 30),
            backButton.widthAnchor.constraint(equalToConstant: 45), // Adjust width as needed
            backButton.heightAnchor.constraint(equalTo: heightAnchor) // Match height of the navigation view
        ])
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor), // Adjust leading space as needed
            titleLabel.bottomAnchor.constraint(equalTo: backButton.centerYAnchor, constant: 12)
        ])
        
        
        tickButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tickButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),// Adjust trailing space as needed
            tickButton.bottomAnchor.constraint(equalTo: backButton.centerYAnchor, constant: 12),
            tickButton.widthAnchor.constraint(equalToConstant: 40) // Adjust width as needed
        ])
        
        languageChangeButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            languageChangeButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -53),// Adjust trailing space as needed
            languageChangeButton.bottomAnchor.constraint(equalTo: backButton.centerYAnchor, constant: 18),
            languageChangeButton.widthAnchor.constraint(equalToConstant: 40) // Adjust width as needed
        ])
        // Add constraints for backButton as needed
    }
    
}
