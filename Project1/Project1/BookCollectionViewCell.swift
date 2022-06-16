//
//  BookCollectionViewCell.swift
//  Project1
//
//  Created by admin on 6/5/22.
//

import UIKit

class BookCollectionViewCell: UICollectionViewCell {
    static let id = "PhotoCollectionViewCell"
    public var imageName: String = "book1"
    
    private let imageView: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        
        let image = UIImage(named: imageName)
        
        imageView.image = image
    }
    
    func config(coverName: String){
        imageView.image = UIImage(named: coverName)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
}
