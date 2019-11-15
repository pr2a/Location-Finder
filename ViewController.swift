//
//  ViewController.swift
//  lab6
//
//  Created by Priya Ganguly on 11/10/19.
//  Copyright © 2019 idk. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var myPlaceList:places = places()

    @IBOutlet weak var placeTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        placeTable.rowHeight = 100.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //returns number of places
        return myPlaceList.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath) as! PlaceTableViewCell
        cell.layer.borderWidth = 1.0
        
        let placeItem = myPlaceList.getPlaceObject(item: indexPath.row)
        
        //adds place name in TableViewCell
        cell.placeTitle.text = placeItem.placeName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell.EditingStyle {
        return UITableViewCell.EditingStyle.delete  
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {

        myPlaceList.removePlaceObject(item: indexPath.row)
        
        self.placeTable.beginUpdates()
        self.placeTable.deleteRows(at: [indexPath], with: .automatic)
        self.placeTable.endUpdates()
        
    }
    
    @IBAction func add(_ sender: Any) {
        //creates an alert view asking the user to add a new place
        let alert = UIAlertController(title: "Add Place", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

            alert.addTextField(configurationHandler: {
                textField in textField.placeholder = "Enter the name of the new place"
            })

            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: {
                action in

                 if let name = alert.textFields?.first?.text {
                       print("place name: \(name)")
                     
                       //adds new place to array
                       self.myPlaceList.addPlaceObject(name: name, image: "place.jpg")

                       let indexPath = IndexPath (row: self.myPlaceList.getCount() - 1, section: 0)
                       self.placeTable.beginUpdates()
                       self.placeTable.insertRows(at: [indexPath], with: .automatic)
                       self.placeTable.endUpdates()
                   }
               }))

               self.present(alert, animated: true)
    }
    
    //sends place name to DetailViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let selectedIndex: IndexPath = self.placeTable.indexPath(for: sender as! UITableViewCell)!
        
        let place = myPlaceList.getPlaceObject(item: selectedIndex.row)
        
        let destination = segue.destination as? DetailViewController
        destination!.selectedPlace = place
    }
    
}

