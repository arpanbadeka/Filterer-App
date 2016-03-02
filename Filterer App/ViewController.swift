//
//  ViewController.swift
//  Filterer App
//
//  Created by Arpan Badeka on 07/01/16.
//  Copyright © 2016 abc. All rights reserved.
//

import UIKit
import QuartzCore


class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate, UIScrollViewDelegate{
    

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var greenEditImage: UIImageView!
    var timer = NSTimer()
    var oImage:UIImage?
    var fImage:UIImage?
    var endAnimation:Bool = true;
    var ghostImageView:UIImageView?
    
    var greyImage:UIImage?
    var invertedImage:UIImage?
    var greenImage:UIImage?
    var blueImage:UIImage?
    var redImage:UIImage?
    var prevSliderVal:Float = 0;
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var invertButton: UIButton!
    @IBOutlet weak var bottomView: UIView!
    
    @IBOutlet weak var greyButton: UIButton!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var editSlider: UISlider!
    @IBOutlet weak var editViewHeight: NSLayoutConstraint!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet var originalImage: UIView!
    @IBOutlet var secondaryMenu: UIView!
    @IBOutlet weak var compareImage: UIButton!
    
    @IBOutlet var editView: UIView!
    @IBOutlet weak var editButton: UIButton!
    var invert:UIImage!
    var grey:UIImage!
    var red:UIImage!
    var green:UIImage!
    var blue:UIImage!
    
    var greenEdit:UIImage!
    
    @IBOutlet weak var scrollViewOriginal: UIScrollView!

    @IBOutlet var zoomTapGestureRecognizer: UITapGestureRecognizer!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        compareImage.enabled = false
        originalImage.translatesAutoresizingMaskIntoConstraints = false
        imageView1.translatesAutoresizingMaskIntoConstraints = false
        secondaryMenu.translatesAutoresizingMaskIntoConstraints = false
        secondaryMenu.backgroundColor = UIColor.whiteColor().colorWithAlphaComponent(0.5)
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: "longPressHandler:");
        imageView.addGestureRecognizer(longPressGestureRecognizer);
        oImage = UIImage(CGImage: (imageView.image?.CGImage)!);
        green = onGreenImage(oImage!)
        greenButton.setImage(green, forState: .Normal)
        grey = onGreyImage(oImage!)
        greyButton.setImage(grey, forState: .Normal)
        blue = onBlueImage(oImage!)
        blueButton.setImage(blue, forState: .Normal)
        invert = onInvertImage(oImage!)
        invertButton.setImage(invert, forState: .Normal)
        red = onRedImage(oImage!)
        redButton.setImage(red, forState: .Normal)
        
        
    }

    func longPressHandler(recognizer:UILongPressGestureRecognizer) {
        
        fImage = imageView.image;
        
        if recognizer.state == UIGestureRecognizerState.Changed{
            
            //view.addSubview(originalImage)
            
            if endAnimation == true
            {
                self.ghostImageView = UIImageView(frame: imageView.frame);
                self.ghostImageView!.image = oImage;
                self.ghostImageView!.alpha = 0.0
                self.ghostImageView?.backgroundColor = UIColor.blackColor();
                self.ghostImageView!.contentMode = UIViewContentMode.ScaleAspectFit;
                self.view.addSubview(self.ghostImageView!);
                self.endAnimation = false;
                //let ctr = FullScreenSlideshowViewController()
                self.fadeIn();
            }
            
        }
        else if recognizer.state == UIGestureRecognizerState.Ended{
            print("ended called")
            self.endAnimation = true;
        }else if recognizer.state == UIGestureRecognizerState.Failed{
            hideFiltered()
        } else if recognizer.state == UIGestureRecognizerState.Began{
            hideFiltered()
        }
    }
    
    
    func fadeIn()
    {
        
        UIView.animateWithDuration(1.0 , animations: { () -> Void in
            
            self.ghostImageView?.alpha = 1.0;
            self.imageView.alpha = 0.0;
            
            }) { (success) -> Void in
             
                self.fadeOut();
        }
    }
    
    func fadeOut()
    {

        UIView.animateWithDuration(1.0, animations: { () -> Void in
            
            self.ghostImageView?.alpha = 0.0;
            self.imageView.alpha = 1.0;

            }) { (success) -> Void in
               
                if !self.endAnimation
                {
                    self.fadeIn();
                }
                else
                {
                    self.ghostImageView?.removeFromSuperview();
                }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        
//        self.imageView.alpha = 1
//        UIView.animateWithDuration(1){
//            self.imageView.alpha = 0.5
//            self.hideFiltered()
//        }
//    }
//    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        
//        self.imageView1.alpha = 0
//        UIView.animateWithDuration(1){
//            self.imageView1.alpha = 0.5
//            self.showFiltered()
//        }
//        
//    }
    
    @IBAction func onSlider(sender: UISlider) {
        
        
//        var multiplier:Float = 1;
//        var diff:Float = sender.value - prevSliderVal;
//        if(sender.value - prevSliderVal < 0)
//        {
//            multiplier = -1;
//        }
//        prevSliderVal = sender.value;
//        
        if(greenButton.selected){
            let slidervalue = editSlider.value
            greenEdit = greenEditImage.image
            let myRGBA = RGBAImage(image: imageView.image!)
            for y in 0..<myRGBA!.height {
                for x in 0..<myRGBA!.width{
                    let index = y * myRGBA!.width + x
                    var pixel = myRGBA!.pixels[index]
                    pixel.green = UInt8(155 + slidervalue)
                    myRGBA!.pixels[index] = pixel
                }
            }
            imageView.image = myRGBA?.toUIImage()!
        }
        else if(blueButton.selected)
        {
            let slidervalue = editSlider.value
            let myRGBA = RGBAImage(image: imageView.image!)
            for y in 0..<myRGBA!.height {
                for x in 0..<myRGBA!.width{
                    let index = y * myRGBA!.width + x
                    var pixel = myRGBA!.pixels[index]
                    pixel.blue = UInt8(155 + slidervalue)
                    myRGBA!.pixels[index] = pixel
                }
            }
            imageView.image = myRGBA?.toUIImage()!
        }
        else if(redButton.selected)
        {
            let slidervalue = editSlider.value
            let myRGBA = RGBAImage(image: imageView.image!)
            for y in 0..<myRGBA!.height {
                for x in 0..<myRGBA!.width{
                    let index = y * myRGBA!.width + x
                    var pixel = myRGBA!.pixels[index]
                    pixel.red = UInt8(155 + slidervalue)
                    myRGBA!.pixels[index] = pixel
                }
            }
            imageView.image = myRGBA?.toUIImage()!
        }
        else if(invertButton.selected)
        {
            let slidervalue = editSlider.value
            let myRGBA = RGBAImage(image: imageView.image!)
            for y in 0..<myRGBA!.height {
                for x in 0..<myRGBA!.width{
                    let index = y * myRGBA!.width + x
                    var pixel = myRGBA!.pixels[index]
//                    pixel.red = UInt8(max(0,min(255, (Int(pixel.red)  - 255)*(-1))))
//                    pixel.green = UInt8(max(0,min(255, (Int(pixel.green)  - 255)*(-1))))
//                    pixel.blue = UInt8(max(0,min(255, (Int(pixel.blue) - 255)*(-1))))
                     pixel.red = UInt8(max(0,min(255, (Int(110) - 255)*(-1) + Int(slidervalue) * 2)))
                    //pixel.red = UInt8(40 + Int(slidervalue))
                   // pixel.blue = UInt8(40 + Int(slidervalue))
                    //pixel.red = UInt8(40 + Int(slidervalue))
                    
                    myRGBA!.pixels[index] = pixel
                }
            }
            imageView.image = myRGBA?.toUIImage()!
        }
        else if(greyButton.selected){
            var multiplier: Float = 1
            if(sender.value - prevSliderVal > 0)
            {
                multiplier = -1
            }
            prevSliderVal = sender.value
            var slidervalue = editSlider.value
            slidervalue = slidervalue * multiplier
            let myRGBA = RGBAImage(image: imageView.image!)!
            for y in 0..<myRGBA.height {
                for x in 0..<myRGBA.width{
                    let index = y * myRGBA.width + x
                    var pixel = myRGBA.pixels[index]
                    pixel.red = UInt8(max(0,(min(255, (Double(pixel.red) * 0.21)+(Double(pixel.green) * 0.72)+(Double(pixel.blue) * 0.07) + Double(slidervalue/50)))))
                    pixel.green = UInt8(max(0,(min(255, (Double(pixel.red) * 0.21)+(Double(pixel.green) * 0.72)+(Double(pixel.blue) * 0.07) + Double(slidervalue/50)))))
                    pixel.blue = UInt8(max(0,(min(255, (Double(pixel.red) * 0.21)+(Double(pixel.green) * 0.72)+(Double(pixel.blue) * 0.07) + Double(slidervalue/50)))))
                    
                    myRGBA.pixels[index] = pixel
                }
            }
            imageView.image = myRGBA.toUIImage()!

        }
    }
    
    @IBAction func onNewPhoto(sender: AnyObject) {
        let actionSheet = UIAlertController(title: "New Photo", message: nil, preferredStyle: .ActionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .Default, handler: { action in
                self.showCamera()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Album", style: .Default, handler: { action in
                self.showAlbum()
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: nil))
        
        self.presentViewController(actionSheet, animated: true, completion: nil)
        
    }
    
    func showCamera(){
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .Camera
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    func showAlbum() {
        let cameraPicker = UIImagePickerController()
        cameraPicker.delegate = self
        cameraPicker.sourceType = .PhotoLibrary
        presentViewController(cameraPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .ScaleAspectFit
            imageView.image = image
            imageView1.image = image
            oImage = UIImage(CGImage: (imageView.image?.CGImage)!);
            green = onGreenImage(oImage!)
            greenButton.setImage(green, forState: .Normal)
            grey = onGreyImage(oImage!)
            greyButton.setImage(grey, forState: .Normal)
            blue = onBlueImage(oImage!)
            blueButton.setImage(blue, forState: .Normal)
            invert = onInvertImage(oImage!)
            invertButton.setImage(invert, forState: .Normal)
            red = onRedImage(oImage!)
            redButton.setImage(red, forState: .Normal)
        }
    }

    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func onShare(sender: AnyObject) {
        let activityController = UIActivityViewController(activityItems: [imageView.image!], applicationActivities: nil)
        presentViewController(activityController, animated: true, completion: nil)
    }
    
    @IBAction func onFilter(sender: UIButton) {
        if(sender.selected) {
            hideSecondaryMenu()
            sender.selected = false
            compareImage.enabled = false
            compareImage.selected = false
        } else {
            showSecondaryMenu()
            sender.selected = true
            compareImage.enabled = true
            compareImage.selected = false
            
        }
    }
    
    @IBAction func onEdit(sender: UIButton) {
         hideSecondaryMenu()
        if(sender.selected){
            hideeditView()
            sender.selected = false
           
        }
        else{
            showeditView()
            filterButton.selected = false
            sender.selected = true
            
        }
    }
    @IBAction func onGrey(sender: UIButton) {
      sender.selected = !sender.selected;
      if sender.selected{
        imageView.image = imageView1.image
        compareImage.enabled = true
        compareImage.selected = false
        UIView.transitionWithView(imageView, duration: 1.0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
            self.imageView.image = self.onGreyImage(self.imageView.image!)
            }, completion: { (success) -> Void in
        })

      
        }else{
            greyButton.selected = false
            compareImage.enabled = false
            compareImage.selected = false
            showFiltered()
        }
    }
    
    @IBAction func onInvert(sender: UIButton) {
        sender.selected = !sender.selected;
        if sender.selected{
            imageView.image = imageView1.image
            compareImage.enabled = true
            compareImage.selected = false
            UIView.transitionWithView(imageView, duration: 1.0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
                self.imageView.image = self.onInvertImage(self.imageView.image!)
                }, completion: { (success) -> Void in
            })
        }else{
            invertButton.selected = false
            compareImage.enabled = false
            compareImage.selected = false
            showFiltered()

        }
    }
    @IBAction func onRed(sender: UIButton) {
        sender.selected = !sender.selected;
        if sender.selected {
            imageView.image = imageView1.image
            compareImage.selected = false
            UIView.transitionWithView(imageView, duration: 1.0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
                self.imageView.image = self.onRedImage(self.imageView.image!)
                }, completion: { (success) -> Void in
            })
        }else{
            redButton.selected = false
            compareImage.enabled = false
            compareImage.selected = false
            showFiltered()

        }
        
    }

    @IBAction func onBlue(sender: UIButton) {
        sender.selected = !sender.selected;
        if sender.selected{
            imageView.image = imageView1.image
            compareImage.enabled = true
            compareImage.selected = false
            UIView.transitionWithView(imageView, duration: 1.0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
                self.imageView.image = self.onBlueImage(self.imageView.image!)
                }, completion: { (success) -> Void in
            })
        }else{
            blueButton.selected = false
            compareImage.enabled = false
            compareImage.selected = false
            showFiltered()

        }
    }
    
    @IBAction func onGreen(sender: UIButton) {
        sender.selected = !sender.selected;
        if sender.selected{
            imageView.image = imageView1.image
            compareImage.enabled = true
            compareImage.selected = false
            UIView.transitionWithView(imageView, duration: 1.0, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
                self.imageView.image = self.onGreenImage(self.imageView.image!)
                }, completion: { (success) -> Void in
            })
            imageView.image = onGreenImage(imageView.image!)
        }else{
            greenButton.selected = false
            compareImage.enabled = false
            compareImage.selected = false
            showFiltered()

        }
    }
    
    func showSecondaryMenu() {
        view.addSubview(secondaryMenu)
        
        let bottomConstraint = secondaryMenu.bottomAnchor.constraintEqualToAnchor(bottomView.topAnchor)
        let leftConstraint = secondaryMenu.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = secondaryMenu.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        let heightConstraint = secondaryMenu.heightAnchor.constraintEqualToConstant(44)
        
        NSLayoutConstraint.activateConstraints([bottomConstraint, leftConstraint, rightConstraint, heightConstraint])
        
        view.layoutIfNeeded()
        
        self.secondaryMenu.alpha = 0
        UIView.animateWithDuration(1){
            self.secondaryMenu.alpha = 1.0
        }
        
   }
    func hideSecondaryMenu(){
        
        UIView.animateWithDuration(0.4, animations:{self.secondaryMenu.alpha = 0.0}) { completed in
            if completed == true
            {
                self.secondaryMenu.removeFromSuperview()
            }

//        secondaryMenu.heightAnchor.constraintEqualToConstant(0)
//        UIView.animateWithDuration(0.5) { () -> Void in
//            self.view.layoutIfNeeded();
//            self.secondaryMenu.hidden = true;
        }
//        }
    }

    func showeditView(){
        hideSecondaryMenu()

       // editSlider.hidden = false;
        editViewHeight.constant = 44.0
        UIView.animateWithDuration(0.5) { () -> Void in
            self.view.layoutIfNeeded();
            self.editSlider.hidden = false;
        }
    }
    
    func hideeditView(){

        editViewHeight.constant = 0.0
        UIView.animateWithDuration(0.5) { () -> Void in
            self.view.layoutIfNeeded();
            self.editSlider.hidden = true;
        }

    }
    func onGreyImage(image: UIImage) -> UIImage{
        let myRGBA = RGBAImage(image: imageView.image!)!
        for y in 0..<myRGBA.height {
            for x in 0..<myRGBA.width{
                let index = y * myRGBA.width + x
                var pixel = myRGBA.pixels[index]
                pixel.red = UInt8((Double(pixel.red) * 0.21)+(Double(pixel.green) * 0.72)+(Double(pixel.blue) * 0.07))
                pixel.green = UInt8((Double(pixel.red) * 0.21)+(Double(pixel.green) * 0.72)+(Double(pixel.blue) * 0.07))
                pixel.blue = UInt8((Double(pixel.red) * 0.21)+(Double(pixel.green) * 0.72)+(Double(pixel.blue) * 0.07))

                myRGBA.pixels[index] = pixel
            }
        }
      return myRGBA.toUIImage()!
        
    }
    
    func onInvertImage(image: UIImage) -> UIImage{
        let myRGBA = RGBAImage(image: image)!
        for y in 0..<myRGBA.height {
            for x in 0..<myRGBA.width {
                let index = y * myRGBA.width + x
                var pixel = myRGBA.pixels[index]
                pixel.red = UInt8(max(0,min(255, (Int(110) - 255)*(-1))))
                pixel.green = UInt8(max(0,min(255, (Int(pixel.green) - 255)*(-1))))
                pixel.blue = UInt8(max(0,min(255, (Int(pixel.blue) - 255)*(-1))))
                myRGBA.pixels[index] = pixel
            }
        }
        return myRGBA.toUIImage()!
    }
    
    func onRedImage(image: UIImage) -> UIImage{
        let myRGBA = RGBAImage(image: image)!
            for i in 0..<myRGBA.height {
            for j in 0..<myRGBA.width {
                let index = i * myRGBA.width + j
                var pixel = myRGBA.pixels[index]
                    pixel.red = UInt8(155)
                    myRGBA.pixels[index] = pixel
            }
        }
        return myRGBA.toUIImage()!
    }
    
    func onBlueImage(image: UIImage) -> UIImage{
        let myRGBA = RGBAImage(image: imageView.image!)!
        for i in 0..<myRGBA.height {
            for j in 0..<myRGBA.width {
                let index = i * myRGBA.width + j
                var pixel = myRGBA.pixels[index]
                    pixel.blue = UInt8(155)
                    myRGBA.pixels[index] = pixel
            }
        }
        return myRGBA.toUIImage()!
    }
    
    func onGreenImage(image: UIImage) -> UIImage{
        let myRGBA = RGBAImage(image: image)!
        for i in 0..<myRGBA.height {
            for j in 0..<myRGBA.width {
                let index = i * myRGBA.width + j
                var pixel = myRGBA.pixels[index]
                    pixel.green = UInt8(155)
                    myRGBA.pixels[index] = pixel
           }
        }
        greenEditImage.image = myRGBA.toUIImage()
        return myRGBA.toUIImage()!
    }
    
    @IBAction func onCompare(sender: UIButton) {
        //sender.selected = !sender.selected;
        if sender.selected{
            //imageView.image = imageStorage[1]
            hideFiltered()
            //compareImage.selected = false
        }
        else {
             showFiltered()
            compareImage.selected = true
        }
    }
    
    func showFiltered1() -> UIView{
        view.addSubview(originalImage)
        
        let topConstraint = originalImage.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor)
        let bottomConstraint = originalImage.bottomAnchor.constraintEqualToAnchor(secondaryMenu.topAnchor)
        let leftConstraint = originalImage.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = originalImage.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        let topConstraint1 = imageView1.topAnchor.constraintEqualToAnchor(topLayoutGuide.bottomAnchor)
        let bottomConstraint1 = imageView1.bottomAnchor.constraintEqualToAnchor(bottomView.topAnchor)
        let leftConstraint1 = imageView1.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint1 = imageView1.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        NSLayoutConstraint.activateConstraints([topConstraint, bottomConstraint, leftConstraint, rightConstraint])
        NSLayoutConstraint.activateConstraints([topConstraint1, bottomConstraint1, leftConstraint1, rightConstraint1])
        view.layoutIfNeeded()
        return originalImage!
        
    }
    
    func hideFiltered1() -> UIView{
        self.originalImage.removeFromSuperview()
        return imageView!
    }

    func showFiltered(){
        originalImage.alpha = 0;
        view.addSubview(originalImage)
    
        let topConstraint = originalImage.topAnchor.constraintEqualToAnchor(view.topAnchor)
        let bottomConstraint = originalImage.bottomAnchor.constraintEqualToAnchor(bottomView.topAnchor)
        let leftConstraint = originalImage.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        let rightConstraint = originalImage.rightAnchor.constraintEqualToAnchor(view.rightAnchor)
        NSLayoutConstraint.activateConstraints([topConstraint, bottomConstraint, leftConstraint, rightConstraint])
        view.layoutIfNeeded()
        
        originalImage.backgroundColor = UIColor.blackColor();
        
        UIView.animateWithDuration(1.0 , animations: { () -> Void in
            
            self.originalImage?.alpha = 1.0;
            self.imageView.alpha = 0.0;
            
            }) { (success) -> Void in
                        }

    }
    func hideFiltered(){
        
            UIView.animateWithDuration(1.0 , animations: { () -> Void in
                
                self.originalImage?.alpha = 0.0;
                self.imageView.alpha = 1.0;
                
                }) { (success) -> Void in
                  
                    self.originalImage.removeFromSuperview()

            }
         }
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        if(compareImage.selected == true){
            return originalImage
        }else{
            return imageView
        }
    }
   
    @IBAction func onTap(sender: UITapGestureRecognizer) {
       UIView.animateWithDuration(0.5) { () -> Void in
            self.scrollView.zoomScale = 1.5 * self.scrollView.zoomScale
        }
    }
    

    
}

