//
//  FriendsTableTableViewController.swift
//  friends
//
//  Created by Faith on 27/6/19.
//  Copyright © 2019 Faith. All rights reserved.
//

import UIKit

class friendInfo: Codable {
  
  var name : String
  var school : String
  var moreInfo : String
  var age : Int
  var links : String
  var attack : Float
  var defense : Float
  var stamina : Float
  var profileName : String
  
  init(name:String, school:String, moreInfo:String, age:Int, links:String, attack:Float, defense:Float, stamina: Float, profileName:String) {
    self.name = name
    self.school = school
    self.moreInfo = moreInfo
    self.age = age
    self.links = links
    self.profileName = profileName
    self.attack = Float.random(in: 0...15)
    self.defense = Float.random(in: 0...15)
    self.stamina = Float.random(in: 0...15)
  }
  
  static func loadSampleData() -> [friendInfo] {
    let friends = [
      friendInfo(name: "Andrea", school: "De Yi", moreInfo: "nil", age: 13, links: "google.com", attack: 5, defense: 9.5, stamina: 7, profileName: "AndreaProfile"),
      friendInfo(name: "Andrea", school: "De Yi", moreInfo: "nil", age: 13, links: "google.com", attack: 5, defense: 9.5, stamina: 7, profileName: "AndreaProfile")
    ]
    return friends
  }
  
  static func getArchiveURL() -> URL {
    let plistName = "friends"
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    return documentsDirectory.appendingPathComponent(plistName).appendingPathExtension("plist")
  }
  
  static func saveToFile(friends: [friendInfo]) {
    let archiveURL = getArchiveURL()
    let propertyListEncoder = PropertyListEncoder()
    let encodedFriends = try? propertyListEncoder.encode(friends)
    try? encodedFriends?.write(to: archiveURL, options: .noFileProtection)
  }
  
  static func loadFromFile() -> [friendInfo]? {
    let archiveURL = getArchiveURL()
    let propertyListDecoder = PropertyListDecoder()
    guard let retrievedFriendsData = try? Data(contentsOf: archiveURL) else { return nil }
    guard let decodedFriends = try? propertyListDecoder.decode(Array<friendInfo>.self, from: retrievedFriendsData) else { return nil }
    return decodedFriends
  }
}

class FriendsTableTableViewController: UITableViewController {
  
  var friends: [friendInfo] = []

  
  @IBAction func unwindToFriendTable(segue: UIStoryboardSegue) {
    if segue.identifier == "unwindSave", let source = segue.source as? AddFriendTableViewController {
      if tableView.indexPathForSelectedRow == nil {
        friends.append(source.friend)
        friendInfo.saveToFile(friends: friends)
        tableView.reloadData()
      } else {
        tableView.reloadData()
      }
    }
  }


    override func viewDidLoad() {
        super.viewDidLoad()
      
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        if let loadedFriends = friendInfo.loadFromFile() {
          print("Found file! Loading friends!")
          friends = loadedFriends
        } else {
          print("No friends 😢 Making some up")
          friends = friendInfo.loadSampleData()
        }
    
        self.navigationItem.leftBarButtonItem = self.editButtonItem
    }
  
    // MARK: - Table view data source

  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    let height = 80
    return CGFloat(height)
  }
  
    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return friends.count
    }

  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "friendCell", for: indexPath)
    
    if let cell = cell as? FriendTableViewCell {
      let currentFriend = friends[indexPath.row]
      cell.profileImage.image = UIImage(named: currentFriend.profileName)
      cell.nameLabel.text = currentFriend.name
      cell.schoolLabel.text = currentFriend.school
      cell.ageLabel.text = String(currentFriend.age)
    }
    
    return cell
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "showFriendDetail" {
      if let destVC = segue.destination as? DetailsViewController {
        if let indexPath = tableView.indexPathForSelectedRow {
          destVC.friend = friends[indexPath.row]
        }
      }
    }
  }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

  
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            friends.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            friendInfo.saveToFile(friends: friends)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

  
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
      let friend = friends.remove(at: fromIndexPath.row)
      friends.insert(friend, at: to.row)
      friendInfo.saveToFile(friends: friends)
      tableView.reloadData()
    }
  

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
