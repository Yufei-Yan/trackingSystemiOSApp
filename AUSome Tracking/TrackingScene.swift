//
//  TrackingScene.swift
//  AUSome Tracking
//
//  Created by Yan on 11/30/16.
//  Copyright © 2016 Yan. All rights reserved.
//

import UIKit

class TrackingScene: UIViewController, UIPopoverPresentationControllerDelegate {

    struct Size {
        static let Width = 59.0
        static let Height = 59.0
    }
    
    @IBOutlet var buttons: [UIButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //self.buttonIp1Init()
        //self.buttonIp2Init()
        //definesPresentationContext = true
        
        let data = self.dataFileData()
        //let test: String! = ""
        if (data as Any) is Data {
            for i in 0..<self.buttons.count {
                let rawPosition = self.getRawPosition(tag: self.buttons[i].tag, data: data!)
                self.buttonIpInit(buttonIp: self.buttons[i], x: rawPosition.0, y: rawPosition.1)
            }
        } else {
            let controller = UIAlertController(title: "Alert", message: "Data type ERROR!", preferredStyle: UIAlertControllerStyle.alert)
            controller.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //self.dotAnimate(ipButton: buttonIp1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.dotAnimate(ipButton: buttonIp1)
        //self.dotAnimate(ipButton: buttonIp2)
        for i in 0..<self.buttons.count {
            self.dotAnimate(ipButton: self.buttons[i])
        }
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
        if segue.identifier == "ip1Pop" ||
           segue.identifier == "ip2Pop" ||
           segue.identifier == "ip3Pop" ||
           segue.identifier == "ip4Pop" ||
           segue.identifier == "ip5Pop" {
            let popoverViewController = segue.destination as! popOver
            popoverViewController.dotId = segue.identifier
            popoverViewController.modalPresentationStyle = UIModalPresentationStyle.popover
            popoverViewController.popoverPresentationController!.delegate = self
        }
    }
    
    func buttonIpInit(buttonIp: UIButton, x: Int, y:Int) {
        buttonIp.isHidden = false
        let position = self.calculatePositon(x: x, y: y)
        
        buttonIp.frame = CGRect(x: position.0, y: position.1, width:15, height:15)
        buttonIp.layer.cornerRadius = 0.5 * buttonIp.bounds.size.width
        buttonIp.clipsToBounds = true
        buttonIp.layer.backgroundColor = UIColor.blue.cgColor
        buttonIp.setTitle(String(buttonIp.tag), for: .normal)
        buttonIp.titleLabel!.font = UIFont(name: "Helvetica", size: 10)
        buttonIp.alpha = 1.0
    
    }
    
    func calculatePositon(x: Int, y: Int) -> (Double, Double) {
        let xp = Double(x)/Size.Width * Double(UIScreen.main.bounds.width)
        let yp = Double(y)/Size.Height * Double(UIScreen.main.bounds.height)
        
        return(xp, yp)
    }
    
//    func ip1ChangePosition() {
//        xp1 += 5
//        yp1 += 5
//        self.buttonIp1.frame = CGRect(x: xp1, y:yp1, width:15, height:15)
//    }
    
    func dotAnimate(ipButton: UIButton) {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, delay: 0, options:
            [.curveEaseInOut, .repeat, .autoreverse, .allowUserInteraction],
                       animations: {() -> Void in ipButton.alpha = 0.3
                        self.view.layoutIfNeeded()},
                       completion: {(finished: Bool) -> Void in})
    }
    
//    func buttonIp1Pressed(_ sender: Any) {
//        self.performSegue(withIdentifier: "ip1Pop", sender: self)
//    }
    
    
    func dataFileURL() -> NSURL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentUrl = urls.first
        return documentUrl!.appendingPathComponent("config.json") as NSURL
    }
    
    func dataFileData() -> Data? {
        var jsonData: NSData? = nil
        var nsString: String? = nil
        let fileURL = self.dataFileURL()
        if (FileManager.default.fileExists(atPath: fileURL.path!)) {
            //print(fileURL)
            //let ccc = try! String(contentsOf: fileURL as URL)
            //print(ccc)
            jsonData = NSData(contentsOf: fileURL as URL)
            nsString = NSString(data: jsonData as! Data, encoding: String.Encoding.utf8.rawValue) as? String
        }
        
        if let data = nsString?.data(using: String.Encoding.utf8) {
            return data
        }
        
        return nil
    }
    
    func getRawPosition(tag: Int, data: Data) -> (Int, Int) {
        let json = JSON(data: data)
        let refs = json["refs"].arrayValue
        
        let rawPosition = (refs[tag - 1]["x"].int!, refs[tag - 1]["y"].int!)
        
        return rawPosition
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }

}
