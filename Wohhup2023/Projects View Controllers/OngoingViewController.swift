//
//  OngoingViewController.swift
//  Wohhup2023
//
//  Created by William Kendrick on 4/7/23.
//

import Foundation
import SwiftUI
import UIKit
import CoreData
import SystemConfiguration


class OngoingViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Project")
        
        do {
            let savedData = try managedContext.fetch(fetchRequest)
            
            // Access the retrieved data here
            for object in savedData {
                let project = Projects(name: "", ID: "", manager: "", address: "")

                if let tempName = object.value(forKey: "name") as? String {
                    project.name = tempName
                    // Access the value of name
                }
                if let tempID = object.value(forKey: "id") as? String {
                    project.ID = tempID
                    // Access the value of id
                }
                if let tempAddress = object.value(forKey: "address") as? String {
                    project.address = tempAddress
                    // Access the value of address
                }
                if let tempManager = object.value(forKey: "manager") as? String {
                    project.manager = tempManager
                    // Access the value of manager
                }
                ProjectsArray.append(project)

            }
        } catch let error as NSError {
            print("Failed to fetch data. Error: \(error), \(error.userInfo)")
        }
        for objects in ProjectsArray {
            ProjectID.text = objects.ID
            ProjectTitle.text = objects.name
            ProjectManager.text = objects.manager
            ProjectDate.text = objects.address
        }
    }
    
    var dynamicTextFields: [UITextField] = []
    

    
    func generateTextField() {
        let textField = UITextField()
        // Configure the text field as needed
        
        dynamicTextFields.append(textField)
        view.addSubview(textField)
    }
    
    @IBOutlet weak var ProjectID: UILabel!
    @IBOutlet weak var ProjectTitle: UILabel!
    @IBOutlet weak var ProjectManager: UILabel!
    @IBOutlet weak var ProjectDate: UILabel!
    
    
    var ProjectsArray: [Projects] = []
    
    var allfieldsfilled = false
    
    var ProjectIDTextField: UITextField?
    var ProjectTitleTextField: UITextField?
    var ProjectManagerTextField: UITextField?
    var AddressTextField: UITextField?
    
    
    // checks on network status.
    /*
    switch networkStatus {
    case .satisfied:
        // Network is reachable
        break
    case .unsatisfied:
        // Network is not reachable
        break
    case .requiresConnection:
        // Network requires connection (e.g., VPN)
        break
    @unknown default:
        break
    }*/

    //New project button is pressed
    @IBAction func NewProjectBtnPress(_ sender: Any) {
        let newView = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
        newView.backgroundColor = UIColor.white
        view.addSubview(newView)

            
        let cancelButton = UIButton(type: .system)
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.frame = CGRect(x: 16, y: 16, width: 60, height: 40)
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed(_:)), for: .touchUpInside)
        newView.addSubview(cancelButton)
       
        
        let saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.setTitleColor(UIColor.white, for: .normal)
        saveButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: (saveButton.titleLabel?.font.pointSize ?? 17.0))
        saveButton.backgroundColor = UIColor.blue
        saveButton.frame = CGRect(x: 175, y: 600, width: 55, height: 40)
        saveButton.addTarget(self, action: #selector(saveButtonPressed(_:)), for: .touchUpInside)
        newView.addSubview(saveButton)
        
        let ProjectIDTextField = UITextField(frame: CGRect(x: 20, y: 75, width: 200, height: 40))
        ProjectIDTextField.placeholder = "Project ID"
        ProjectIDTextField.borderStyle = .line
        ProjectIDTextField.layer.borderWidth = 1.0
        ProjectIDTextField.layer.borderColor = UIColor.black.cgColor
        ProjectIDTextField.autocorrectionType = .no
        self.ProjectIDTextField = ProjectIDTextField
        newView.addSubview(ProjectIDTextField)
            
        let ProjectTitleTextField = UITextField(frame: CGRect(x: 20, y: 175, width: 200, height: 40))
        ProjectTitleTextField.placeholder = "Project Name"
        ProjectTitleTextField.borderStyle = .line
        ProjectTitleTextField.layer.borderWidth = 1.0
        ProjectTitleTextField.layer.borderColor = UIColor.black.cgColor
        self.ProjectTitleTextField = ProjectTitleTextField
        newView.addSubview(ProjectTitleTextField)
        
        let AddressTextField = UITextField(frame: CGRect(x: 20, y: 275, width: 300, height: 40))
        AddressTextField.placeholder = "Project Address"
        AddressTextField.borderStyle = .line
        AddressTextField.layer.borderWidth = 1.0
        AddressTextField.layer.borderColor = UIColor.black.cgColor
        self.AddressTextField = AddressTextField
        newView.addSubview(AddressTextField)
        
        let ProjectManagerTextField = UITextField(frame: CGRect(x: 20, y: 375, width: 200, height: 40))
        ProjectManagerTextField.placeholder = "Project Manager"
        ProjectManagerTextField.borderStyle = .line
        ProjectManagerTextField.layer.borderWidth = 1.0
        ProjectManagerTextField.layer.borderColor = UIColor.black.cgColor
        self.ProjectManagerTextField = ProjectManagerTextField
        newView.addSubview(ProjectManagerTextField)
        
        let datePicker = UIDatePicker(frame: CGRect(x: 145, y: 475, width: 50, height: 40))
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        newView.addSubview(datePicker)
        
        let dateText = UILabel(frame: CGRect(x: 20, y: 475, width: 300, height: 40))
        dateText.text = "Expected Completion Date:"
        newView.addSubview(dateText)
        
 
    }
    
    @objc func cancelButtonPressed(_ sender: UIButton) {
        sender.superview?.removeFromSuperview() // Remove the new view when cancel button is pressed
    }
    
    @objc func datePickerValueChanged(_ datePicker: UIDatePicker) {
        let selectedDate = datePicker.date
        // Handle the selected date
    }

    // Save button is pressed
    @objc func saveButtonPressed(_ sender: UIButton) {
        
        ProjectID.text = ProjectIDTextField?.text ?? ""
        ProjectTitle.text = ProjectTitleTextField?.text ?? ""
        ProjectManager.text = ProjectManagerTextField?.text ?? ""
        ProjectDate.text = AddressTextField?.text ?? ""
        if ProjectID.text == "" || ProjectTitle.text == "" || ProjectManager.text == "" || ProjectDate.text == "" {
            showErrorAlert(message: "Please fill in all fields before saving.")
        }
        else {
            sender.superview?.removeFromSuperview()
            let project = Projects(name: ProjectTitle.text, ID: ProjectID.text, manager: ProjectManager.text, address: ProjectDate.text)
            ProjectsArray.append(project)
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }

            let managedContext = appDelegate.persistentContainer.viewContext
                let entity = NSEntityDescription.entity(forEntityName: "Project", in: managedContext)!
                let newObject = NSManagedObject(entity: entity, insertInto: managedContext)
                
                newObject.setValue(project.name, forKey: "name")
                newObject.setValue(project.ID, forKey: "id")
                newObject.setValue(project.address, forKey: "address")
                newObject.setValue(project.manager, forKey: "manager")
                // Set other properties as needed
            
            do {
                try managedContext.save()
                print("Array saved successfully.")
            } catch let error as NSError {
                print("Failed to save array. Error: \(error), \(error.userInfo)")
            }
        }
    }
    
    func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }


    
}
