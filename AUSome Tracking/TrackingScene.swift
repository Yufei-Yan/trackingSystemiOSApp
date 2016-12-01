//
//  TrackingScene.swift
//  AUSome Tracking
//
//  Created by Yan on 11/30/16.
//  Copyright © 2016 Yan. All rights reserved.
//

import UIKit

class TrackingScene: UIViewController, UIPopoverPresentationControllerDelegate {

    var xp1 = 30
    var yp1 = 30
    
    @IBOutlet weak var buttonIp1: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.buttonIp1Init()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //self.dotAnimate(ipButton: buttonIp1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.dotAnimate(ipButton: buttonIp1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ip1Pop"{
            let popoverViewController = segue.destination as! popOver
            popoverViewController.dotId = segue.identifier
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.popover
            popoverViewController.popoverPresentationController!.delegate = self
        }
    }
 
    
    func buttonIp1Init() {
        buttonIp1.isHidden = false
        buttonIp1.frame = CGRect(x: xp1, y:yp1, width:15, height:15)
        buttonIp1.layer.cornerRadius = 0.5 * buttonIp1.bounds.size.width
        buttonIp1.clipsToBounds = true
        buttonIp1.layer.backgroundColor = UIColor.blue.cgColor
        buttonIp1.setTitle("1", for: .normal)
        buttonIp1.titleLabel!.font = UIFont(name: "Helvetica", size: 10)
        buttonIp1.alpha = 1.0
        Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(ip1ChangePosition), userInfo: nil, repeats: true)
        
        buttonIp1.addTarget(self, action: #selector(buttoniP1Pressed(_:)), for: .touchUpInside)
    }
    
    func ip1ChangePosition() {
        xp1 += 5
        yp1 += 5
        self.buttonIp1.frame = CGRect(x: xp1, y:yp1, width:15, height:15)
    }
    
    func dotAnimate(ipButton: UIButton) {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, delay: 0, options:
            [.curveEaseInOut, .repeat, .autoreverse, .allowUserInteraction],
                       animations: {() -> Void in ipButton.alpha = 0.5
                        self.view.layoutIfNeeded()},
                       completion: {(finished: Bool) -> Void in})
    }
    
    func buttoniP1Pressed(_ sender: Any) {
        self.performSegue(withIdentifier: "ip1Pop", sender: self)
    }
    
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }

}
