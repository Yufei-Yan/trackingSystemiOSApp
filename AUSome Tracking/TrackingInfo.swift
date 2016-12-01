//
//  TrackingInfo.swift
//  AUSome Tracking
//
//  Created by Yan on 11/30/16.
//  Copyright © 2016 Yan. All rights reserved.
//

import UIKit

class TrackingInfo: UIViewController {
    
    @IBOutlet var views:[UIView]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let data = self.dataFileData()
        //let test: String! = ""
        if (data as Any) is Data {
            self.dataExtracting(data: data!)
        } else {
            let controller = UIAlertController(title: "Alert", message: "Data type ERROR!", preferredStyle: UIAlertControllerStyle.alert)
            controller.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(controller, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
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
    
    func dataExtracting(data: Data) {
        let json = JSON(data: data)
        let refs = json["refs"].arrayValue
        let estimates = json["estimates"].arrayValue
        
        var tag = 0
        for i in 0..<json["refs"].count {
            tag = i * 10 + 10
            if let label = views[i].viewWithTag(tag + 1) as? UILabel {
                label.text = refs[i]["addr"].stringValue
            }
            if let label = views[i].viewWithTag(tag + 2) as? UILabel {
                let x = refs[i]["x"].stringValue
                let y = refs[i]["y"].stringValue
                
                label.text = "x: " + x + ", y: " + y
            }
        }
        
        for i in 0..<json["estimates"].count {
            tag = i * 10 + 10
            if let label = views[i].viewWithTag(tag + 3) as? UILabel {
                label.text = String(estimates[i]["duration"].doubleValue / 1000.0) + " seconds"
            }
        }
    }

}
