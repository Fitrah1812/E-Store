//
//  LoginViewController.swift
//  E-Store
//
//  Created by Laptop MCO on 14/08/23.
//

import UIKit

protocol loginView: AnyObject {
    func setError(message: String?)
    func setLoginButton(enabled: Bool)
}

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    var presenter: LoginPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setup()
    }
    func setup() {
        setError(message: nil)
        setLoginButton(enabled: false)
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        view.endEditing(true)
        presenter.login(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
    }
    
}

extension LoginViewController: loginView {
    func setError(message: String?) {
        if let message = message {
            errorLabel.text = message
            errorLabel.isHidden = false
        } else {
            errorLabel.isHidden = true
        }
    }
    
    func setLoginButton(enabled: Bool) {
        loginButton.isEnabled = enabled
    }
    
}

extension LoginViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let text = NSString(string: textField.text ?? "").replacingCharacters(in: range, with: string)
        switch textField {
        case emailTextField:
            presenter.validate(email: text, password: passwordTextField.text ?? "")
        case passwordTextField:
            presenter.validate(email: emailTextField.text ?? "", password: text)
        default:
            break
        }
        
        return true
    }
}

