//
//  SongDetailViewController.swift
//  MusicListHomeWork
//
//  Created by Hana  Demas on 03/07/16.
//  Copyright © 2016 ___HANADEMAS___. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation
//import Alamofire
//import AlamofireImage


class SongDetailViewController: UIViewController {
    
    //MARK: Properties
    @IBOutlet var toolBar: UIToolbar!
    @IBOutlet var playStopButtonOutlet: UIBarButtonItem!
    @IBOutlet var singerImageImageView: UIImageView!
    @IBOutlet var songTitleLabel: UILabel!
    @IBOutlet var bandNameLabel: UILabel!
    @IBOutlet var songDescriptionTextView: UITextView!
    @IBOutlet var sliderValue: UISlider!
    //non-outlet properties
    var selectedSong:Song!
    var player:AVAudioPlayer = AVAudioPlayer()
    
    //MARK:life cycle methods of viewcontroller
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        songTitleLabel.text = selectedSong.title
        bandNameLabel.text = selectedSong.bandName
        //singerImageImageView.image = selectedSong.singerPhoto
        singerImageImageView.downloadImage(selectedSong.imageUrl)
        //let downloadURL = NSURL(string:selectedSong.imageUrl)!
        //singerImageImageView.af_setImageWithURL(downloadURL)
        songDescriptionTextView.text = selectedSong.description
        
        let filePath = NSBundle.mainBundle().pathForResource(selectedSong.songFileName, ofType: "mp3")
        
        if let filePath = filePath {
            let filePathUrl = NSURL(fileURLWithPath: filePath)
            
            do {
                try player = AVAudioPlayer(contentsOfURL: filePathUrl)
                player.play()
            } catch {
                print("error")
            }
        }
    }
    
    //MARK: Actions methods for UIKit elements
    
    //pauses the music to the time it was stoped
    @IBAction func pauseButtonAction(sender: AnyObject) {
        player.pause()
    }
    
    //this method allows playing and stoping the music using one button
    @IBAction func playStopButtonAction(sender: AnyObject) {
        if player.playing {
            player.stop()
            player.currentTime = 0
            playStopButtonOutlet = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Play, target: self, action: #selector(SongDetailViewController.playStopButtonAction(_:)))
            toolBar.items![4] = playStopButtonOutlet
        } else {
            player.play()
            playStopButtonOutlet = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Stop, target: self, action: #selector(SongDetailViewController.playStopButtonAction(_:)))
            toolBar.items![4] = playStopButtonOutlet
        }
    }
    
    // adjusts the volume of the song
    @IBAction func sliderValueChanged(sender: AnyObject) {
        player.volume = sliderValue.value
    }
}
