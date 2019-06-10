//
//  DetailViewController.swift
//  FlickrDemo
//
//  Created by Wenjun Weng on 6/10/19.
//  Copyright © 2019 Wenjun Weng. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var photo : ImageObject?
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    func configureView(){
        titleLbl.text = photo?.title
        imageView.sd_setImage(with: photo?.getImageData(), completed: nil)
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
        let yesterday = (Calendar.current as NSCalendar).date(byAdding: .day, value: -1, to: Date(), options: [])!
        let date = dateFormatterPrint.string(from: yesterday)
        dateLbl.text = date
    }
    @IBAction func closeBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
