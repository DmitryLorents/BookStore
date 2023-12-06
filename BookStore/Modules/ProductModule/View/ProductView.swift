//
//  ProductView.swift
//  BookStore
//
//  Created by Andrei Shpartou on 5/12/2023.
//
// try to add stackView upside UIView
//
// calculate height from screen width
// to add buttons
// to transpose Constants to Model
// to refactor code
// to pull request my file

// second stage:
// to add TabBar
//

import UIKit
import SnapKit

class ProductView: UIView {
    //MARK: - Parameters
    private enum ViewDefaults {
        enum CommonConstraints {
            static let sideInset = 15.0
            static let topOffset = 15.0
            static let stackViewSpacing = 10.0
            static let cornerRadius = 20.0
        }
        
        enum CommonSettings {
            static let numberOfLines = 0
            static let bookInfoTextFont = UIFont.boldSystemFont(ofSize: 16)
            static let bookInfoTitlesFont = UIFont.systemFont(ofSize: 15)
            static let bookInfoSpacing = 5.0
        }
        
        enum TitleLabel {
            static let text = "The Picture of Dorian Gray / Default Book Title"
            static let font = UIFont.boldSystemFont(ofSize: 20.0)
        }
        
        enum CoverImageView {
            static let imageName = "book.circle.fill"
            static let borderWidth = 2.0
                        
            enum Constraints {
                static let widthMultiplier = 0.4
                static let height = 200.0
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
            static let text = "Default category Default categoryDefault categoryDefault categoryDefault categoryDefault categoryDefault categoryDefault categoryDefault categoryDefault category"
        }
        
        enum RatingLabel {
            static let text = "Rating:"
        }
        
        enum RatingTextLabel {
            static let text = "10.0 default / 10.0 default"
        }
        
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
    
    // common constraints, insets, offsets
    private typealias CommonConstraints = ViewDefaults.CommonConstraints
    // default settings
    private typealias CommonSettings = ViewDefaults.CommonSettings
    // tittle section
    private typealias TitleLabel = ViewDefaults.TitleLabel
    // details section
    private typealias CoverImageView = ViewDefaults.CoverImageView
    // author
    private typealias AuthorLabel = ViewDefaults.AuthorLabel
    private typealias AuthorTextLabel = ViewDefaults.AuthorTextLabel
    // category
    private typealias CategoryLabel = ViewDefaults.CategoryLabel
    private typealias CategoryTextLabel = ViewDefaults.CategoryTextLabel
    // rating
    private typealias RatingLabel = ViewDefaults.RatingLabel
    private typealias RatingTextLabel = ViewDefaults.RatingTextLabel
    // description section
    private typealias DesctiptionLabel = ViewDefaults.DesctiptionLabel
    private typealias DesctiptionTextLabel = ViewDefaults.DesctiptionTextLabel
    
    //MARK: - Views
    // scroll
    private lazy var scrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private lazy var contentView = {
        let contentView = UIView()
        return contentView
    }()
    
    // title
    private lazy var titleLabel = {
        let label = UILabel()
        label.text = TitleLabel.text
        label.font = TitleLabel.font
        label.numberOfLines = CommonSettings.numberOfLines
        return label
    }()
    //MARK: - BookDetailsViews
    private lazy var detailsStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = CommonConstraints.stackViewSpacing
        return stackView
    }()
    // cover
    private lazy var coverView = {
        let view = UIView()
        return view
    }()
    private lazy var coverImageView = {
        let imageView = UIImageView(image: UIImage(systemName: CoverImageView.imageName))
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = CoverImageView.borderWidth
        imageView.layer.cornerRadius = CommonConstraints.cornerRadius
        return imageView
    }()
    // bookInfoStackView
    // bookInfo
    private lazy var bookInfoView = {
        let view = UIView()
        return view
    }()
    private lazy var bookInfoStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    // author
    private lazy var authorLabel = {
        let label = UILabel()
        label.text = AuthorLabel.text
        label.font = CommonSettings.bookInfoTitlesFont
        return label
    }()
    
    private lazy var authorTextLabel = {
        let label = UILabel()
        label.numberOfLines = CommonSettings.numberOfLines
        label.text = AuthorTextLabel.text
        label.font = CommonSettings.bookInfoTextFont
        return label
    }()
    // category
    private lazy var categotyLabel = {
        let label = UILabel()
        label.text = CategoryLabel.text
        label.font = CommonSettings.bookInfoTitlesFont
        return label
    }()
    
    private lazy var categoryTextLabel = {
        let label = UILabel()
        label.text = CategoryTextLabel.text
        label.font = CommonSettings.bookInfoTextFont
        label.numberOfLines = CommonSettings.numberOfLines
        return label
    }()
    // rating
    private lazy var ratingLabel = {
        let label = UILabel()
        label.text = RatingLabel.text
        label.font = CommonSettings.bookInfoTitlesFont
        return label
    }()
    
    private lazy var ratingTextLabel = {
        let label = UILabel()
        label.text = RatingTextLabel.text
        label.font = CommonSettings.bookInfoTextFont
        label.numberOfLines = CommonSettings.numberOfLines
        return label
    }()
    
    
    
    //MARK: - DescriptionViews
    private lazy var descriptionLabel = {
        let label = UILabel()
        label.text = DesctiptionLabel.text
        label.font = CommonSettings.bookInfoTextFont
        return label
    }()
    
    private lazy var descriptionTextLabel = {
        let label = UILabel()
        label.text = DesctiptionTextLabel.text
        label.font = DesctiptionTextLabel.font
        label.numberOfLines = CommonSettings.numberOfLines
        return label
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setHierarchy()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
            
    //MARK: - Methods
    private func setHierarchy() {
        backgroundColor = #colorLiteral(red: 0.9490135312, green: 0.949013412, blue: 0.9490135312, alpha: 1)
        
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        // title
        contentView.addSubview(titleLabel)
        // cover and book info section
        // arrange bookInfo
        // author
        bookInfoView.addSubview(authorLabel)
        bookInfoView.addSubview(authorTextLabel)
        // category
        bookInfoView.addSubview(categotyLabel)
        bookInfoView.addSubview(categoryTextLabel)
        // rating
        bookInfoView.addSubview(ratingLabel)
        bookInfoView.addSubview(ratingTextLabel)
        bookInfoStackView.addArrangedSubview(bookInfoView)
        // arrange common detailsStackView
        coverView.addSubview(coverImageView)
        detailsStackView.addArrangedSubview(coverView)
        //detailsStackView.addArrangedSubview(coverImageView)
        //detailsStackView.addArrangedSubview(bookInfoView)
        detailsStackView.addArrangedSubview(bookInfoStackView)
        contentView.addSubview(detailsStackView)
        // bottom section
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(descriptionTextLabel)
    }
    
    private func setConstraints() {
        // scroll
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.width.equalToSuperview()
        }
        // title
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CommonConstraints.topOffset)
            make.leading.trailing.equalToSuperview().inset(CommonConstraints.sideInset)
        }
        // book details
        detailsStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(CommonConstraints.topOffset)
            make.leading.trailing.equalToSuperview().inset(CommonConstraints.sideInset)
        }
        // cover
        coverView.snp.makeConstraints { make in
            make.width.equalTo(detailsStackView.snp.width).multipliedBy(CoverImageView.Constraints.widthMultiplier)
        }
        
        coverImageView.snp.makeConstraints { make in
            //make.width.equalTo(detailsStackView.snp.width).multipliedBy(CoverImageView.Constraints.widthMultiplier)
            make.width.equalToSuperview()
            make.height.equalTo(CoverImageView.Constraints.height)
        }
        // author
        authorLabel.snp.contentCompressionResistanceHorizontalPriority = 751.0
        authorLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(CommonConstraints.topOffset)
            make.leading.equalToSuperview()
        }
        authorTextLabel.snp.makeConstraints { make in
            make.top.equalTo(authorLabel)
            make.leading.equalTo(authorLabel.snp.trailing).offset(CommonSettings.bookInfoSpacing)
            make.trailing.equalToSuperview()
        }
        // category
        categotyLabel.snp.contentCompressionResistanceHorizontalPriority = 751.0
        categotyLabel.snp.makeConstraints { make in
            make.top.equalTo(authorTextLabel.snp.bottom).offset(CommonConstraints.topOffset)
            make.leading.equalToSuperview()
        }
        categoryTextLabel.snp.makeConstraints { make in
            make.top.equalTo(categotyLabel)
            make.leading.equalTo(categotyLabel.snp.trailing).offset(CommonSettings.bookInfoSpacing)
            make.trailing.equalToSuperview()
        }
        // rating
        ratingLabel.snp.contentCompressionResistanceHorizontalPriority = 751.0
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryTextLabel.snp.bottom).offset(CommonConstraints.topOffset)
            make.leading.equalToSuperview()
        }
        ratingTextLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingLabel)
            make.leading.equalTo(ratingLabel.snp.trailing).offset(CommonSettings.bookInfoSpacing)
            make.trailing.equalToSuperview()
        }
        bookInfoView.snp.makeConstraints { make in
            make.bottom.equalTo(ratingLabel.snp.bottom)
            
        }
        // desctiption
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(detailsStackView.snp.bottom).offset(CommonConstraints.topOffset)
            make.leading.trailing.equalToSuperview().inset(CommonConstraints.sideInset)
        }
        descriptionTextLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(CommonConstraints.topOffset)
            make.leading.trailing.equalToSuperview().inset(CommonConstraints.sideInset)
            make.bottom.equalTo(scrollView.snp.bottom)
        }
    }
    
}

import SwiftUI
struct MainViewPreviews: PreviewProvider {
    static var previews: some View {
        SwiftUIHelloWorldView()
    }
}
struct SwiftUIHelloWorldView: UIViewRepresentable {
    func makeUIView(context: Context) -> ProductView {
        return ProductView()
    }
    func updateUIView(_ view: ProductView, context: Context) {}
}
