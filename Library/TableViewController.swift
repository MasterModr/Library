//
//  TableViewControler.swift
//  Library
//
//  Created by Jason on 8/18/15.
//  Copyright © 2015 IIT. All rights reserved.
//

import UIKit


class TableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    

    var data: [String] = []
    var dict = [String : String]()
    var rowNumber = 0
    
    @IBOutlet var myView: UIView!
    @IBOutlet weak var searchbar: UITextField!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Setup delegates */
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.reloadData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell");
        cell?.textLabel?.text = data[indexPath.row] as String
        return cell!;
    }
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("catalogDetail", sender: tableView)
        self.rowNumber = indexPath.row
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let detail = segue.destinationViewController as? DetailViewController
        let bibid = dict[data[rowNumber]]
        print(dict[data[rowNumber]])
        let path = "getinfo?keyword=" + bibid!
        RestApiManager.sharedInstance.getNames(path, onCompletion: { json in
            let result = json["content"]
            //print(result.rawString()!)
            let results: [String] = (result.rawString()?.componentsSeparatedByString("\n"))!
            detail?.setBookTitle(results[0])
            detail?.setBookAuthor(results[1])
            var index = Range(start: results[2].startIndex, end: advance(results[2].startIndex, 10))
            var tempint = Int(results[2].substringWithRange(index))!
            detail?.setImage(tempint)
            detail?.setCallNo(results[3])
            detail?.setLocatio(results[4])
            dispatch_async(dispatch_get_main_queue(),{
                detail?.reloadInfo()
            })

        
        })
    }
    
    @IBAction func search(sender: AnyObject) {
        var path = "getnames?keyword="
        var textresult = searchbar.text!
        if(textresult == "")
        {
            textresult = "asdfghjkl"
        }
        path += textresult
        self.data = []
        self.dict = [String : String]()
        RestApiManager.sharedInstance.getNames(path, onCompletion: { json in
            let result = json["content"]
            let results = result.rawString()?.componentsSeparatedByString("\n")
            var count = 0;
            
            while(count < (results!.count - 1))
            {
                let element: String = results![count]
                let elements = element.componentsSeparatedByString("$")
                print(elements[0])
                if(elements[0] != "no results")
                {
                    if let _ = self.dict[elements[1]] {
                    
                    }
                    else
                    {
                        self.dict[elements[1]] = elements[0]
                        self.data.append(elements[1])
                    }
                    
                }
                else
                {
                    self.data.append(elements[0])
                }
                
                count++
            }
            dispatch_async(dispatch_get_main_queue(),{
                tableView?.reloadData()
            })
            
            /*for (index: String, subJson: JSON) in results {
                let user: AnyObject = JSON["user"].object
                print(user)
                dispatch_async(dispatch_get_main_queue(),{
                    tableView?.reloadData()
                })
            }*/
        })
        print(data)
    }
}