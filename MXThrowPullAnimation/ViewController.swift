//
//  ViewController.swift
//  MXThrowPullAnimation
//
//  Created by 牟潇 on 16/3/22.
//  Copyright © 2016年 muxiao. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var squareBlue: UIView!
    @IBOutlet weak var squareRed: UIView!
    @IBOutlet weak var image: UIImageView!
    var originalBounds:CGRect?
    var originalCenter:CGPoint?
    var animator:UIDynamicAnimator?
    var attachmentBehavior:UIAttachmentBehavior?
    var pushBehavior:UIPushBehavior?
    var itemBehavior:UIDynamicItemBehavior?
    override func viewDidLoad() {
        super.viewDidLoad()
        animator = UIDynamicAnimator(referenceView: view)
        originalBounds = image.bounds;
        originalCenter = image.center;
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }

    @IBAction func handleAttachmentGesture(sender: AnyObject) {
        let panGesture = sender as! UIPanGestureRecognizer
        let location = panGesture.locationInView(view);
        let boxLocation = panGesture.locationInView(image);
        if panGesture.state == UIGestureRecognizerState.Began{
            print("you touch started position\(location)")
            animator!.removeAllBehaviors()
            let centerOffset = UIOffsetMake(boxLocation.x - CGRectGetMidX(image.bounds), boxLocation.y - CGRectGetMidY(image.bounds))
            attachmentBehavior = UIAttachmentBehavior(item: image, offsetFromCenter: centerOffset, attachedToAnchor: location);
            squareRed.center = attachmentBehavior!.anchorPoint;
            squareBlue.center = location;
            animator!.addBehavior(attachmentBehavior!)
        }else if panGesture.state == UIGestureRecognizerState.Ended{
            print("you touch started position\(boxLocation)")
            resetDemo()
        }else{
            attachmentBehavior!.anchorPoint = panGesture.locationInView(view)
            squareRed.center = attachmentBehavior!.anchorPoint
        }
    }
    
    func resetDemo(){
        animator!.removeAllBehaviors()
        UIView.animateWithDuration(0.45, animations: {
            [weak self]() in
            self!.image.bounds = self!.originalBounds!;
            self!.image.center = self!.originalCenter!;
            self!.image.transform = CGAffineTransformIdentity;
        })
    }

}

