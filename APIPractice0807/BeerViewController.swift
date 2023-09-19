//
//  BeerViewController.swift
//  APIPractice0807
//
//  Created by LOUIE MAC on 2023/08/08.
//

import UIKit
import Alamofire
import Kingfisher

class BeerViewController: UIViewController {
    
    let networkManager = APIService.shared
    
    let titleArray:[String] = [
        "이 어플 설치한순간 당신은 만취상태",
        "대낮부터 취해서 바닥에서 뒹굴예정",
        "근데 이맥주 한국에서 안팔수도 있음",
        "만남이 있으면 헤어짐도 있는법",
        "술은 먹어도 어린이는 보호하자",
        "음주운전은 광화문에 묶어놓고 몽둥이찜질",
        "술만 먹으면 부모는 날 기다려주지 않는다"
    ]
    
    @IBOutlet weak var mainTitleLabel: UILabel!
    @IBOutlet weak var beerDisplay: UIImageView!
    @IBOutlet weak var beerTitle: UILabel!
    @IBOutlet weak var beerDescription: UILabel!
    @IBOutlet weak var shuffleButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetch()
    }
    
    func configureUI() {
        beerTitle.text = ""
        beerDescription.text = ""
        beerDescription.textAlignment = .left
        beerDescription.numberOfLines = 0
    }
    
    func fetch() {
        print(#function)
        networkManager.fetchRequest(type: BeerReco.self, url: .randomBeer) { [weak self] result in
            switch result {
            case .success(let data):
                print(data)
                self?.beerTitle.text = data.name
                self?.beerDescription.text = data.description
                let imageUrl = data.imageURL
                let url = URL(string: imageUrl)
                DispatchQueue.main.async {
                    self?.beerDisplay.kf.setImage(with: url)
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    
    
    
    @IBAction func shuffleButtonTapped(_ sender: UIButton) {
        mainTitleLabel.text = titleArray.randomElement()!
    }
    
    
}
