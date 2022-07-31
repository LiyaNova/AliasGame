import UIKit

public extension UIView {
    
    func pin(to parentView: UIView, edges: UIEdgeInsets = UIEdgeInsets.createWith(inset: 0)) {
        NSLayoutConstraint.activate([
            self.leadingAnchor.constraint(equalTo: parentView.leadingAnchor, constant: edges.left),
            parentView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: edges.right),
            self.topAnchor.constraint(equalTo: parentView.topAnchor, constant: edges.top),
            parentView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: edges.bottom)
        ])
    }
    
    func pinSafeArea(to parentView: UIView, edges: UIEdgeInsets = UIEdgeInsets.createWith(inset: 0)) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
          NSLayoutConstraint.activate([
              leadingAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.leadingAnchor, constant: edges.left),
              parentView.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: trailingAnchor, constant: edges.right),
              topAnchor.constraint(equalTo: parentView.safeAreaLayoutGuide.topAnchor, constant: edges.top),
              parentView.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: bottomAnchor, constant: edges.bottom)
              ])
      }
    
    func pinCenter(to view: UIView) {
        NSLayoutConstraint.activate([
           self.centerXAnchor.constraint(equalTo: view.centerXAnchor),
           self.centerYAnchor.constraint(equalTo: view.centerYAnchor)
            ])
    }
    
    func pinToBottom(_ view: UIView, greaterThanOrEqualTo value: CGFloat) -> NSLayoutConstraint {
        let constraint = view.bottomAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor, constant: value)
        constraint.isActive = true
        return constraint
    }
    
    func addSubview(_ subview: UIView,
                    constrainedTo anchorsView: UIView) {
        addSubview(subview)
        subview.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            subview.centerXAnchor.constraint(equalTo: anchorsView.centerXAnchor),
            subview.centerYAnchor.constraint(equalTo: anchorsView.centerYAnchor),
            subview.widthAnchor.constraint(equalTo: anchorsView.widthAnchor),
            subview.heightAnchor.constraint(equalTo: anchorsView.heightAnchor)
            ])
    }
    
    func addWidthConstraint(_ constant: CGFloat) {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: constant)
        ])
    }
    
    func addHeightConstraint(_ constant: CGFloat) {
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: constant)
        ])
    }
    
    func addSizeConstraint(_ size: CGSize) {
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: size.width),
            self.heightAnchor.constraint(equalToConstant: size.height)
            ])
    }
}


extension UIStackView {
    
    func pinBackground(_ view: UIView) {
        view.translatesAutoresizingMaskIntoConstraints = false
        self.insertSubview(view, at: 0)
        view.pin(to: self)
    }
    
}

public extension UIEdgeInsets {
    
    /// Create edgeInsets with equal inset for all values
    ///
    /// - Parameter inset: Inset for top, left, bottom and right.
    static func createWith(inset: CGFloat) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
}
