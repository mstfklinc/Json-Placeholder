//
//  ViewController.swift
//  JsonPlaceholder
//
//  Created by apple on 18.01.2020.
//  Copyright © 2020 Mustafa KILINÇ. All rights reserved.
//

import UIKit

struct Album : Decodable{
    
    let userId: Int
    let id : Int
    let title : String
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    
    @IBOutlet weak var tableView: UITableView!
    var selectedCategoryName : String = ""
    var albums = [Album]()
    var nameArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        tableView.delegate = self
        getData()
        
    }
    
     func getData(){
               
               let url = URL(string: "https://jsonplaceholder.typicode.com/albums")
                      URLSession.shared.dataTask(with: url!) { (data, response, error) in
                          
                          if error == nil{
                              
                              do{
                                  self.albums = try JSONDecoder().decode([Album].self, from: data!)
                              }catch{
                                  print("parse error!!!")
                              }
                              
                              DispatchQueue.main.async {
                                  self.tableView.reloadData()
                              }
                              
                          }
                      }.resume()
           }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return albums.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.textLabel?.text = albums[indexPath.row].title.capitalized
        return cell
        
       }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        selectedCategoryName = albums[indexPath.row].title.capitalized
        performSegue(withIdentifier: "toAlbumDetails", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let photoList = segue.destination as? PhotosViewController{
            photoList.selectedAlbumName = selectedCategoryName
        }
        
        
    }
    
   
    
    


}

