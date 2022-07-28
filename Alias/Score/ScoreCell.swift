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
        view.backgroundColor = .white
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
    
    private func setupView () {
        self.addSubview(contentView)
        self.contentView.addSubview(self.myView)
        myView.addSubview(self.teamLabel)
        
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
            
            self.teamLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.teamLabel.centerYAnchor.constraint(equalTo: self.myView.centerYAnchor)
        ])
    }
}
