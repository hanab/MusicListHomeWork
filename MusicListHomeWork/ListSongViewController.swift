//
//  ViewController.swift
//  MusicListHomeWork
//
//  Created by Hana  Demas on 02/07/16.
//  Copyright © 2016 ___HANADEMAS___. All rights reserved.
//

import UIKit
//import Alamofire
//import AlamofireImage
import CoreData

//Enumrate the modes of the viewcontroller
enum VcMode {
    case allMusic, recentlyPlayed
}


class ListSongViewController: UIViewController,UITableViewDataSource, UITableViewDelegate{
    
    //MARK: Properties
    let songsDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
    var songs = Song.getSongsFromJson()
    var vcMode: VcMode = .allMusic
    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var doneBBI: UIBarButtonItem!
    @IBOutlet weak var recentBBI: UIBarButtonItem!
    
    //MARK: viewcontroller lifecycle and overridden methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.separatorColor = UIColor(red: 0, green: 1, blue: 1, alpha: 1.0)
        self.navigationController?.navigationBar.barTintColor =  UIColor(red: 0, green: 1,blue: 1, alpha: 1.0)
    }
    
    override  func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toSongDetail" {
            if let destination = segue.destinationViewController as? SongDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow {
                if(vcMode == .allMusic) {
                    destination.selectedSong = songs[indexPath.row%10]
                } else {
                    let savedSong = songsDelegate.rp[indexPath.row]
                    destination.selectedSong = Song(title: savedSong.songTitle,bandName: savedSong.bandName,description: savedSong.songDescription,songFileName: savedSong.songFileName,imageUrl: savedSong.imageUrl)
                }
                
            }
        } else if segue.identifier == "showRecents" {
            if let navController = segue.destinationViewController as? UINavigationController,
                let destination = navController.viewControllers[0] as? ListSongViewController  {
                destination.vcMode = .recentlyPlayed
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        if(vcMode == .recentlyPlayed) {
            self.navigationController?.navigationBar.barTintColor =  UIColor(red: 0, green: 1,blue: 1, alpha: 1.0)
            self.navigationItem.title = "Recently played"
            let context =  songsDelegate.managedObjectContext
            let request = NSFetchRequest(entityName: "RecentSong")
            request.returnsDistinctResults = true
            songsDelegate.rp = (try! context.executeFetchRequest(request)) as! [RecentSong]
            self.tableView.reloadData()
            
            self.navigationItem.rightBarButtonItem = nil
        } else {
            self.navigationItem.leftBarButtonItem = nil
        }
    }
    
    //MARK: IBAction
    
    @IBAction func doneButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: UITableView datasource and delegate Methods
    
    func tableView(tableView: UITableView, numberOfRowsInSection section:    Int) -> Int {
        if(vcMode == .allMusic) {
            return songs.count*100
        } else {
            return songsDelegate.rp.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell",
                                                               forIndexPath: indexPath) as! SongTableViewCell
        //populate the table cells with 10 available Song objects and repeat them ten times
        if(vcMode == .allMusic) {
            let index = indexPath.row%10
            cell.titleLabel.text = songs[index].title
            //cell.singerImageView.image = songs[index].singerPhoto
            cell.singerImageView.downloadImage(songs[index].imageUrl)
            //let downloadURL = NSURL(string:songs[index].imageUrl)!
            //cell.singerImageView.af_setImageWithURL(downloadURL)
            cell.singerImageView.layer.cornerRadius = 5
            cell.bandName.text = songs[index].bandName
        } else {
            //let index = indexPath.row%10
          //populate with recentlz played songs
            cell.titleLabel.text = songsDelegate.rp[indexPath.row].songTitle
            //cell.singerImageView.image = songs[index].singerPhoto
             cell.singerImageView.downloadImage(songsDelegate.rp[indexPath.row].imageUrl)
            //let downloadURL = NSURL(string:songsDelegate.rp[indexPath.row].imageUrl)!
            //cell.singerImageView.af_setImageWithURL(downloadURL)
            cell.singerImageView.layer.cornerRadius = 5
            cell.bandName.text = songsDelegate.rp[indexPath.row].bandName
        }
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if(vcMode == .allMusic) {
            let context =  songsDelegate.managedObjectContext
            let recentlyPlayed = NSEntityDescription.insertNewObjectForEntityForName("RecentSong",inManagedObjectContext: context) as! RecentSong
            let index = indexPath.row%10
        
            let request = NSFetchRequest(entityName: "RecentSong")
            songsDelegate.rp = (try! context.executeFetchRequest(request)) as! [RecentSong]
            recentlyPlayed.songTitle = songs[index].title
            recentlyPlayed.bandName = songs[index].bandName
            recentlyPlayed.songDescription = songs[index].description
            recentlyPlayed.imageUrl = songs[index].imageUrl
            recentlyPlayed.songFileName = songs[index].songFileName
        
            do {
                try context.save()
            } catch let saveEroor as NSError {
                print("Saving error \(saveEroor.localizedDescription)")
            }
        }
        self.performSegueWithIdentifier("toSongDetail", sender: tableView)
        self.tableView.deselectRowAtIndexPath(self.tableView.indexPathForSelectedRow!, animated: true)
    }
}

