//
//  ViewController.swift
//  FlickrDemo
//
//  Created by Wenjun Weng on 6/9/19.
//  Copyright © 2019 Wenjun Weng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    var photos = [ImageObject]()
    let perPage = 10
    let transition = PopAnimator()
    var page = 1
    var totalImageCount = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        photos.removeAll()
        callApi()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func callApi() {
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "yyyy-MM-dd"
        let yesterday = (Calendar.current as NSCalendar).date(byAdding: .day, value: -1, to: Date(), options: [])!
        let date = dateFormatterPrint.string(from: yesterday)
        ServiceCall.requestYesterdayInterestingPhoto(date: date, perPage: perPage, page: page) { inner in
            do {
                if let value = try inner() {
                    if let data = value as? [String: Any] {
                        if let photosJson = data["photos"] as? [String: Any]{
                            if let photosArray = photosJson["photo"] as? [[String: Any]]{
                                for photo in photosArray {
                                    self.photos.append(ImageObject.init(dict: photo))
                                }
                                DispatchQueue.main.async {
                                    self.collectionView.reloadData()
                                }
                            }
                            if let total = photosJson["total"] as? String {
                                if let totalInt = Int(total) {
                                    self.totalImageCount = totalInt
                                }
                            }
                        }
                    }
                } else {
                    print("error")
                }
            } catch {
               print("error")
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        cell.configureImageView(photo: photos[indexPath.row])
        //start lazy loading next 10 images when user scroll half way
        if indexPath.row == photos.count - 5 {
            if photos.count < totalImageCount {
                page = page + 1
                callApi()
            }
        }
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailViewController(nibName: "DetailViewController", bundle: nil)
        vc.photo = photos[indexPath.row]
        vc.transitioningDelegate = self
        self.present(vc, animated: true, completion: nil)
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController, source: UIViewController)
        -> UIViewControllerAnimatedTransitioning? {
            transition.originFrame = self.view.frame
            transition.originFrame = CGRect(
                x: transition.originFrame.origin.x,
                y: transition.originFrame.origin.y,
                width: transition.originFrame.size.width,
                height: transition.originFrame.size.height
            )

            transition.presenting = true
            return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}

