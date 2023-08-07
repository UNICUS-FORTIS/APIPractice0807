//
//  BeerViewController.swift
//  APIPractice0807
//
//  Created by LOUIE MAC on 2023/08/08.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class BeerViewController: UIViewController {
    
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
        beerTitle.text = ""
        beerDescription.text = ""
        beerDescription.textAlignment = .left
        beerDescription.numberOfLines = 0
        fetchRequest()
    }
    
    
    
    func fetchRequest() {
        let url = "https://api.punkapi.com/v2/beers/random"
        // weeeeeeeek 쌜프
        // 근데 포스트맨에서는 아까 갖고왔는데 왜 여기서는 아까 안됐나?
        AF.request(url, method: .get).validate().responseJSON { [weak self] response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                // 이거 뎁스 하나 들어가있어서 0 넣으니까 됨 Fantastic.
                self?.beerTitle.text = json[0]["name"].stringValue
                self?.beerDescription.text = json[0]["description"].stringValue
                guard let beerImage = json[0]["image_url"].string else { return }
                let imageUrl = URL(string: beerImage)
                self?.beerDisplay.kf.setImage(with: imageUrl)
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    @IBAction func shuffleButtonTapped(_ sender: UIButton) {
        fetchRequest()
        mainTitleLabel.text = titleArray.randomElement()!
    }
    
    
}
