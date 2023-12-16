//
//  5ViewController.swift
//  RainbowApp
//
//  Created by Nikolay1414 on 09.11.2023.
//

import UIKit
import SnapKit

class WelcomeViewController: UIViewController, UIScrollViewDelegate {
    
    //    //MARK: - Parameters
    var firstScreen = WelcomeView()
    var secondScreen = WelcomeView()
    var thirdScreen = WelcomeView()
    
    var screens = [UIView]()
    
    private lazy var getStartedButton: UIButton = {
        let button = UIButton()
        button.setTitle("Get Started", for: .normal)
        button.backgroundColor = UIColor(named: "welcomeButtonColor")
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.titleLabel?.textColor = UIColor(named: "welcomeBackgroundColor")
        button.addTarget(self, action: #selector(getStartedButtonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        
        
        return button
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.contentInsetAdjustmentBehavior = .scrollableAxes
        return scrollView
    }()
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = 3
//        pageControl.preferredIndicatorImage = UIImage(named: "pageActiveIndicator")
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .black
        pageControl.addTarget(self, action: #selector(pageControlIndicatorTapped), for: .valueChanged)
        return pageControl
    }()
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
        setDelegates()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        screens = createScreens()
        setupSlidesScrollView(slides: screens)
    }
    
    private func setupView() {
        view.addSubview(scrollView)
        view.addSubview(pageControl)
        view.addSubview(getStartedButton)
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
//            make.bottom.equalToSuperview().offset(-100)
        }
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-150)
            make.leading.equalTo(view).offset(30)
            make.trailing.equalTo(view).offset(-30)
            make.height.equalTo(50)
        }
        
        getStartedButton.snp.makeConstraints{ make in
            make.height.equalTo(56)
            make.bottom.equalToSuperview().offset(-80)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    private func setupSlidesScrollView(slides: [UIView]) {
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(slides.count),
                                        height: view.frame.height)
        
        for i in 0..<slides.count {
            slides[i].frame = CGRect(x: view.frame.width * CGFloat(i),
                                     y: 0,
                                     width: view.frame.width,
                                     height: view.frame.height)
            scrollView.addSubview(slides[i])
        }
    }
    private func createScreens() -> [WelcomeView] {
        secondScreen.setupViewWithTextAndImage(
            text: "Search throu over a million books in our catalog. \nRead the most pupular books rated by other readers. ",
            image: UIImage(systemName: "books.vertical", withConfiguration: UIImage.SymbolConfiguration(pointSize: 100, weight: .thin))!.withTintColor(.black, renderingMode: .alwaysOriginal))
        thirdScreen.setupViewWithTextAndImage(
            text: "Save your favorite books to your own lists to read them \nlater and not to lose them. Have fun. \nRead More!",
            image: UIImage(systemName: "heart.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 100, weight: .thin))!.withTintColor(.black, renderingMode: .alwaysOriginal))
        return [firstScreen,secondScreen,thirdScreen]
    }
    
    private func setDelegates() {
        scrollView.delegate = self
    }
    
    
    @objc private func getStartedButtonTapped(sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc private func pageControlIndicatorTapped(sender: UIPageControl) {
        let offsetX = view.bounds.width * CGFloat(pageControl.currentPage)
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
    }
    
}

//#Preview{ WelcomeViewController()}
