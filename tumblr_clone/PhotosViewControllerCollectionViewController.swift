//
//  PhotosViewControllerCollectionViewController.swift
//  tumblr_clone
//
//  Created by Justin Lee on 1/31/18.
//  Copyright © 2018 Justin Lee. All rights reserved.
//

import UIKit
import AlamofireImage

private let reuseIdentifier = "Cell"


class PhotosViewControllerTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var posts: [[String: Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        pictureTableView.delegate = self
        pictureTableView.dataSource = self
        //self.tableView!.register(forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.tumblr.com/v2/blog/humansofnewyork.tumblr.com/posts/photo?api_key=Q6vHoaVm5L1u2ZAW1fqv3Jw48gFzYVg9P0vH0VHl3GVy6quoGV")!
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data,
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                print(dataDictionary)
                
                // TODO: Get the posts and store in posts property
                // Get the dictionary from the response key
                let responseDictionary = dataDictionary["response"] as! [String: Any]
                // Store the returned array of dictionaries in our posts property
                self.posts = responseDictionary["posts"] as! [[String: Any]]
                
                // TODO: Reload the table view
                  self.pictureTableView.reloadData()
            }
            
        }
        task.resume()
    
        
    }

    @IBOutlet var pictureTableView: UITableView!
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
       
        let post = posts[indexPath.row]
        if let photos = post["photos"] as? [[String:Any]]{
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String:Any]
            let urlString = originalSize["url"] as! String
            let url = URL(string: urlString)
            cell.realImageView.af_setImage(withURL: url!)
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! PhotoDetailsViewController
        let cell = sender as! UITableViewCell
        if let indexPath = pictureTableView.indexPath(for:cell){
            let post = posts[indexPath.row]
            let photos = post["photos"] as! [[String:Any]]
            let photo = photos[0]
            let originalSize = photo["original_size"] as! [String:Any]
            vc.urlString = originalSize["url"] as? String
            vc.content = post["caption"] as? String
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
 
    
    
    /*
    func tableView(tableView: UITableViewCell, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "PhotoCell") as! PhotoCell
        return cell
    }

    */

}
