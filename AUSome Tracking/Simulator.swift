//
//  Simulator.swift
//  AUSome Tracking
//
//  Created by Yan on 12/2/16.
//  Copyright © 2016 Yan. All rights reserved.
//

import Foundation

class Simulator {
    
    //let jsonData = "{ \"refs\": [{ \"addr\": \"192.168.0.3\", \"x\": 1234, \"y\": 1234 }, { \"addr\": \"192.168.0.4\", \"x\": 1234, \"y\": 1234 }, { \"addr\": \"192.168.0.5\", \"x\": 1234, \"y\": 1234 }, { \"addr\": \"192.168.0.6\", \"x\": 1234, \"y\": 1234 }, { \"addr\": \"192.168.0.7\", \"x\": 1234, \"y\": 1234 }], \"estimates\": [{ \"distance\": 20,  \"duration\": 81525 },{ \"distance\": 50,  \"duration\": 81700 }, { \"distance\": 90,  \"duration\": 82100 }, { \"distance\": 110, \"duration\": 82300 }, { \"distance\": 130, \"duration\": 88500 }], \"samples_count\": 16384, \"iperf_seconds\": 20}"
    
    let jsonData = "{\n" +
                   "\"refs\": [\n" +
                   "{ \"addr\": \"192.168.0.3\", \"x\": 3, \"y\": 3 },\n" +
                   "{ \"addr\": \"192.168.0.4\", \"x\": 20, \"y\": 11 },\n" +
                   "{ \"addr\": \"192.168.0.5\", \"x\": 12, \"y\": 15 },\n" +
                   "{ \"addr\": \"192.168.0.6\", \"x\": 45, \"y\": 7 },\n" +
                   "{ \"addr\": \"192.168.0.7\", \"x\": 10, \"y\": 50 }\n" +
                   "],\n" +
                   "\"estimates\": [\n" +
                   "{ \"distance\": 20,  \"duration\": 81525 },\n" +
                   "{ \"distance\": 50,  \"duration\": 81700 },\n" +
                   "{ \"distance\": 90,  \"duration\": 82100 },\n" +
                   "{ \"distance\": 110, \"duration\": 82300 },\n" +
                   "{ \"distance\": 130, \"duration\": 88500 }\n" +
                   "],\n" +
                   "\"samples_count\": 16384,\n" +
                   "\"iperf_seconds\": 20\n" +
                   "}"
    
    
    func writeToFile() {
        let fileURL = self.dataFileURL()
        let data = jsonData as NSString
        try! data.write(to: fileURL as URL, atomically: true, encoding: String.Encoding.utf8.rawValue)
    }
    
    func test() {
        print("hello world")
    }
    
    func dataFileURL() -> NSURL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentUrl = urls.first
        return documentUrl!.appendingPathComponent("config.json") as NSURL
    }
}
