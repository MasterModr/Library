//
//  DetailViewController.swift
//  Library
//
//  Created by Jason on 8/25/15.
//  Copyright © 2015 IIT. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var isbnImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var callnoLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!

    var isbn: String = ""
    var booktitle: String = ""
    var bookauthor: String = ""
    var calln: String = ""
    var locat: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let url = NSURL(string: "http://covers.openlibrary.org/b/isbn/" + isbn + "-L.jpg?default=false") {
            if let data = NSData(contentsOfURL: url)
            {
                
                self.isbnImage.image = UIImage(data: data)
                self.isbnImage.contentMode = UIViewContentMode.ScaleAspectFill
            }
        }
        self.titleLabel.text = self.booktitle
        self.authorLabel.text = self.bookauthor
        self.callnoLabel.text = self.calln
        self.locationLabel.text = self.locat
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setImage(number: Int) {
        if(sizeof(number.dynamicType) == 13){
            self.isbn = (number as NSNumber).stringValue
        }
        else{
            var data: [Int] = []
            var number1 = number + 9780000000000
            print(number1)
            while(number1 != 0)
            {
                
                data.append(number1 % 10)
                number1 = number1 / 10
            }
            data = data.reverse()
            let tempnum: Int = (10 - ((data[0]) + (3 * data[1]) + (data[2]) + (3 * data[3]) + (data[4]) + (3 * data[5]) + (data[6]) + (3 * data[7]) + (data[8]) + (3 * data[9]) + (data[10]) + (3 * data[11])) % 10) % 10
            data[12] = tempnum
            data = data.reverse()
            number1 = 0
            var place = 1;
            for(var counter = 0; counter < data.count; counter++){
                number1 += data[counter] * place
                place *= 10
            }
            print(number1)
            self.isbn = (number1 as NSNumber).stringValue
            reloadInfo()
        }
    }
    
    func setBookTitle(string: String){
        self.booktitle = string
    }
    
    func setBookAuthor(string: String){
        self.bookauthor = string
    }
    
    func setCallNo(string: String){
        self.calln = string
    }

    func setLocatio(string: String){
        self.locat = string
    }
    
    func reloadInfo(){
        if let url = NSURL(string: "http://covers.openlibrary.org/b/isbn/" + isbn + "-L.jpg?default=false") {
            if let data = NSData(contentsOfURL: url)
            {
                
                self.isbnImage.image = UIImage(data: data)
                self.isbnImage.contentMode = UIViewContentMode.ScaleAspectFill
            }
        }
        self.titleLabel.text = self.booktitle
        self.authorLabel.text = self.bookauthor
        self.callnoLabel.text = self.calln
        self.locationLabel.text = self.locat
    }
    
}
