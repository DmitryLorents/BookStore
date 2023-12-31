//
//  5View.swift
//  RainbowApp
//
//  Created by Dmitry on 09.11.2023.
//

import UIKit

class WelcomeView: UIView {
    
    //MARK: - Parameters
    
    private lazy var fullStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fillEqually
        stack.spacing = 20
        stack.alignment = .fill
        [stackView1,stackView2,stackView3].forEach {
            stack.addArrangedSubview($0)
        }
        stack.rotate(angle: 345)
        
        return stack
    }()
    
    private lazy var stackView1: UIStackView = {
        let stack = createStackView()
        
        for cover in welcomeCovers.shuffled()[0...8]{
            stack.addArrangedSubview(createCoverImage(named: cover))
        }
        return stack
    }()
    
    private lazy var stackView2: UIStackView = {
        let stack = createStackView()
        for cover in welcomeCovers.shuffled()[0...8]{
            stack.addArrangedSubview(createCoverImage(named: cover))
        }
        return stack
    }()
    
    private lazy var stackView3: UIStackView = {
        let stack = createStackView()
        for cover in welcomeCovers.shuffled()[0...8] {
            stack.addArrangedSubview(createCoverImage(named: cover))
        }
        return stack
    }()
    
    private lazy var logoImage: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 136, height: 136))
        imageView.image = UIImage(named: "welcomeLogo")
        return imageView
    }()
    
    private lazy var paragraphStyle: NSMutableParagraphStyle = {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 1.29
        return paragraphStyle
    }()
    
    private lazy var labelWithText: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14)
        label.lineBreakMode = .byWordWrapping
        label.attributedText = NSMutableAttributedString(string: "Read more and stress less with our online book \nshopping app. Shop from anywhere you are and \ndiscover titles that you love. Happy reading!", attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        label.textAlignment = .center
        return label
    }()
    
    //MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Methods
    private func createStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.spacing = 40
        return stackView
    }
    
    private func createCoverImage(named: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: named)
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }
    
    private func setupConstraints() {
        
        fullStack.snp.makeConstraints{ make in
            make.top.equalToSuperview().offset(-100)
            make.leading.equalToSuperview().offset(-60)
            make.width.equalToSuperview().multipliedBy(3)
            make.height.equalToSuperview().dividedBy(2.1)
        }
        
        logoImage.snp.makeConstraints{ make in
            make.top.equalTo(fullStack.snp.bottom).inset(-100)
            make.centerX.equalToSuperview()
        }
        
        labelWithText.snp.makeConstraints{ make in
            make.top.equalTo(logoImage.snp.bottom).offset(50)
            make.centerX.equalToSuperview()
        }
       
    }
    
    private func setupView() {
        addSubview(fullStack)
        addSubview(logoImage)
        addSubview(labelWithText)
        backgroundColor = .systemBackground
    }
    
    public func setupViewWithTextAndImage(text: String, image: UIImage, isCoversHiden: Bool = false) {
        isCoversHiden ? fullStack.removeFromSuperview() : print("its covers!!!!")
        logoImage.image = image
        labelWithText.attributedText = NSMutableAttributedString(string: text, attributes: [NSAttributedString.Key.kern: -0.41, NSAttributedString.Key.paragraphStyle: paragraphStyle])
        labelWithText.textAlignment = .center
    }
}
