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
    // views design
    // scroll
    private lazy var scrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.alwaysBounceVertical = true
        return scrollView
    }()
    
    private lazy var contentView = UIView()
    // title
    private lazy var titleLabel = {
        let label = UILabel()
        label.text = ProductModel.TitleLabel.text
        label.font = ProductModel.TitleLabel.font
        label.numberOfLines = ProductModel.CommonSettings.numberOfLines
        return label
    }()
    //MARK: - BookDetailsViews
    private lazy var detailsStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = ProductModel.CommonConstraints.stackViewSpacing
        return stackView
    }()
    // cover
    private lazy var coverView = UIView()
    private lazy var coverImageView = {
        let imageView = UIImageView(image: UIImage(systemName: ProductModel.CoverImageView.imageName))
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = ProductModel.CoverImageView.borderWidth
        imageView.layer.cornerRadius = ProductModel.CommonConstraints.cornerRadius
        return imageView
    }()
    // bookInfoViews
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
        label.text = ProductModel.AuthorLabel.text
        label.font = ProductModel.CommonSettings.bookInfoTitlesFont
        return label
    }()
    
    private lazy var authorTextLabel = {
        let label = UILabel()
        label.numberOfLines = ProductModel.CommonSettings.numberOfLines
        label.text = ProductModel.AuthorTextLabel.text
        label.font = ProductModel.CommonSettings.bookInfoTextFont
        return label
    }()
    // category
    private lazy var categotyLabel = {
        let label = UILabel()
        label.text = ProductModel.CategoryLabel.text
        label.font = ProductModel.CommonSettings.bookInfoTitlesFont
        return label
    }()
    
    private lazy var categoryTextLabel = {
        let label = UILabel()
        label.text = ProductModel.CategoryTextLabel.text
        label.font = ProductModel.CommonSettings.bookInfoTextFont
        label.numberOfLines = ProductModel.CommonSettings.numberOfLines
        return label
    }()
    // rating
    private lazy var ratingLabel = {
        let label = UILabel()
        label.text = ProductModel.RatingLabel.text
        label.font = ProductModel.CommonSettings.bookInfoTitlesFont
        return label
    }()
    
    private lazy var ratingTextLabel = {
        let label = UILabel()
        label.text = ProductModel.RatingTextLabel.text
        label.font = ProductModel.CommonSettings.bookInfoTextFont
        label.numberOfLines = ProductModel.CommonSettings.numberOfLines
        return label
    }()
    //MARK: - BookInfoButtons
    private lazy var addToListButton = {
        let button = UIButton()
        button.setTitle(ProductModel.AddToListButton.text, for: .normal)
        button.setTitleColor(ProductModel.AddToListButton.textColor, for: .normal)
        button.backgroundColor = ProductModel.AddToListButton.backGroundColor
        button.layer.cornerRadius = ProductModel.AddToListButton.cornerRadius
        return button
    }()
    private lazy var readButton = {
        let button = UIButton()
        button.setTitle(ProductModel.ReadButton.text, for: .normal)
        button.setTitleColor(ProductModel.ReadButton.textColor, for: .normal)
        button.backgroundColor = ProductModel.ReadButton.backGroundColor
        button.layer.cornerRadius = ProductModel.ReadButton.cornerRadius
        return button
    }()
    //MARK: - DescriptionViews
    private lazy var descriptionLabel = {
        let label = UILabel()
        label.text = ProductModel.DesctiptionLabel.text
        label.font = ProductModel.CommonSettings.bookInfoTextFont
        return label
    }()
    
    private lazy var descriptionTextLabel = {
        let label = UILabel()
        label.text = ProductModel.DesctiptionTextLabel.text
        label.font = ProductModel.DesctiptionTextLabel.font
        label.numberOfLines = ProductModel.CommonSettings.numberOfLines
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
        // scroll
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
        // buttons
        bookInfoView.addSubview(addToListButton)
        bookInfoView.addSubview(readButton)
        // arrange common detailsStackView
        coverView.addSubview(coverImageView)
        detailsStackView.addArrangedSubview(coverView)
        detailsStackView.addArrangedSubview(bookInfoView)
        contentView.addSubview(detailsStackView)
        // bottom section
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(descriptionTextLabel)
    }
    //MARK: - Constraints
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
            make.top.equalToSuperview().offset(ProductModel.CommonConstraints.topOffset)
            make.leading.trailing.equalToSuperview().inset(ProductModel.CommonConstraints.sideInset)
        }
        // book details
        detailsStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(ProductModel.CommonConstraints.topOffset)
            make.leading.trailing.equalToSuperview().inset(ProductModel.CommonConstraints.sideInset)
        }
        // cover
        coverView.snp.makeConstraints { make in
            make.width.equalTo(detailsStackView.snp.width).multipliedBy(ProductModel.CoverImageView.Constraints.widthMultiplier)
            make.height.greaterThanOrEqualTo(coverImageView)
            make.bottom.greaterThanOrEqualTo(readButton.snp.bottom)
        }
        coverImageView.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(coverView.snp.width).multipliedBy(ProductModel.CoverImageView.Constraints.heightMultiplier)
        }
        // author
        authorLabel.snp.contentCompressionResistanceHorizontalPriority = ProductModel.CommonConstraints.horizontalPriority
        authorLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(ProductModel.CommonConstraints.topOffset)
            make.leading.equalToSuperview()
        }
        authorTextLabel.snp.makeConstraints { make in
            make.top.equalTo(authorLabel)
            make.leading.equalTo(authorLabel.snp.trailing).offset(ProductModel.CommonConstraints.bookInfoSpacing)
            make.trailing.equalToSuperview()
        }
        // category
        categotyLabel.snp.contentCompressionResistanceHorizontalPriority = ProductModel.CommonConstraints.horizontalPriority
        categotyLabel.snp.makeConstraints { make in
            make.top.equalTo(authorTextLabel.snp.bottom).offset(ProductModel.CommonConstraints.topOffset)
            make.leading.equalToSuperview()
        }
        categoryTextLabel.snp.makeConstraints { make in
            make.top.equalTo(categotyLabel)
            make.leading.equalTo(categotyLabel.snp.trailing).offset(ProductModel.CommonConstraints.bookInfoSpacing)
            make.trailing.equalToSuperview()
        }
        // rating
        ratingLabel.snp.contentCompressionResistanceHorizontalPriority = ProductModel.CommonConstraints.horizontalPriority
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(categoryTextLabel.snp.bottom).offset(ProductModel.CommonConstraints.topOffset)
            make.leading.equalToSuperview()
        }
        ratingTextLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingLabel)
            make.leading.equalTo(ratingLabel.snp.trailing).offset(ProductModel.CommonConstraints.bookInfoSpacing)
            make.trailing.equalToSuperview()
        }
        // buttons
        addToListButton.snp.makeConstraints { make in
            make.top.equalTo(ratingTextLabel.snp.bottom).offset(ProductModel.CommonConstraints.topOffset)
            make.leading.trailing.equalToSuperview().inset(ProductModel.CommonConstraints.sideInset)
            make.height.equalTo(ProductModel.AddToListButton.height)
        }
        readButton.snp.makeConstraints { make in
            make.top.equalTo(addToListButton.snp.bottom).offset(ProductModel.CommonConstraints.topOffset)
            make.leading.trailing.equalToSuperview().inset(ProductModel.CommonConstraints.sideInset)
            make.height.equalTo(ProductModel.ReadButton.height)
        }
        // bookInfo common view
        bookInfoView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(coverImageView)
            make.bottom.greaterThanOrEqualTo(readButton.snp.bottom)
        }
        // desctiption
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(detailsStackView.snp.bottom).offset(ProductModel.CommonConstraints.topOffset)
            make.leading.trailing.equalToSuperview().inset(ProductModel.CommonConstraints.sideInset)
        }
        descriptionTextLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(ProductModel.CommonConstraints.topOffset)
            make.leading.trailing.equalToSuperview().inset(ProductModel.CommonConstraints.sideInset)
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
