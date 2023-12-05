//
//  ProductView.swift
//  BookStore
//
//  Created by Andrei Shpartou on 5/12/2023.
//

import UIKit
import SnapKit

class ProductView: UIView {
    //MARK: - Parameters
    private enum ViewDefaults {
        enum CommonConstraints {
            static let sideInset = 15.0
            static let topOffset = 20.0
            static let stackViewSpacing = 10.0
            static let cornerRadius = 20.0
        }
        
        enum TitleLabel {
            static let text = "The Picture of Dorian Gray or The magic fabulous non-predictable story"
            static let numberOfLines = 0
            static let font = UIFont.boldSystemFont(ofSize: 20.0)
            
            enum Constraints {
                static let topOffset = 80.0
            }
        }
//        enum DetailsStackView {
//            static let spacing = 20.0
//        }
        
        enum CoverImageView {
            static let imageName = "book.circle.fill"
            static let borderWidth = 2.0
                        
            enum Constraints {
                static let widthMultiplier = 0.4
                static let height = 200.0
            }
        }
        
        enum AuthorLabel {
            static let text = "Author: "
        }
        
        enum DesctiptionLabel {
            static let text = "Description:"
            static let font = UIFont.boldSystemFont(ofSize: 17.0)
        }
        
        enum DesctiptionTextLabel {
            static let text = """
            Oscar Wilde’s only novel is the dreamlike story of a young man who sells his soul for eternal youth and beauty. In this celebrated work Wilde forged a devastating portrait of the effects of evil and debauchery on a young aesthete in late-19th-century England. Combining elements of the Gothic horror novel and decadent French fiction, the book centers on a striking premise: As Dorian Gray sinks into a life of crime and gross sensuality, his body retains perfect youth and vigor while his recently painted portrait grows day by day into a hideous record of evil, which he must keep hidden from the world. For over a century, this mesmerizing tale of horror and suspense has enjoyed wide popularity. It ranks as one of Wilde's most important creations and among the classic achievements of its kind.
            """
            static let numberOfLines = 0
            static let font = UIFont.systemFont(ofSize: 16.0)
            
//            enum Constraints {
//                static let bottomInset = 50.0
//            }
        }
        
//        "Oscar Wilde’s only novel is the dreamlike story of a young man who sells his soul for eternal youth and beauty. In this celebrated work Wilde forged a devastating portrait of the effects of evil and debauchery on a young aesthete in late-19th-century"
    }
    
    private typealias CommonConstraints = ViewDefaults.CommonConstraints
    // tittle section
    private typealias TitleLabel = ViewDefaults.TitleLabel
    // details section
    private typealias CoverImageView = ViewDefaults.CoverImageView
    private typealias AuthorLabel = ViewDefaults.AuthorLabel
    // description section
    private typealias DesctiptionLabel = ViewDefaults.DesctiptionLabel
    private typealias DesctiptionTextLabel = ViewDefaults.DesctiptionTextLabel
    
    
    //MARK: - Views
    // scroll
    private lazy var scrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        //scrollView.alwaysBounceVertical = true
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
        label.numberOfLines = TitleLabel.numberOfLines
        return label
    }()
    //MARK: - BookDetailsViews
    private lazy var detailsStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = CommonConstraints.stackViewSpacing
        //stackView.alignment = .fill
        //stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var coverImageView = {
        let imageView = UIImageView(image: UIImage(systemName: CoverImageView.imageName))
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = CoverImageView.borderWidth
        imageView.layer.cornerRadius = CommonConstraints.cornerRadius
        return imageView
    }()
    
    private lazy var bookInfoView = {
        let view = UIView()
        return view
    }()
    
    private lazy var bookInfoStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.spacing = CommonConstraints.stackViewSpacing
        return stackView
    }()
    
    private lazy var authorLabel = {
        let label = UILabel()
        label.text = AuthorLabel.text
        return label
    }()
    
    private lazy var authorDescriptionLabel = {
        let label = UILabel()
        //label.text = "Long long text with many many strings"
        return label
    }()
    
    //MARK: - DescriptionViews
    private lazy var descriptionLabel = {
        let label = UILabel()
        label.text = DesctiptionLabel.text
        label.font = DesctiptionLabel.font
        return label
    }()
    
    private lazy var descriptionTextLabel = {
        let label = UILabel()
        label.text = DesctiptionTextLabel.text
        label.font = DesctiptionTextLabel.font
        label.numberOfLines = DesctiptionTextLabel.numberOfLines
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
        
        
        
        addSubview(titleLabel)
        //arrange bookStackView
        bookInfoStackView.addArrangedSubview(authorLabel)
        bookInfoView.addSubview(bookInfoStackView)
        // arrange common detailsStackView
        detailsStackView.addArrangedSubview(coverImageView)
        detailsStackView.addArrangedSubview(bookInfoView)
        // continue arrange self view
        addSubview(detailsStackView)
        addSubview(descriptionLabel)
        addSubview(descriptionTextLabel)
        
    }
    
    private func setConstraints() {
        // scroll
        scrollView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.width.height.equalTo(safeAreaLayoutGuide)
        }
        contentView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.width.height.equalTo(scrollView)
        }
        // title
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(TitleLabel.Constraints.topOffset)
            make.leading.trailing.equalToSuperview().inset(CommonConstraints.sideInset)
        }
        // book details
        detailsStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(CommonConstraints.topOffset)
            make.leading.trailing.equalToSuperview().inset(CommonConstraints.sideInset)
        }
        
        coverImageView.snp.makeConstraints { make in
            make.width.equalTo(detailsStackView.snp.width).multipliedBy(CoverImageView.Constraints.widthMultiplier)
            make.height.equalTo(CoverImageView.Constraints.height)
        }
        
        bookInfoStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(CommonConstraints.topOffset)
            make.leading.equalToSuperview()
        }
        // desctiption
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(detailsStackView.snp.bottom).offset(CommonConstraints.topOffset)
            make.leading.trailing.equalToSuperview().inset(CommonConstraints.sideInset)
        }
        
        descriptionTextLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(CommonConstraints.topOffset)
            make.leading.trailing.equalToSuperview().inset(CommonConstraints.sideInset)
            //make.bottom.equalToSuperview().inset(DesctiptionTextLabel.Constraints.bottomInset)
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
