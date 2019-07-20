//
//  AddFriendTableViewController.swift
//  friends
//
//  Created by Faith on 8/7/19.
//  Copyright © 2019 Faith. All rights reserved.
//

import UIKit

class AddFriendTableViewController: UITableViewController {
  
  var friend: friendInfo!
  
  @IBOutlet weak var nameField: UITextField!
  @IBOutlet weak var schoolField: UITextField!
  @IBOutlet weak var ageField: UITextField!
  @IBOutlet weak var profileField: UITextField!
  @IBOutlet weak var linkField: UITextField!
  @IBOutlet weak var notesField: UITextField!
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "unwindSave"{
      if friend == nil {
        let name = nameField.text ?? ""
        let school = schoolField.text ?? ""
        let notes = notesField.text ?? ""
        let age = Int(ageField.text ?? "") ?? 0
        let link = linkField.text ?? ""
        let profileFileName = profileField.text ?? "AndreaProfile"
        friend = friendInfo.init(name: name, school: school, moreInfo: notes, age: age, links: link, attack: 7.5, defense: 7.5, stamina: 7.5, profileName: profileFileName)
      } else {
        friend.name = nameField.text ?? ""
        friend.school = schoolField.text ?? ""
        friend.moreInfo = notesField.text ?? ""
        friend.links = linkField.text ?? ""
        friend.profileName = profileField.text ?? "AndreaProfile"
        friend.age = Int(ageField.text ?? "") ?? 0
      }
    }
  }
  
  
  
  override func viewDidLoad() {
        super.viewDidLoad()
    if friend != nil {
      nameField.text = friend.name
      schoolField.text = friend.school
      ageField.text = String(friend.age)
      linkField.text = friend.links
      profileField.text = friend.profileName
      notesField.text = friend.moreInfo
    }
}

}

