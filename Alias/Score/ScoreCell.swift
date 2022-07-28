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
        view.backgroundColor = .green
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        return view
    } ()
    
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
    
    private func setupView () {
        self.addSubview(contentView)
        self.contentView.addSubview(self.myView)
        myView.addSubview(self.teamLabel)
        myView.addSubview(self.scoreLabel)
        
        contentView.backgroundColor = .orange
        
        NSLayoutConstraint.activate([
            
            
            self.contentView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.myView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 16),
            self.myView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16),
            self.myView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16),
            self.myView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            
            self.teamLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.teamLabel.centerYAnchor.constraint(equalTo: self.myView.centerYAnchor),
            
            self.scoreLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -34),
            self.scoreLabel.centerYAnchor.constraint(equalTo: self.myView.centerYAnchor),
            self.scoreLabel.widthAnchor.constraint(equalToConstant: 35)
        ])
    }
}
