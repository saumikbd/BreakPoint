//
//  CreatePostVC.swift
//  BreakPoint
//
//  Created by Sadman Sakib Saumik on 11/12/17.
//  Copyright © 2017 Sadman Sakib Saumik. All rights reserved.
//

import UIKit
import Firebase

class CreatePostVC: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    var startedEditing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.delegate = self
        sendButton.bindToKeyboard()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailLabel.text = Auth.auth().currentUser?.email
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        
        if startedEditing == true && textView.text != "" {
            sendButton.isEnabled = false
            DataService.instance.uploadPost(withMessage: textView.text!, forId: (Auth.auth().currentUser?.uid)!, withGroupKey: nil, completion: { (success) in
                if success {
                    self.sendButton.isEnabled = true
                    self.dismiss(animated: true, completion: nil)
                } else {
                    self.sendButton.isEnabled = true
                    print("An Error Occured")
                }
            })
        }
        
    }
    
    @IBAction func closeButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension CreatePostVC: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = ""
        startedEditing = true
    }
}
