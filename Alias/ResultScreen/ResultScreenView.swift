
import UIKit

//Протокол для пуша алертов
protocol PresentAlertDelegate: AnyObject {
    func presentAlert()
}

class ResultScreenView: UIView {
    
    weak var delegate: PresentAlertDelegate?
    var tapImageBtn: (()->())?
    var backStartVC: (() -> Void)?
    var finalists: [Team]
    private let winner: Team

    private let backgroundImage: UIImageView = {
        let backgroundImage = UIImageView()
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.image = UIImage(named: "Ellipse Background")
        return backgroundImage
    }()

    private lazy var teamLabel: UILabel = {
        let teamLabel = UILabel()
        teamLabel.translatesAutoresizingMaskIntoConstraints = false
        
        teamLabel.text = ""
        teamLabel.textAlignment = .center
        teamLabel.textColor = .white
        teamLabel.font = UIFont(name: "Phosphate-Solid", size: 40)
        return teamLabel
    }()

    private lazy var winLabel: UILabel = {
        let winLabel = UILabel()
        winLabel.translatesAutoresizingMaskIntoConstraints = false
        winLabel.text = "WIN!"
        winLabel.textAlignment = .center
        winLabel.textColor = .black
        winLabel.font = UIFont(name: "Phosphate-Solid", size: 40)
        return winLabel
    }()

    private lazy var circleLabel: UILabel = {
        let circleLabel = UILabel()
        circleLabel.translatesAutoresizingMaskIntoConstraints = false
        circleLabel.text = "10"
        circleLabel.backgroundColor = .white
        circleLabel.textAlignment = .center
        circleLabel.textColor = .black
        circleLabel.layer.masksToBounds = true
        circleLabel.layer.cornerRadius = 60
        circleLabel.font = UIFont(name: "Phosphate-Solid", size: 40)
        return circleLabel
    }()

    private lazy var cupImage: UIImageView = {
        let cupImage = UIImageView()
        cupImage.translatesAutoresizingMaskIntoConstraints = false
        cupImage.image = UIImage(named: "Goodies Appreciation")
        cupImage.isUserInteractionEnabled = true
        let tapCup = UITapGestureRecognizer(target: self, action: #selector(tapCupImage))
        cupImage.addGestureRecognizer(tapCup)
        return cupImage
    }()

    @objc private func tapCupImage() {
        
        self.tapImageBtn?()
        //        ResultScreenViewController().dismiss(animated: false)
        // delegate?.presentAlert()
    }

    private lazy var winStackView: UIStackView = {
        let winStackView = UIStackView(arrangedSubviews:
                                        [
                                            self.teamLabel,
                                            self.winLabel,
                                        ])
        winStackView.axis = .vertical
        winStackView.spacing = 5.0
        winStackView.alignment = .center
        winStackView.translatesAutoresizingMaskIntoConstraints = false
        return winStackView
    }()

    private lazy var cupStackView: UIStackView = {
        let winStackView = UIStackView(arrangedSubviews:
                                        [
                                            self.circleLabel,
                                            self.cupImage
                                        ])
        winStackView.axis = .horizontal
        winStackView.spacing = 20.0
        winStackView.alignment = .center
        winStackView.translatesAutoresizingMaskIntoConstraints = false
        return winStackView
    }()


    private lazy var resultTableView: UITableView = {
        let resultTableView = UITableView(frame: self.bounds, style: .plain)
        resultTableView.dataSource = self
        resultTableView.translatesAutoresizingMaskIntoConstraints = false
        resultTableView.register(ScoreCell.self, forCellReuseIdentifier: "ScoreCell")
        resultTableView.register(UITableViewCell.self, forCellReuseIdentifier: "DefaultCell")
        resultTableView.delegate = self
        resultTableView.separatorStyle = .none
        resultTableView.backgroundColor = .white
        return resultTableView
    } ()

    private lazy var bottomButton: UIButton = {
        let bottomButton = UIButton()
        bottomButton.translatesAutoresizingMaskIntoConstraints = false
        bottomButton.backgroundColor = .black
        bottomButton.setTitle("Новая игра", for: .normal)
        bottomButton.titleLabel?.font = UIFont(name: "Phosphate-Solid", size: 24)
        bottomButton.titleLabel?.textColor = .white
        bottomButton.layer.cornerRadius = 16
        bottomButton.addTarget(self, action: #selector(didTapBottomButton), for: .touchUpInside)
        return bottomButton
    }()

    @objc private func didTapBottomButton() {
        self.backStartVC?()
    }

    init(finalists: [Team]) {
        self.winner = finalists.first!
        self.finalists = Array(finalists.dropFirst())
        super.init(frame: .zero)
        
        self.setViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setViews() {
        self.teamLabel.text = self.winner.name
        self.circleLabel.text = String(self.winner.scores)
        
        self.backgroundColor = .white
        
        [self.backgroundImage,
         self.winStackView,
         self.cupStackView,
         self.resultTableView,
         self.bottomButton].forEach { self.addSubview($0)}

        NSLayoutConstraint.activate([

            self.backgroundImage.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backgroundImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.backgroundImage.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 0.6),

            self.winStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.winStackView.bottomAnchor.constraint(equalTo: self.backgroundImage.bottomAnchor, constant: -5),
            self.winStackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 30),

            self.circleLabel.heightAnchor.constraint(equalToConstant: 120),
            self.circleLabel.widthAnchor.constraint(equalToConstant: 120),

            self.cupStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.cupStackView.topAnchor.constraint(equalTo: self.winStackView.bottomAnchor, constant: 10),
            self.cupStackView.bottomAnchor.constraint(equalTo: self.backgroundImage.bottomAnchor,constant: -10),

            self.resultTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.resultTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.resultTableView.topAnchor.constraint(equalTo: self.backgroundImage.bottomAnchor, constant: 2),
            self.resultTableView.bottomAnchor.constraint(equalTo: self.bottomButton.topAnchor, constant: -10),

            self.bottomButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            self.bottomButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            self.bottomButton.heightAnchor.constraint(equalToConstant: 66),

            self.bottomButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -11)
        ])
    }

}

//MARK: -

extension ResultScreenView: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScoreCell", for: indexPath) as? ScoreCell
        if let cell = cell {
            
               // TO DO обработать колличество ячеек
            let countOfSection = indexPath.section % 3
            cell.myView.backgroundColor = sectionColor(section: countOfSection)
            
            let finalists = finalists[indexPath.section]
            cell.teamLabel.text = finalists.name
            cell.scoreLabel.text = String(finalists.scores)

            return cell
        }
        return UITableViewCell()
    }

    private func sectionColor(section: Int)-> UIColor {
        var color: UIColor = .gray
        if section == 0 {
            color = UIColor(named: "RoyalBlueColor") ?? .gray
        } else if section == 1 {
            color = UIColor(named: "DarkPurpleColor") ?? .gray
        } else if section == 2 {
            color =  UIColor(named: "OrangeColor") ?? .gray
        }
        return color
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66+16
    }

    internal func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return finalists.count
    }

}
