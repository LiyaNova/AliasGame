
import UIKit

class MyCustomBackButton: UIButton {

    override var intrinsicContentSize: CGSize {
        .init(width: 40, height: 40)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUI() {
        self.layer.cornerRadius = 4
        addPlainShadow()
        self.backgroundColor = .white
        let configuration = UIImage.SymbolConfiguration(pointSize: 20)
        let image = UIImage(systemName: "chevron.left", withConfiguration: configuration)
        self.setImage(image, for: .normal)
        self.tintColor = .black
        self.configuration?.contentInsets = .init(top: 10, leading: 10, bottom: 10, trailing: 10)
    }

    func addShadowWithColor(_ color: UIColor, radius:CGFloat, offset:CGSize, opacity:Float) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.masksToBounds = false
    }

    func addPlainShadow() {
        self.addShadowWithColor(UIColor.lightGray, radius: 2.5, offset: CGSize(width: -1, height: 1), opacity: 0.8)
    }

}
