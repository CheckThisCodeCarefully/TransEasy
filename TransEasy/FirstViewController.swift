//
//  FirstViewController.swift
//  TransEasy
//
//  Created by Mohammad on 7/19/16.
//  Copyright © 2016 Porooshani. All rights reserved.
//

import UIKit

private let toSecondViewSegueID = "toSecondViewSegue"

class FirstViewController: UIViewController {

    @IBOutlet weak var qrButton: UIButton!
    @IBOutlet weak var qrLabel: UILabel!
  
    var easyPresentAnimationComtroller = EasyPresentAnimationController()
    var easyDismissAnimationComtroller = EasyDismissAnimationController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func qrButtonClicked(sender: AnyObject) {
        performSegueWithIdentifier(toSecondViewSegueID, sender: sender)        
    }
  
  
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    
    guard let segueID = segue.identifier else {
      print("Could not verify the segue's identity")
      return
    }
    
    switch segueID {
    case toSecondViewSegueID:
      segue.destinationViewController.transitioningDelegate = self      
    default:
      print("Unknown segue!")
    }
    
  }

}


extension FirstViewController: UIViewControllerTransitioningDelegate {
  
  func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
   
    guard let secondVC = presented as? SecondViewController else {
      print("Invalid target controller")
      return nil
    }
    easyPresentAnimationComtroller.blurEffectStyle = UIBlurEffectStyle.Dark
    easyPresentAnimationComtroller.duration = 0.4
    easyPresentAnimationComtroller.originalView = qrButton
    easyPresentAnimationComtroller.destinationView = secondVC.qrImage

    return easyPresentAnimationComtroller
  }
  
  func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
    guard let secondVC = dismissed as? SecondViewController else {
      print("Invalid target controller")
      return nil
    }
    easyDismissAnimationComtroller.duration = 0.4
    easyDismissAnimationComtroller.originalView = secondVC.qrImage
    easyDismissAnimationComtroller.destinationView = qrButton

    return easyDismissAnimationComtroller
    
  }
  
}
