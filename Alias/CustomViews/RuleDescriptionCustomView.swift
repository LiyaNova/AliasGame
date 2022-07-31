
import UIKit

class RuleDescriptionCustomView: UIView {
    
    private var image = UIImageView()
    private var label = UILabel()

    init(imageTitle: String, title: String) {
        self.image = UIImageView.makeImage(imageTitle: imageTitle)
        self.label = UILabel.makeLabel(title: title)
        
        super.init(frame: .zero)
        
        self.setupView()
    }
    
    required init?(coder eCoder: NSCoder) {
        fatalError()
    }
    
    private func setupView() {
        
        addSubview(image)
        addSubview(label)
        
        NSLayoutConstraint.activate([
            self.image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.image.centerYAnchor.constraint(equalTo: self.label.centerYAnchor),
            
            self.label.topAnchor.constraint(equalTo: self.topAnchor),
            self.label.leadingAnchor.constraint(equalTo: self.image.trailingAnchor, constant: 16.0),
            self.trailingAnchor.constraint(equalTo: self.label.trailingAnchor, constant: 16),
            self.bottomAnchor.constraint(equalTo: self.label.bottomAnchor)
        ])
    }
}

private extension UILabel {
    
    static func makeLabel(title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.textColor = .black
        label.textAlignment = .natural
        label.font = UIFont(name: "Piazzolla", size: 16.0)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }
}

private extension UIImageView {
    
    static func makeImage(imageTitle: String) -> UIImageView {
        let image = UIImageView()
        image.image = UIImage(named: imageTitle)
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.widthAnchor.constraint(equalToConstant: 55.0),
            image.heightAnchor.constraint(equalToConstant: 65.0)
        ])
        
        return image
    }
    
}
