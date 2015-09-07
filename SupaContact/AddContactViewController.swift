//
//  AddContactViewController.swift
//  SupaContact
//
//  Created by Adrian Lodge on 8/17/15.
//  Copyright (c) 2015 Supatone Innovation. All rights reserved.
//

import UIKit
import CoreData

class AddContactViewController: UIViewController {
    
    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func cancelPressed(sender: UIBarButtonItem) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func addPressed(sender: UIBarButtonItem) {
        
        let appDelegate = (UIApplication.sharedApplication().delegate as AppDelegate)
        let managedObjectContext = ModelManager.instance.managedObjectContext
        let entityDescription = NSEntityDescription.entityForName("ContactModel", inManagedObjectContext: managedObjectContext!)
        let contact = ContactModel(entity: entityDescription!, insertIntoManagedObjectContext: managedObjectContext!)
        contact.name = nameText.text
        contact.email = emailText.text
        contact.phone = phoneText.text
        contact.company = companyText.text
        contact.date = dateContactedText.text
        contact.interested = interestedText.text
        contact.other = otherText.text
        contact.percent = interestedSlider.value
        contact.response = responseSwitch.on
        ModelManager.instance.saveContext()
        var request = NSFetchRequest(entityName: "ContactModel")
        var error:NSError? = nil
        var results:NSArray = managedObjectContext!.executeFetchRequest(request, error: &error)!
        for res in results {
            println(res)
        }
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    


}
