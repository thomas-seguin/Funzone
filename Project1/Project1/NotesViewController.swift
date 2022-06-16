//
//  NotesViewController.swift
//  Project1
//
//  Created by admin on 6/5/22.
//

import UIKit

class NotesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var notes = [NoteItem]()
    
    let tableView: UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
        
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        getallItems()
        title = "My Notes"
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.frame = view.bounds
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
        navigationItem.rightBarButtonItem?.tintColor = .green
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getallItems()
    }
    
    @objc private func didTapAdd(){
        let alert = UIAlertController(title: "New Item", message: "Enter new item", preferredStyle: .alert)
        alert.addTextField(configurationHandler: nil)
        alert.addAction(UIAlertAction(title: "Submit", style: .cancel, handler: { [weak self] _ in guard let field = alert.textFields?.first, let text = field.text, !text.isEmpty else{
            return
        }
            self?.createItem(name: text)
        }))
        present(alert, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let note = notes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = note.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "writer") as? WriterViewController else {
            return
        }
        vc.place = indexPath.row
        vc.notes = notes
        tableView.deselectRow(at: indexPath, animated: true)
        present(vc,animated: true)
        
      
    }
    
    
    
    func getallItems(){
        do{
            
        notes = try context.fetch(NoteItem.fetchRequest())
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch{
            print("failed to get items")
        }
        
        
    }
    func createItem(name: String){
        let newNote = NoteItem(context: context)
        newNote.createdAt = Date()
        newNote.name = name
        
        do{
            try context.save()
            getallItems()
            
        }catch {
            print("failed to create item")
        }
        
    }
    
    func deleteItem(note: NoteItem){
        context.delete(note)
        
        do{
            try context.save()
            getallItems()
        } catch{
            print("failed to delete item")
        }
        
    }
    
    func updateItem(item: NoteItem, newName: String){
        item.name = newName
        do{
            try context.save()
            getallItems()
        } catch{
            print("faield to update item")
        }
    }
}
