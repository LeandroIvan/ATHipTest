/**
 @file  ATMainViewController.swift
 
 - author: Leandro Ivan Candiotto
 - date: 10/3/18.
 - copyright: © 2018 Leandro Ivan Candiotto. All rights reserved.
 
 Very basic ViewController with a textField that take in input a string and show the JSON representation on it


 */

import UIKit

class ATMainViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var sendButton: UIButton!
    private var textToSend : String?
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var activityView: UIActivityIndicatorView!
    
    private var pending : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.backgroundColor = .black
        textView.layer.borderColor = UIColor.white.cgColor
        textView.layer.borderWidth = 2.0
        textView.textColor = .green
        textView.isEditable = false
        
        sendButton.backgroundColor = .darkGray
        sendButton.titleLabel?.textColor = .red
        sendButton.layer.cornerRadius = 5.0
        
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        textField.delegate = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        // uncomment to try preset of string ( - or check unittest )
//        textToSend =  "Hey @andy, (megusta) (coffee) are you free for lunch tomorrow?"
//        textToSend = "Good morning! (megusta) (coffee)"
//        textToSend =  "@bob (success) such a cool feature; https://twitter.com/jdorfman/status/430511497475670016"
//        textToSend = "@bob @john (hello) (areyoukiddingme) such a cool feature; https://twitter.com/jdorfman/status/430511497475670016"
        textToSend =  "Hey @atlassian, this is my cool project! (thumbsup) https://github.com/LeandroIvan/ATHipTest"
        textField.text = textToSend
        self.buttonClicked(nil)
    
    }
    
    /**
     this function get the json content of the textfield string
     */
    @IBAction func buttonClicked(_ sender: Any?) {
        activityView.startAnimating()
        sendButton.isEnabled = false
        ATContentManager.getContent(from: textToSend ?? "") { (content) in
            var textToShow = "Result (\"\(self.textToSend ?? "")\") :\n"
            textToShow += String(describing: ATJsonHelper.encodeContentMessage(content: content))
            DispatchQueue.main.async {
                self.sendButton.isEnabled = true
                self.activityView.stopAnimating()
                self.textView.text = textToShow
            }
        }
    }
    
    // MARK: TextFiel delegate methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textToSend = textField.text
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        textToSend = textField.text
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textToSend = textField.text
        textField.resignFirstResponder()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

