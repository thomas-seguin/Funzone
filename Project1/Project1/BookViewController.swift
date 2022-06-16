//
//  BookViewController.swift
//  Project1
//
//  Created by admin on 6/5/22.
//

import UIKit

class BookViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private var books = [BookItem]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        getallItems()
        collectionView.register(BookCollectionViewCell.self, forCellWithReuseIdentifier: BookCollectionViewCell.id)
        collectionView.dataSource = self
        collectionView.delegate = self
        

        
    }
   
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let book = books[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BookCollectionViewCell.id, for: indexPath) as! BookCollectionViewCell
        
        cell.config(coverName: book.coverName!)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.size.width/3)-3, height: (view.frame.size.width/3)-3)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 1, bottom: 5, right: 1)
    }
    
   
    
    
    
   
    
 
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "reader") as? PDFViewController else {
            return
        }
        
        vc.bookName = "Lorem_ipsum"
        
        present(vc, animated: true)
      
    }
    
    
    func getallItems(){
        do{
            
        books = try context.fetch(BookItem.fetchRequest())
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } catch{
            print("failed to get items")
        }
        
        
    }
    func createItem(coverName: String, pdfName: String){
        let newBook = BookItem(context: context)
        newBook.coverName = coverName
        newBook.pdfName = pdfName
        
        do{
            try context.save()
            getallItems()
            
        }catch {
            print("failed to create item")
        }
        
    }
    
    func deleteItem(book: BookItem){
        context.delete(book)
        
        do{
            try context.save()
            getallItems()
        } catch{
            print("failed to delete item")
        }
        
    }
    
   

}
