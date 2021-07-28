//
//  LoginVC.swift
//  NotesApp
//
//  Created by DCS on 24/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    private let usernameTextField:UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Username"
        textfield.textAlignment = .center
        textfield.borderStyle = .roundedRect
        textfield.layer.borderWidth = 1
        return textfield
    }()
    
    private let passwordTextField:UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Password"
        textfield.textAlignment = .center
        textfield.borderStyle = .roundedRect
        //textfield.backgroundColor = .brow
        textfield.isSecureTextEntry = true
        textfield.layer.borderWidth = 1
        return textfield
    }()
    
    private let mybutton:UIButton = {
        let button = UIButton()
        button.setTitle("Login", for: .normal)
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .brown
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 1
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        
        view.addSubview(usernameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(mybutton)
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let vw=view.frame.width
        usernameTextField.frame = CGRect(x: 20, y: 250, width:vw-40, height: 40)
        passwordTextField.frame = CGRect(x: 20, y: 300, width: vw - 40, height: 40)
        mybutton.frame = CGRect(x: 20, y: 400, width: vw - 40, height: 60)
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "bookbgimg")!)
    }
    
    let username = "Admin"
    let password = "admin"
    @objc func loginTapped(){
        if username == usernameTextField.text! && password == passwordTextField.text! {
            UserDefaults.standard.set(usernameTextField.text!, forKey: "email")
            let vc = FileVC()
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let alert = UIAlertController(title: "Alert!", message: "Incorrect Email and Password", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
        }
    }
}
