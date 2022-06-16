//
//  PlayerViewController.swift
//  Project1
//
//  Created by admin on 6/3/22.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    
    public var position: Int = 0
    public var songs = [MusicItem]()
    
    @IBOutlet var holder: UIView!
    
    var player: AVAudioPlayer?
    
    //UI ELements
    
    private let albumImageVIew: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let songNameLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let artistLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let albumLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let playPauseButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if holder.subviews.count == 0{
            configure()
        }
    }
    
    func configure(){
        //set up player
        
        let song = songs[position]
        
        let urlString = Bundle.main.path(forResource: song.tackName, ofType: "mp3")
        
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = urlString else {
                return
            }
            
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            
            guard let player = player else {
                return
            }
            
            player.volume = 0.5
            
            player.play()
            
            

        } catch{
            print("error occured")
        }
        
        //set up ui elements
        
        //album cover
        albumImageVIew.frame = CGRect(x: 10, y: 10, width: holder.frame.size.width-20, height: holder.frame.size.width-20)
        
        albumImageVIew.image = UIImage(named: song.imageName!)
        holder.addSubview(albumImageVIew)
        
        //Labels: Song name, album, artist
        songNameLabel.frame = CGRect(x: 10, y: albumImageVIew.frame.size.height + 10, width: holder.frame.size.width-20, height: 70)
        albumLabel.frame = CGRect(x: 10, y:albumImageVIew.frame.size.height + 10 + 70 , width: holder.frame.size.width-20, height: 70)
        artistLabel.frame = CGRect(x: 10, y: albumImageVIew.frame.size.height + 10 + 70 + 70, width: holder.frame.size.width-20, height: 70)
        
        songNameLabel.text = song.name
        albumLabel.text = song.albumName
        artistLabel.text = song.artistName
        
        
        holder.addSubview(songNameLabel)
        holder.addSubview(albumLabel)
        holder.addSubview(artistLabel)
        
        //PlayerControls
        
        let nextButton = UIButton()
        let backButton = UIButton()
        
        //Frame
        let yPosition = artistLabel.frame.origin.y + 70 + 20
        let size: CGFloat = 70
        
        playPauseButton.frame = CGRect(x: (holder.frame.size.width - size)/2.0, y: yPosition, width: size, height: size)
        nextButton.frame = CGRect(x: (holder.frame.size.width) - size - 20, y: yPosition, width: size, height: size)
        backButton.frame = CGRect(x: 20, y: yPosition, width: size, height: size)

        
        
        
        //Add Actions
        
        playPauseButton.addTarget(self, action: #selector(didtapPlayPauseButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didtapNextButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didtapBackButton), for: .touchUpInside)
        
        //Button Images
        playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        backButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        nextButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        
        playPauseButton.tintColor = .black
        backButton.tintColor = .black
        nextButton.tintColor = .black
        
        
        
        holder.addSubview(playPauseButton)
        holder.addSubview(nextButton)
        holder.addSubview(backButton)
        
        //slider
        let slider = UISlider(frame: CGRect(x: 20, y: holder.frame.size.height-60, width: holder.frame.size.width-40, height: 50))
        
        
        slider.value = 0.5
        slider.addTarget(self, action: #selector(didSlideSlider(_:)), for: .valueChanged)
        holder.addSubview(slider)
        
        
        
        
    }
    
    @objc func didtapBackButton(){
        print("back")
        if position > 0 {
            position = position - 1
            player?.stop()
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
        
    }
    
    @objc func didtapNextButton(){
        print("next")
        if position < (songs.count - 1) {
            position = position + 1
            player?.stop()
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
        
    }
    
    @objc func didtapPlayPauseButton(){
        
        if player?.isPlaying == true{
            print("pause")
            //pause
            player?.pause()
            //show play button
            playPauseButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            
            //shrink image
            UIView.animate(withDuration: 0.2, animations: {
                self.albumImageVIew.frame = CGRect(x: 30, y: 30, width: self.holder.frame.size.width-60, height: self.holder.frame.size.width-60)
            })
            
        } else {
            print("play")
            //play
            player?.play()
            playPauseButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            
            //increase image size
            UIView.animate(withDuration: 0.2, animations: {
                self.albumImageVIew.frame = CGRect(x: 10, y: 10, width: self.holder.frame.size.width-20, height: self.holder.frame.size.width-20)
            })
        }
    }

    @objc func didSlideSlider(_ slider: UISlider){
        print("volume change")
        let value = slider.value
        player?.volume = value
        //adjust player volume
    }
    
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let player = player {
            player.stop()
        }
    }

}
