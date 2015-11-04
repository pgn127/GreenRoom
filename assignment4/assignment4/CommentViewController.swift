//
//  CommentViewController.swift
//  assignment4
//
//  Created by Daniel Del Core on 4/11/2015.
//  Copyright © 2015 Daniel Del Core. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {
    
    @IBOutlet weak var subjectTextBox: UITextField!
    @IBOutlet weak var bodyTextBox: UITextView!
    
    @IBAction func postCommentData(sender: AnyObject) {
        let request = NSMutableURLRequest(URL: NSURL(string: "http://greenroom.danieldelcore.com/api/PostStatusUpdate")!)
        request.HTTPMethod = "POST"
        let postString = "subject=" + self.subjectTextBox.text! + "&body=" + self.bodyTextBox.text
        request.HTTPBody = postString.dataUsingEncoding(NSUTF8StringEncoding)
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in
            if error != nil {
                print("error=\(error)")
                return
            }
            
            let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            print("responseString = \(responseString)")
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}