//
//  DetailsViewController.swift
//  friends
//
//  Created by Faith on 27/6/19.
//  Copyright © 2019 Faith. All rights reserved.
//

import UIKit
import SafariServices

class DetailsViewController: UIViewController {

  var friend: friendInfo!
  
  @IBOutlet weak var attackSlider: UISlider!
  
  @IBOutlet weak var defenseSlider: UISlider!
  
  @IBOutlet weak var staminaSlider: UISlider!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = friend.name
    friendImage.image = UIImage(named: friend.profileName)
    notes.text = friend.moreInfo
    attackSlider.value = friend.attack
    defenseSlider.value = friend.defense
    staminaSlider.value = friend.stamina
  }
  
  @IBAction func sliderValueChanged(_ sender: UISlider) {
    var sliderName = ""
    
    switch sender {
    case attackSlider:
      sliderName = "Attack"
    case defenseSlider:
      sliderName = "Defense"
    case staminaSlider:
      sliderName = "Stamina"
    default:
      sliderName = "Nani"
    }
    print("\(sliderName) is now \(sender.value)")
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "editFriend",
      let navController = segue.destination as? UINavigationController,
      let destVC = navController.viewControllers.first as? AddFriendTableViewController
    {
      destVC.friend = friend
    }
  }
  
  @IBAction func openURL(_ sender: Any) {
    // check if website exists
    guard let url = URL(string: "https://www.\(friend.links)") else {
      return
    }
    
    let safariVC = SFSafariViewController(url: url)
    present(safariVC, animated: true, completion: nil)
  }
  
  @IBOutlet weak var friendImage: UIImageView!
  
  @IBOutlet weak var notes: UILabel!
}

