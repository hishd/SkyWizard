//
//  View+Extensions.swift
//  SkyWizard
//
//  Created by Hishara Dilshan on 2023-10-10.
//

import UIKit

extension UIView {
    func setupToolbar() -> UIToolbar {
        let toolbar = UIToolbar()
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        
        toolbar.setItems([flexSpace, doneButton], animated: true)
        toolbar.sizeToFit()
        return toolbar
    }
    
    @objc func doneButtonTapped() {
        endEditing(true)
    }
}

extension UIViewController {
    func showMessage(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        present(alert, animated: true, completion: nil)
    }
}

extension UIButton {
    func attributedTitle(first: String, second: String, fontSize: CGFloat) {
        let attrs : [NSAttributedString.Key: Any] = [.foregroundColor : UIColor(white: 1, alpha: 0.87), .font: UIFont.systemFont(ofSize: fontSize)]
        let attributedTitle = NSMutableAttributedString(string: "\(first) ", attributes: attrs)
        
        let boldAttrs: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor(white: 1, alpha: 0.87), .font: UIFont.boldSystemFont(ofSize: fontSize)]
        
        attributedTitle.append(NSAttributedString(string: second, attributes: boldAttrs))
        
        setAttributedTitle(attributedTitle, for: .normal)
    }
}
