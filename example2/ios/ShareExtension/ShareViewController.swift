//
//  ShareViewController.swift
//  ShareExtension
//
//  Created by Humaid Khan on 29/05/2022.
//

import UIKit
import Social


class ShareViewController: UIViewController {
    @IBOutlet weak var myLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        NSLog("wowowo")
        
        // load mmkv storage here
        // will it actually work?
        let myGroupID = "group.org.humaidk2.example.example2";
      
      let str = "com.MMKV.default"
      let data = Data(str.utf8)
      let hexString = data.map{ String(format:"%02x", $0) }.joined()
// the group dir that can be accessed by App & extensions
      NSLog("hexString = " + hexString)
      var result:Data?
      if let receivedData = KeyChain.load(key: hexString) {
          result = receivedData // 636f6d2e4d4d4b562e616d6d617261686d6564
        NSLog("result: got no error")
      } else {
        NSLog("There is no key")
      }
      print("wow")
        print(myGroupID)
      
      let groupDir = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: myGroupID)?.path ?? ""
      let rootDir = groupDir.appendingFormat("/mmkv") ?? ""
      NSLog(groupDir)
      NSLog(rootDir)
        // Do not include this directory in cloud backups.
//      let error:Error = Error()
      let url = URL(fileURLWithPath: rootDir, isDirectory: true)
//      url.setResourceValue(numberwithboo, forKey: <#T##Foundation.URLResourceKey#>)
      let storage = MMKV.initialize(rootDir: nil, groupDir: rootDir, logLevel: MMKVLogLevel.info)
      let mmkv = MMKV(mmapID: "storage",cryptKey: result, mode: MMKVMode.multiProcess)
      let allKeys = mmkv?.allKeys()
      NSLog("loading stuff done")
      NSLog(String(allKeys!.count))
      print("wow")
      dump(allKeys)
      var arrayOfStrings: [String] = allKeys!.compactMap { String(describing: $0) }
        
        
        
    
      for element in arrayOfStrings {
        NSLog(element)
          if(element == "persist:root") {
              // Convert to a string and print
              guard let data: Data = mmkv?.data(forKey:element) else {
                  NSLog("Error !!!")
                  return
              }
              
              let json = try? JSONSerialization.jsonObject(with: data, options: [])
              
              if  let dictionary = json as? [String: Any] {
                  
              NSLog("got dictionary")
                  if let counter = dictionary["counter"] as? [String: Any] {
                      
                  NSLog("got counter")
                          // access nested dictionary values by key
                      if let value = counter["value"] as? Int {
                              // access individual value in dictionary
                          
                      NSLog("got value")
                          NSLog("value = ", value)
                      }
                  }
                  if let counter = dictionary["counter"] as? String {
                      
                      NSLog("got counter string")
                      let coolData = counter.data(using: .utf8)!
                      
                      let myData = try? JSONSerialization.jsonObject(with: coolData, options: [])
                      if let counterObj = myData as? [String:Any] {
                          if let value = counterObj["value"] as? Int {
                                  // access individual value in dictionary
                              myLabel.text = "value = " + String(value)
                          NSLog("got value")
                              NSLog("value = " + String(value))
                          }
                      }
                  }
              }
              if let JSONString = String(data: data, encoding: String.Encoding.utf8) {
                  NSLog("newString = " + JSONString)
                 print(JSONString)
              }
              
          }
      }
      
    }
    
    
    @IBAction func buttonPress(_ sender: Any) {
        NSLog("wowowo")
        print("ok")
        NSLog("wowowo")
    }
    
    
//    override func isContentValid() -> Bool {
//        // Do validation of contentText and/or NSExtensionContext attachments here
//        return true
//    }
//
//    override func didSelectPost() {
//        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
//    
//        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
//        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
//    }
//
//    override func configurationItems() -> [Any]! {
//        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
//        return []
//    }

}
