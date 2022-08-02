
import UIKit
// Протокол, отвечающий за передачу, введенного в текстфилд имени
protocol NewNameDelegate: AnyObject {
    func renameTeam(name: String)
}

class AlertForChangeTeamName {

    //Делегирующая переменная
    weak var delegate: NewNameDelegate?
    
    private var myTargetView: UIView?
    lazy var teamName = teamNameTextField.text
    
    struct Constants {
        
        static let backgroundAlphaTo: CGFloat = 0.6
        static let countOfSymbols = 22
    }
    
    // Бэкграунд
    private let backgroundView: UIView = {
        let backgroundView = UIView()
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0
        return backgroundView
    }()
    
    // Вью для алерта
    private let alertView: UIView = {
        let alert = UIView()
        alert.backgroundColor = .white
        alert.layer.masksToBounds = true
        alert.layer.cornerRadius = 12
        return alert
    }()
    
    // Лейбл для тайтла
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.text = "Как назовем команду?"
        label.font = UIFont(name: "Phosphate-Solid", size: 20)
        return label
    }()
    
    // Текстфилд для ввода названия команды
    private lazy var teamNameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.textAlignment = .left
        tf.addShadowToTextField(color: .gray, cornerRadius: 10)
        tf.placeholder = "Введите название команды"
        tf.clearButtonMode = UITextField.ViewMode.whileEditing
        tf.indent(size: 10)
        tf.clearsOnBeginEditing = true
        return tf
    }()
    
    // Кнопка - сохранить
    private  lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Сохранить", for: .normal)
        button.titleLabel?.font = UIFont(name: "Phosphate-Solid", size: 24)
        button.backgroundColor = .black
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(saveBtnPressed), for: .touchUpInside)
        
        return button
    }()
    
    // Кнопка - не сохранять
    private lazy var dismissAlertButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Не сохранять", for: .normal)
        button.titleLabel?.font = UIFont(name: "Phosphate-Solid", size: 24)
        button.backgroundColor = .black
        button.titleLabel?.textColor = .white
        button.alpha = 0.25
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(dismissAlert), for: .touchUpInside)
        return button
    }()
    
    // Кнопка сохранения
    @objc private func saveBtnPressed() {
        
        UIView.animate(withDuration: 0.25, animations: { self.createView() }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: { self.backgroundView.alpha = 0 }, completion: {
                    done in
                    if done {
                        self.deleteAlpha()
                        let enteredText = self.teamNameTextField.text ?? "___"
                        self.teamName = enteredText
                        guard let newName = self.teamName  else { return }
                        let cutName = self.textFieldLeingth(text: newName, countCharacters: Constants.countOfSymbols)
                        self.delegate?.renameTeam(name: cutName.uppercased())
                        self.teamNameTextField.text = ""
                    }
                })
            }
        })

    }
    
    // Кнопка закрытия
    @objc private func dismissAlert(){
        
        UIView.animate(withDuration: 0.25,
                       animations: {
            self.createView()
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.25, animations: {
                    self.backgroundView.alpha = 0
                }, completion: {
                    done in
                    if done {
                        self.deleteAlpha()
                    }
                })
            }
        })
    }
    
    private func createView(){
        
        guard let targetView = myTargetView else {return}
        self.alertView.frame = CGRect(x: 40, y: targetView.frame.size.height, width: targetView.frame.size.width - 80, height: 250)
    }
    
    private func deleteAlpha(){
        self.alertView.removeFromSuperview()
        self.backgroundView.removeFromSuperview()
    }
    
    // вызов алерта
    func showAlertChangeTeamName(title: String, target controller: UIViewController) {
        // Проверяем на nil
        guard let targetView = controller.view else {return}
        
        myTargetView = targetView
        
        backgroundView.frame = targetView.bounds
        targetView.addSubview(backgroundView)
        targetView.addSubview(alertView)
        
        self.alertView.frame = CGRect(x: 40, y: -300, width: targetView.frame.size.width - 80, height: 250)
        
        titleLabel.text = title
        setupUI()
        
        UIView.animate(withDuration: 0.25, animations: {
            self.backgroundView.alpha = Constants.backgroundAlphaTo
        }, completion: { done in
            if done {
                UIView.animate(withDuration: 0.25) {
                    self.alertView.center = targetView.center
                }
            }
        })
    }
    
    // Считаем длину названия команды и режем если больше уст. значения
    private func textFieldLeingth(text: String?, countCharacters: Int) -> String {
        var newString: [Character] = []
        var counter = 0
        guard let text = text else {return ""}
        for value in text.map({$0}){
            if counter < countCharacters {
            newString.append(value)
                counter += 1
            } else {break}
        }
        return String(newString)
    }
    
    // MARK: - Setup constraints
    private func setupUI() {
        
        alertView.addSubview(self.titleLabel)
        alertView.addSubview(self.teamNameTextField)
        alertView.addSubview(self.saveButton)
        alertView.addSubview(self.dismissAlertButton)
        
        NSLayoutConstraint.activate([
            
            self.titleLabel.topAnchor.constraint(equalTo: self.alertView.topAnchor, constant: 16),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.alertView.leadingAnchor, constant: 24),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.alertView.trailingAnchor, constant: -24),
            self.titleLabel.heightAnchor.constraint(equalToConstant: 40),
            
            self.teamNameTextField.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor, constant: 11),
            self.teamNameTextField.leadingAnchor.constraint(equalTo: self.alertView.leadingAnchor, constant: 27),
            self.teamNameTextField.trailingAnchor.constraint(equalTo: self.alertView.trailingAnchor, constant: -27),
            self.teamNameTextField.heightAnchor.constraint(equalToConstant: 35),
            
            self.saveButton.bottomAnchor.constraint(equalTo: self.dismissAlertButton.topAnchor, constant: -11),
            self.saveButton.leadingAnchor.constraint(equalTo: self.alertView.leadingAnchor, constant: 24),
            self.saveButton.trailingAnchor.constraint(equalTo: self.alertView.trailingAnchor, constant: -24),
            self.saveButton.heightAnchor.constraint(equalToConstant: 50),
            
            self.dismissAlertButton.bottomAnchor.constraint(equalTo: self.alertView.bottomAnchor, constant: -11),
            self.dismissAlertButton.leadingAnchor.constraint(equalTo: self.alertView.leadingAnchor, constant: 24),
            self.dismissAlertButton.trailingAnchor.constraint(equalTo: self.alertView.trailingAnchor, constant: -24),
            self.dismissAlertButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
}

extension UITextField {
    
    func addShadowToTextField(color: UIColor = .gray, cornerRadius: CGFloat) {
        
        self.backgroundColor = .white
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowOpacity = 1.0
        self.layer.cornerRadius = cornerRadius
    }
    
    func indent(size: CGFloat){
        self.leftView = UIView(frame: CGRect(x: self.frame.minX, y: self.frame.minY, width: size, height: self.frame.height))
        self.leftViewMode = .always
    }
}
