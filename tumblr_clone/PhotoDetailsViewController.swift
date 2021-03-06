//
//  PhotoDetailsViewController.swift
//  tumblr_clone
//
//  Created by Justin Lee on 2/7/18.
//  Copyright © 2018 Justin Lee. All rights reserved.
//

import UIKit

class PhotoDetailsViewController: UIViewController {
    
    @IBOutlet weak var photo_imageView: UIImageView!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    var urlString: String?
    var content: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: urlString!)
        photo_imageView.af_setImage(withURL: url!)
        let content = self.content?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        print(content ?? "no content")
        contentLabel.text = content
        

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTap(_ sender: Any) {
        performSegue(withIdentifier: "modal", sender: nil)
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! ZoomViewController
        vc.urlString = urlString! as String
        
        
    }
    


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
