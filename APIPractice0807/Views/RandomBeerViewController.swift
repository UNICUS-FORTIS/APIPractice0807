//
//  BeerViewController.swift
//  APIPractice0807
//
//  Created by LOUIE MAC on 2023/08/08.
//

import UIKit
import Kingfisher


final class RandomBeerViewController: UIViewController {
    
    private let viewModel = BeerViewModel()
    
    @IBOutlet weak var beerDisplay: UIImageView!
    @IBOutlet weak var beerTitle: UILabel!
    @IBOutlet weak var beerDescription: UILabel!
    @IBOutlet weak var shuffleButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        bindObject()
        viewModel.fetchRequest(endPoint: .allBeers(param: "ids", value: "23")) { url in
            self.beerDisplay.kf.setImage(with: url)
        }
    }
    
    func configureUI() {
        beerDescription.numberOfLines = 0
        beerTitle.lineBreakMode = .byWordWrapping
        beerDescription.lineBreakMode = .byWordWrapping
    }
    
    func bindObject() {
        viewModel.beerTitle.bind { title in
            self.beerTitle.text = title
        }
        viewModel.beerDescription.bind { description in
            self.beerDescription.text = description
        }
    }
        
    @IBAction func shuffleButtonTapped(_ sender: UIButton) {
        viewModel.fetchRequest(endPoint: .randomBeer) { url in
            self.beerDisplay.kf.setImage(with: url)
        }
    }
}
