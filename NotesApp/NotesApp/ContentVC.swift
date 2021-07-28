//
//  ContentVC.swift
//  NotesApp
//
//  Created by DCS on 24/07/21.
//  Copyright © 2021 DCS. All rights reserved.
//

import UIKit

class ContentVC: UIViewController {
    var openFile = ""
    
    private let myTextField:UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Add Notes"
        textfield.textAlignment = .center
        textfield.borderStyle = .roundedRect
        textfield.layer.borderWidth = 1
        return textfield
    }()
    
    private let myTextView:UITextView = {
        let textview = UITextView()
        textview.textAlignment = .center
        textview.layer.cornerRadius = 6
        textview.layer.borderWidth = 1
        return textview
    }()
    
    private let SaveButton:UIButton = {
        let button = UIButton()
        button.setTitle("Save", for: .normal)
        button.addTarget(self, action: #selector(SaveButtonTapped), for: .touchUpInside)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = .brown
        button.layer.cornerRadius = 6
        button.layer.borderWidth = 1
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .lightGray
        view.addSubview(myTextField)
        view.addSubview(myTextView)
        view.addSubview(SaveButton)
        
        if openFile != ""{
            myTextField.text = openFile.components(separatedBy: ".").first
            myTextField.isEnabled = false
            
            let filepath = getDocDir().appendingPathComponent(openFile)
            
            do{
                let content = try String(contentsOf: filepath)
                myTextView.text = content
            }
            catch
            {
                print(error.localizedDescription)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let vw=view.frame.width
        myTextField.frame = CGRect(x: 20, y: 200, width:vw - 40, height: 40)
        myTextView.frame = CGRect(x: 20, y: 250, width: vw - 40, height: 100)
        SaveButton.frame = CGRect(x: 20, y: 400, width: vw - 40, height: 60)
    }
    
    @objc private func SaveButtonTapped()
    {
        let name = myTextField.text!
        let content = myTextView.text!
        
        let filepath = getDocDir().appendingPathComponent("\(name).txt")
        do
        {
            try content.write(to: filepath, atomically: true, encoding: .utf8)
            
            let fetchContent = try String(contentsOf: filepath)
            print("saved: \(fetchContent)")
            
            myTextField.text = ""
            myTextView.text = ""
            
            let alert = UIAlertController(title: "Success", message: "File Created Sucessfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Done", style: .cancel))
            present(alert, animated: true)
        }
        catch{
            print(error.localizedDescription)
        }
    }
    
    private func getDocDir() -> URL{
        let  paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        print("Doc Dir: \(paths[0])")
        return paths[0]
    }
}
