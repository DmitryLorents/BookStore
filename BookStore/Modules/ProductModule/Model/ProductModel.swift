//
//  ProductModel.swift
//  BookStore
//
//  Created by Andrei Shpartou on 5/12/2023.
//

import UIKit

struct ProductModel {
    
    enum CommonConstraints {
        static let sideInset = 15.0
        static let topOffset = 15.0
        static let stackViewSpacing = 10.0
        static let cornerRadius = 20.0
        static let bookInfoSpacing = 5.0
        static let horizontalPriority: Float = 751.0
    }
    
    enum CommonSettings {
        static let numberOfLines = 0
        static let bookInfoTextFont = UIFont.boldSystemFont(ofSize: 15)
        static let bookInfoTitlesFont = UIFont.systemFont(ofSize: 15)
    }
    //MARK: - Title
    enum TitleLabel {
        static let text = "The Picture of Dorian Gray / Default Book Title"
        static let font = UIFont.boldSystemFont(ofSize: 20.0)
    }
    //MARK: - Book Cover and Details
    enum CoverImageView {
        static let imageName = "book.circle.fill"
        static let borderWidth = 2.0
        
        enum Constraints {
            static let widthMultiplier = 0.4
            static let heightMultiplier = 1.5
        }
    }
    
    enum AuthorLabel {
        static let text = "Author:"
    }
    
    enum AuthorTextLabel {
        static let text = "Name Surname"
    }
    
    enum CategoryLabel {
        static let text = "Category:"
    }
    
    enum CategoryTextLabel {
        static let text = "Default Category"
    }
    
    enum RatingLabel {
        static let text = "Rating:"
    }
    
    enum RatingTextLabel {
        static let text = "10.0 default"
    }
    //-MARK: Book Details Buttons
    enum AddToListButton {
        static let text = "Add to list"
        static let backGroundColor = UIColor.systemGray2
        static let textColor = UIColor.black
        static let cornerRadius = 10.0
        static let height = 40.0
    }
    
    enum ReadButton {
        static let text = "Read"
        static let backGroundColor = UIColor.black
        static let textColor = UIColor.white
        static let cornerRadius = 10.0
        static let height = 40.0
    }
    //-MARK: Book Desctiption
    enum DesctiptionLabel {
        static let text = "Description:"
    }
    enum DesctiptionTextLabel {
        static let text = """
            Default Book Description: Oscar Wilde’s only novel is the dreamlike story of a young man who sells his soul for eternal youth and beauty. In this celebrated work Wilde forged a devastating portrait of the effects of evil and debauchery on a young aesthete in late-19th-century England. Combining elements of the Gothic horror novel and decadent French fiction, the book centers on a striking premise: As Dorian Gray sinks into a life of crime and gross sensuality, his body retains perfect youth and vigor while his recently painted portrait grows day by day into a hideous record of evil, which he must keep hidden from the world. For over a century, this mesmerizing tale of horror and suspense has enjoyed wide popularity. It ranks as one of Wilde's most important creations and among the classic achievements of its kind.
            """
        static let font = UIFont.systemFont(ofSize: 15.0)
    }
}



