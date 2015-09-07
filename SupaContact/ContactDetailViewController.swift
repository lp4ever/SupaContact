//
//  ContactDetailViewController.swift
//  SupaContact
//
//  Created by Adrian Lodge on 8/17/15.
//  Copyright (c) 2015 Supatone Innovation. All rights reserved.
//

import UIKit

class ContactDetailViewController: UIViewController {
    
    var detailContactModel: ContactModel!
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var companyText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    @IBOutlet weak var dateContactedText: UITextField!
    @IBOutlet weak var responseText: UITextField!
    @IBOutlet weak var responseSwitch: UISwitch!
    @IBOutlet weak var interestedSlider: UISlider!
    @IBOutlet weak var interestedText: UITextView!
    @IBOutlet weak var otherText: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
        println(self.detailContactModel.name)
        self.nameText.text = detailContactModel.name
        self.phoneText.text = detailContactModel.phone
        self.emailText.text = detailContactModel.email
        self.companyText.text = detailContactModel.company
        self.dateContactedText.text = detailContactModel.date
        self.interestedText.text = detailContactModel.interested
        self.otherText.text = detailContactModel.other
        self.interestedSlider.value = detailContactModel.percent
        self.responseSwitch.on = detailContactModel.response
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func cancelButtonTapped(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func doneButtonTapped(sender: UIBarButtonItem) {
        
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        detailContactModel.name = nameText.text
        detailContactModel.phone = phoneText.text
        detailContactModel.email = emailText.text
        detailContactModel.company = companyText.text
        detailContactModel.date = dateContactedText.text
        detailContactModel.interested = interestedText.text
        detailContactModel.other = otherText.text
        detailContactModel.percent = interestedSlider.value
        detailContactModel.response = responseSwitch.on
        ModelManager.instance.saveContext()
        self.navigationController?.popViewControllerAnimated(true)
    }


}
