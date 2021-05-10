//
//  Extensions.swift
//  tmdb
//
//  Created by toha on 09.05.2021.
//

import UIKit

extension UIView {
        
    func fillSuperview(insets: UIEdgeInsets = .zero) {
        guard let superview = self.superview else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor, constant: insets.top),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: insets.left),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -insets.bottom),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -insets.right)
        ])
    }
    
    func ancherSize(size: CGSize) {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: size.height).isActive = true
        widthAnchor.constraint(equalToConstant: size.width).isActive = true
    }
    
    
    func ancherToSuperviewsCenter() {
        guard let superview = self.superview else { return }
        
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
        centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
    }
    
}

extension UIViewController {
    func presentErrorAlert() {
        let alert = UIAlertController(title: "Oops :(", message: "Something went wrong, try again later", preferredStyle: .alert)
        alert.addAction(.init(title: "OK", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension UITableView {
    func deselectRows() {
        if let indePaths = self.indexPathsForSelectedRows {
            indePaths.forEach { self.deselectRow(at: $0, animated: true) }
        }
    }
}
