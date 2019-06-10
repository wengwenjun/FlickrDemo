//
//  PopAnimator.swift
//  FlickrDemo
//
//  Created by Wenjun Weng on 6/10/19.
//  Copyright © 2019 Wenjun Weng. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let duration = 0.8
    var presenting = true
    var originFrame = CGRect.zero

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toView = transitionContext.view(forKey: .to)!
        let detailView = presenting ? toView : transitionContext.view(forKey: .from)!
        let scaleTransform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        if presenting {
            detailView.transform = scaleTransform
            detailView.center = CGPoint(
                x: originFrame.midX,
                y: originFrame.midY)
            detailView.clipsToBounds = true
        }
        detailView.layer.cornerRadius = presenting ? 20.0 : 0.0
        detailView.layer.masksToBounds = true
        containerView.addSubview(toView)
        containerView.bringSubviewToFront(detailView)
        
        UIView.animate(
            withDuration: duration,
            delay:0.0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 0.2,
            animations: {
                detailView.transform = self.presenting ? .identity : scaleTransform
                detailView.center = CGPoint(x: self.originFrame.midX, y: self.originFrame.midY)
                detailView.layer.cornerRadius = !self.presenting ? 20.0 : 0.0
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
}
