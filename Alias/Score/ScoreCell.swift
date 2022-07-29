//
//  ScoreCell.swift
//  Alias
//
//  Created by Alex Ch. on 28.07.2022.
//

import UIKit

class ScoreCell: UITableViewCell {
    
    override init (style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    public lazy var myView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        return view
    } ()
    
    public lazy var starImage: UIImageView = { // Звездочка
        let image = UIImageView(image: UIImage(named: "star"))
        image.contentMode = .scaleAspectFit
        image.isHidden = true
        return image
    }()
    
    public lazy var teamLabel: UILabel = { // Названия команд
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Phosphate-Solid", size: 24)
        label.textColor = .white
        return label
    } ()
    
    public lazy var scoreLabel: UILabel = { // Счет
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Phosphate-Solid", size: 24)
        label.backgroundColor = .white
        label.textColor = .black
        label.layer.masksToBounds = true
        label.layer.cornerRadius = 15
        label.textAlignment = .center
        
        return label
    } ()
    
    private lazy var contentStack: UIStackView = { // стэк с элементами ячейки
        let stack = UIStackView(arrangedSubviews: [self.starImage, self.teamLabel, self.scoreLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 0
        stack.distribution = .fillProportionally
        return stack
    }()
    
    private func setupView () {
        self.addSubview(contentView)
        self.contentView.addSubview(self.myView)
        myView.addSubview(self.contentStack)
 
        contentView.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            
            
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.myView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            self.myView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.myView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.myView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            self.contentStack.centerXAnchor.constraint(equalTo: self.myView.centerXAnchor),
            self.contentStack.centerYAnchor.constraint(equalTo: self.myView.centerYAnchor),
            self.contentStack.leadingAnchor.constraint(equalTo: self.myView.leadingAnchor, constant: 16),

            self.scoreLabel.widthAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    
}
