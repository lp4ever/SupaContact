//
//  ViewController.swift
//  SupaContact
//
//  Created by Adrian Lodge on 8/14/15.
//  Copyright (c) 2015 Supatone Innovation. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    //let managedObjectContext = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    let managedObjectContext = ModelManager.instance.managedObjectContext!
    
    var fetchedResultsController:NSFetchedResultsController = NSFetchedResultsController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "Background")!)
        fetchedResultsController = getFetchedResultsController()
        fetchedResultsController.delegate = self
        fetchedResultsController.performFetch(nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("iCloudUpdated"), name: "coreDataUpdated", object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
       
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showContactDetail" {
            let detailVC: ContactDetailViewController = segue.destinationViewController as ContactDetailViewController
            let indexPath = self.tableView.indexPathForSelectedRow()
            let thisContact = fetchedResultsController.objectAtIndexPath(indexPath!) as ContactModel
            detailVC.detailContactModel = thisContact
        }
        else if segue.identifier == "showContactAdd" {
            let addContactVC:AddContactViewController = segue.destinationViewController as AddContactViewController
        }
        
    }
    
    @IBAction func addButtonTapped(sender: UIBarButtonItem) {
        self.performSegueWithIdentifier("showContactAdd", sender: self)
    }

    //UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections!.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections![section].numberOfObjects
    }
    

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        println(indexPath.row)
        
        let thisContact = fetchedResultsController.objectAtIndexPath(indexPath) as ContactModel
        
        var cell: ContactCell = tableView.dequeueReusableCellWithIdentifier("myCell") as ContactCell
        
        cell.contactName.text = thisContact.name
        cell.contactPhone.text = thisContact.phone
        cell.contactEmail.text = thisContact.email
        
        return cell
    }
    
    //UITableViewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
        
        performSegueWithIdentifier("showContactDetail", sender: self)
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Valid Contacts"
        }
        else {
            return "No Response"
        }
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        //get contact info to see what bg color it should be
        let thisContact = fetchedResultsController.objectAtIndexPath(indexPath) as ContactModel
        println(indexPath.row)
        println(thisContact.percent)
        println(thisContact.response)
        if (thisContact.response == true){
            let colorVar = getColorForPercent(thisContact.percent)
            cell.backgroundColor = colorVar
        }
        else {
            cell.backgroundColor = UIColor.grayColor()
        }
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        let thisContact = fetchedResultsController.objectAtIndexPath(indexPath) as ContactModel
        //delete object
        ModelManager.instance.managedObjectContext!.deleteObject(thisContact)
        ModelManager.instance.saveContext()
    }
    
    // NSFetchedResultsControllerDelegate
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.reloadData()
    }
    
    //helper
    func taskFetchRequest() -> NSFetchRequest {
        let fetchRequest = NSFetchRequest(entityName: "ContactModel")
        let sortDescriptor = NSSortDescriptor(key: "percent", ascending: false)
        let nameDescriptor = NSSortDescriptor(key: "name", ascending: true)
        let responseDescriptor = NSSortDescriptor(key: "response", ascending: false)
        fetchRequest.sortDescriptors = [responseDescriptor, sortDescriptor, nameDescriptor]
        return fetchRequest
    }
    func getFetchedResultsController() -> NSFetchedResultsController {
        fetchedResultsController = NSFetchedResultsController(fetchRequest: taskFetchRequest(), managedObjectContext: ModelManager.instance.managedObjectContext!, sectionNameKeyPath: "response", cacheName: nil)
        return fetchedResultsController
    }
    
    func getColorForPercent(percent: Float) -> UIColor {
        
        var colorString = UIColor()
        
        if (percent >= 95.0) {
            colorString = UIColor(red: 0.00, green: 0.75, blue: 0.10, alpha: 1.0)
        }
        else if (percent >= 80.0) {
            colorString = UIColor(red: 0.50, green: 1.00, blue: 0.40, alpha: 1.0)
        }
        else if (percent >= 66.0) {
            colorString = UIColor(red: 0.60, green: 1.00, blue: 0.60, alpha: 1.0)
        }
        else if (percent >= 50.0) {
            colorString = UIColor(red: 0.80, green: 1.00, blue: 0.40, alpha: 1.0)
        }
        else if (percent >= 33.0)  {
            colorString = UIColor(red: 0.90, green: 0.90, blue: 0.50, alpha: 1.0)
        }
        else if (percent >= 20.0)  {
            colorString = UIColor(red: 1.00, green: 0.60, blue: 0.30, alpha: 1.0)
        }
        else if (percent >= 5.0)  {
            colorString = UIColor(red: 0.80, green: 0.40, blue: 0.10, alpha: 1.0)
        }
        else  {
            colorString = UIColor(red: 0.75, green: 0.10, blue: 0.00, alpha:1.0)
        }
        return colorString
        
    }
    
    // iCloud Notification
    func iCloudUpdated() {
        tableView.reloadData()
    }

}

