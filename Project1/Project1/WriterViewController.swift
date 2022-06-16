//
//  WriterViewController.swift
//  Project1
//
//  Created by admin on 6/5/22.
//

import UIKit

class WriterViewController: UIViewController, UITextViewDelegate {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var noteText: UITextView!
    public var notes = [NoteItem]()
    public var place: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = notes[place].name
        noteText.text = notes[place].noteText
        noteText.delegate = self
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        updateItem(item: notes[place], newText: textView.text)
        
    }
    
    
    @IBAction func deleteNote(_ sender: Any) {
        deleteItem(note: notes[place])
        
    }
    func updateItem(item: NoteItem, newText: String){
        item.noteText = newText
        do{
            try context.save()
           
        } catch{
            print("faield to update item")
        }
    }
    
    func deleteItem(note: NoteItem){
        context.delete(note)
        
        do{
            try context.save()
            
           
        } catch{
            print("failed to delete item")
        }
        
    }
    
}
