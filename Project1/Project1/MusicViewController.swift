//
//  MusicViewController.swift
//  Project1
//
//  Created by admin on 6/3/22.
//

import UIKit

class MusicViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private var songs = [MusicItem]()
    
    @IBOutlet var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        getallItems()
        

        // Do any additional setup after loading the view.
    }
    
    func configureSongs(){
        createItem(name: "Background music",
                   albumName: "123 Something",
                   artistName: "Meme",
                   imageName: "cover1",
                   trackName: "song1")
        createItem(name: "Viva la vida",
                   albumName: "12 Something",
                   artistName: "Coldplay",
                   imageName: "cover3",
                   trackName: "song3")
        createItem(name: "Havana",
                   albumName: "126 Something",
                   artistName: "Camila",
                   imageName: "cover2",
                   trackName: "song2")
                }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let song = songs[indexPath.row]
        cell.backgroundColor = .black
        cell.textLabel?.text = song.name
        cell.textLabel?.backgroundColor = .black
        cell.textLabel?.textColor = .white
        cell.detailTextLabel?.text = song.albumName
        cell.detailTextLabel?.textColor = .white
        cell.accessoryType = .disclosureIndicator
        cell.imageView?.image = UIImage(named: song.imageName!)
        cell.textLabel?.font = UIFont(name: "Helvetica-Bold", size: 18)
        cell.detailTextLabel?.font = UIFont(name: "Helvetica", size: 17)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        //present player
        let position = indexPath.row
        //songs
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "player") as? PlayerViewController else {
            return
        }
        
        vc.songs = songs
        vc.position = position
        
        present(vc, animated: true)
    }
    

    func getallItems(){
        do{
            
        songs = try context.fetch(MusicItem.fetchRequest())
            DispatchQueue.main.async {
                self.table.reloadData()
            }
        } catch{
            print("failed to get items")
        }
        
        
    }
    func createItem(name: String, albumName: String, artistName: String, imageName: String, trackName: String){
        let newSong = MusicItem(context: context)
        newSong.name = name
        newSong.imageName = imageName
        newSong.albumName = albumName
        newSong.artistName = artistName
        newSong.tackName = trackName
        
        do{
            try context.save()
            getallItems()
            
        }catch {
            print("failed to create item")
        }
        
    }
    
    func deleteItem(song: MusicItem){
        context.delete(song)
        
        do{
            try context.save()
            getallItems()
        } catch{
            print("failed to delete item")
        }
        
    }}


