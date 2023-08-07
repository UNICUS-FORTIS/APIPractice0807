//
//  ViewController.swift
//  APIPractice0807
//
//  Created by LOUIE MAC on 2023/08/07.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    
    let pickerView = UIPickerView()
    var dateArray:[Int] = []
    var initialNumber = 1079
    
    
    @IBOutlet weak var numberTextField: UITextField!

    @IBOutlet var winningNumberCollection: [UILabel]!
    
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSettings()
    }
    
    func loadSettings() {
        pickerView.delegate = self
        pickerView.dataSource = self
        numberTextField.inputView = pickerView
        numberTextField.tintColor = .clear
        numberTextField.backgroundColor = .lightGray
        numberTextField.placeholder = "터치해서 회차를 선택하세요"
        numberTextField.textAlignment = .center
        welcomeLabel.text = "당신은 ~ 안돼는!! 로또당첨번호!!!"
        welcomeLabel.textAlignment = .center
        welcomeLabel.font = .systemFont(ofSize: 20)
        
        winningNumberCollection.forEach { label in
            label.font = .systemFont(ofSize: 20)
            label.textAlignment = .center
            label.backgroundColor = .black
            label.textColor = .systemPink
            label.text = ""
        }
        
        for _ in 1...20 {
            dateArray.append(initialNumber)
            initialNumber -= 7
        }
    }
    
    func fetchRequest(date:String) {
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=\(date)"
        
        AF.request(url, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
 
                for i in 0...self.winningNumberCollection.count-1 {
                    if i == 6 {
                        self.winningNumberCollection[i].text = json["bnusNo"].stringValue
                    } else {
                        self.winningNumberCollection[i].text = json["drwtNo\(i+1)"].stringValue
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }


}

extension ViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let row = "\(dateArray[row])"
        numberTextField.text = "\(row)회 로또 당첨번호 !!"
        fetchRequest(date: row)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(dateArray[row])"
    }
}

extension ViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dateArray.count
    }
}

