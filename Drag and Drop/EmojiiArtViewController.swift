//
//  EmojiiArtViewController.swift
//  Drag and Drop
//
//  Created by Admin on 05/01/2018.
//  Copyright © 2018 home. All rights reserved.
//

import UIKit

class EmojiiArtViewController: UIViewController, UIDropInteractionDelegate {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    {
        didSet
        {
            
            activityIndicator.stopAnimating()
            activityIndicator.hidesWhenStopped = true
            
        }
    }
    
    
    @IBOutlet weak var dropZone: UIView!
    {
        didSet
        {
            dropZone.addInteraction(UIDropInteraction(delegate:self))
            
            
        }
    }
    
    func dropInteraction(_ interaction: UIDropInteraction, canHandle session: UIDropSession) -> Bool {
        

        return session.canLoadObjects(ofClass: NSURL.self) && session.canLoadObjects(ofClass: UIImage.self)
       
        //poate sa faca drop doar la ceva care e URL si care e si Image
        
    }
    
    
    func dropInteraction(_ interaction: UIDropInteraction, sessionDidUpdate session: UIDropSession) -> UIDropProposal {
       
       
        
        return UIDropProposal(operation: .copy)
        
        //copieaza imagini in drop zone
        
    }
    
    var imageFetcher: ImageFetcher!
    
    
    func dropInteraction(_ interaction: UIDropInteraction, performDrop session: UIDropSession) {
        
        print("starteddd")
        self.activityIndicator.startAnimating()
        
        imageFetcher = ImageFetcher()
            {
                (url, image) in
                DispatchQueue.main.async {
                   
                    self.emojiArtView.backgroundImage = image
                    self.activityIndicator.stopAnimating()

                }
        }
        
        session.loadObjects(ofClass: NSURL.self) { (nsurls) in
            
            if let url = nsurls.first as? URL
            {
           
            self.imageFetcher.fetch(url)
            }
        }
        session.loadObjects(ofClass: UIImage.self) { (images) in
            
            if let image = images.first as? UIImage
            {
            self.imageFetcher.backup = image
               
            }
         
        }
        
        //perform drop, i want the data give it to me and call the completion
    }
    
    
    @IBOutlet weak var emojiArtView: EmojiiArtView!
    
    

}
