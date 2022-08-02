
import UIKit

class GameScreenView: UIView {
    var rightButtonTap: (() -> Void)?
    var wrongButtonTap: (() -> Void)?
    
    private let round: GameRound
    private let musicManager = MusicModel()
    
    // MARK: - UI elements
    
    private(set) lazy var secondsLabel: UILabel = {
        let label = UILabel()
        label.text = "\(self.round.roundDuration)"
        label.textColor = .black
        label.font = UIFont(name: "Phosphate-Solid", size: 72)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var secondsTextLabel: UILabel = {
        let label = UILabel()
        label.text = "секунд"
        label.textColor = .black
        label.font = UIFont(name: "Phosphate-Solid", size: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var gameWordLabel: UILabel = {
        let label = UILabel()
        label.text = self.round.words.first
        label.textColor = .black
        label.font = UIFont(name: "Phosphate-Solid", size: 24)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // Картинка карточки (игровое поле)
    private lazy var gameImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "Carts"))
        image.addSubview(self.gameWordLabel)
        return image
    }()
    
    // Кнопка правильного ответа
    private var rightButton = UIButton()
    
    private lazy var rightAnswerBtn: UIButton = {
        self.rightButton = makeButton(color: "TrefoilCrayolaColor", image: "checkmark")
        self.rightButton.addTarget(self, action: #selector(rightAnswer), for: .touchUpInside)
        return rightButton
    }()
    
    // Кнопка неправильного ответа
    private var wrongButton = UIButton()
    
    private lazy var wrongAnswerBtn: UIButton = {
        self.wrongButton = makeButton(color: "SignalOrangeColor", image: "multiply")
        self.wrongButton.addTarget(self, action: #selector(wrongAnswer), for: .touchUpInside)
        return wrongButton
    }()
    
    // Стэк для секунд
    private lazy var secondsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews:
                                    [
                                        self.secondsLabel,
                                        self.secondsTextLabel
                                    ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        return stack
    }()
    
    // Стэк для кнопок
    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews:
                                    [
                                        self.wrongAnswerBtn,
                                        self.rightAnswerBtn
                                    ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.spacing = 40
        return stack
    }()
    
    // Стэк общий
    private lazy var contentStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews:
                                    [
                                        self.secondsStack,
                                        self.gameImage,
                                        self.buttonsStack
                                    ])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = 40
        stack.distribution = .fill
        return stack
    }()
    
    init(round: GameRound) {
        self.round = round
        
        super .init(frame: .zero)
        
        self.setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func rightAnswer(){
        self.rightButtonTap?()
    }
    
    @objc private func wrongAnswer(){
        self.wrongButtonTap?()
    }
    
//    @objc func startTimer(){
//        if seconds > 0 {
//            seconds -= 1
//            self.secondsLabel.text = String(seconds)
//        }
//        if seconds == 5 {
//            self.musicManager.playSound(soundName: "Last 5 sec")
//        }
//        if seconds == 0 {
//            self.openScore?()
//            self.musicManager.playSound(soundName: "Start Timer")
//            timer.invalidate()
//        }
//    }
    
    private func setupUI() {
        
        self.backgroundColor = .white
        addSubview(self.contentStack)
        
        NSLayoutConstraint.activate([
            
            self.contentStack.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
            self.contentStack.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor),
            
            self.gameWordLabel.centerXAnchor.constraint(equalTo: self.gameImage.centerXAnchor),
            self.gameWordLabel.centerYAnchor.constraint(equalTo: self.gameImage.centerYAnchor),
            
            self.wrongAnswerBtn.widthAnchor.constraint(equalToConstant: 112),
            self.wrongAnswerBtn.heightAnchor.constraint(equalToConstant: 108),
            self.rightAnswerBtn.widthAnchor.constraint(equalToConstant: 112),
            self.rightAnswerBtn.heightAnchor.constraint(equalToConstant: 108)
            
        ])
    }
}

private extension GameScreenView {
    
    func makeButton(color: String, image: String) -> UIButton {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor(named: "\(color)")
        btn.layer.cornerRadius = 15
        btn.clipsToBounds = true
        btn.setImage(UIImage(systemName: image), for: .normal)
        return btn
    }
}
