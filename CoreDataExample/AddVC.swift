//
//  ViewController.swift
//  CoreDataExample
//
//  Created by Nimble Chapps on 03/06/16.
//  Copyright © 2016 GuruSoft. All rights reserved.
//

import UIKit
import CoreData


class AddVC: UIViewController {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    
    let appDelegateObj : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var editRecNo = Int()
    var dataArray = [NSManagedObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if editRecNo != -1 {
            txtName.text = self.dataArray[editRecNo].valueForKey(kNameStr) as? String
            txtPhone.text = self.dataArray[editRecNo].valueForKey(kPhoneStr) as? String
        }
    }
    
    @IBAction func btnDoneTapped(sender: AnyObject) {
        
        if editRecNo != -1 {
            self.dataArray[editRecNo].setValue(txtName.text!, forKey: kNameStr)
            self.dataArray[editRecNo].setValue(txtPhone.text!, forKey: kPhoneStr)
            
            do {
                try self.dataArray[editRecNo].managedObjectContext?.save()
            } catch {
                print("Error occured during updating entity")
            }
        } else {
            let entityDescription = NSEntityDescription.entityForName(kEntityStr, inManagedObjectContext: appDelegateObj.managedObjectContext)
            let newPerson = NSManagedObject(entity: entityDescription!, insertIntoManagedObjectContext: appDelegateObj.managedObjectContext)
            newPerson.setValue(txtName.text!, forKey: kNameStr)
            newPerson.setValue(txtPhone.text!, forKey: kPhoneStr)
            
            do {
                try newPerson.managedObjectContext?.save()
            } catch {
                print("Error occured during save entity")
            }
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func btnCancelTappe(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}

