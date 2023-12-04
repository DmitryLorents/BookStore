//
//  RainbowApp
//

import UIKit

class HomeViewController: UIViewController {
    //MARK: - Parameters
    let firstStack = StackViewFactory().createStackView(with: "Top Book", subtitle: "see more")
    let secondStack = StackViewFactory().createStackView(with: "Recent Books", subtitle: "see more")
    let someView = CellViewFactory().createCellView(category: "Classics", name: "The Picture of Dorian Gray", author: "Oscar Wilde")
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(firstStack)
        view.addSubview(secondStack)
        view.addSubview(someView)
        setupConstrints()
    }
    
    
    
    // MARK: - Methods
    func setupConstrints() {
        NSLayoutConstraint.activate([
            firstStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            firstStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            firstStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            firstStack.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            secondStack.topAnchor.constraint(equalTo: firstStack.bottomAnchor),
            secondStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            secondStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            secondStack.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            someView.topAnchor.constraint(equalTo: secondStack.bottomAnchor, constant: 20),
            someView.widthAnchor.constraint(equalToConstant: 176),
            someView.heightAnchor.constraint(equalToConstant: 232),
            someView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
   
}
