//
//  PhotosViewController.swift
//  JsonPlaceholder
//
//  Created by apple on 18.01.2020.
//  Copyright © 2020 Mustafa KILINÇ. All rights reserved.
//

import UIKit

extension UIImageView{
    
    func downloadedFrom(url : URL, contentMode mode : UIView.ContentMode = .scaleAspectFit){
        
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            
            DispatchQueue.main.async {
                self.image = image
            }
            
            
        }.resume()
    }
}

struct Photo : Decodable{
    
    let albumId : Int
    let id : Int
    let title : String
    let imgUrl : String
    let thumbnailUrl : String
}

class PhotosViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
   
    

    var photos = [Photo]()
    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedAlbumName : String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(selectedAlbumName)

        collectionView.dataSource = self
        collectionView.delegate = self
        
        getData()
        
    }
    
    func getData(){
        
        // 1-) Request & Session
        // 2-) Response & Data
        // 3-) Parsin & Json Serialization
        
        
        let url = URL(string: "https://jsonplaceholder.typicode.com/photos")
        let session = URLSession.shared
        
        //closure
        let task = session.dataTask(with: url!) { (data, response, error) in
            
            if error != nil{
                
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okButton)
                self.present(alert, animated: true, completion: nil)
                
            }else{
                
                if data != nil{
                    
                    do{
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) 
                        
                        DispatchQueue.main.async {
                            
                           
                            self.collectionView.reloadData()
                            print(jsonResponse)
                        }
                    }catch{
                        print("error")
                    }
                    
                }
                
            }
        }
        
        task.resume()

    
    }
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        
        let numberOfColumns : CGFloat = 2
        let width = collectionView.frame.size.width
        let xInsets : CGFloat = 10
        let cellSpacing : CGFloat = 5
        
        
        return CGSize(width: (width / numberOfColumns) - (xInsets - cellSpacing), height: (width / numberOfColumns) - (xInsets - cellSpacing))
    }
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
    return photos.count
    
      }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = (collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell)!
        
         cell.lblPhotoTitle.text = photos[indexPath.row].title.capitalized
        
        cell.imgPhoto.contentMode = .scaleAspectFill
        var completeLink = photos[indexPath.row].imgUrl
        
        
        return cell
        
    }
    

}
