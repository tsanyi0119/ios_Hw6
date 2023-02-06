//
//  MainViewController.swift
//  CallAPIExample
//
//  Created by imac-1681 on 2023/2/3.
//

import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var apiTableView: UITableView!
    
    var aqiArray: [AQIResponse.Records] = []
//    var aqiArray = [AQIResponse]() //對陣列初始化
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        hidekeyboardWhenTapped()

        // Do any additional setup after loading the view.
    }
    func setupUI(){
        setupTableView()
        setupTextField()
        setupButton()
    }
    private func setupTableView(){
        apiTableView.delegate = self
        apiTableView.dataSource = self
        apiTableView.register(UINib(nibName: "AQITableViewCell", bundle: nil),forCellReuseIdentifier: AQITableViewCell.identifier)
    }
    private func setupTextField(){
        numberTextField.placeholder = "請輸入要查詢的筆數"
        numberTextField.keyboardType = .numberPad
        numberTextField.text = UserPreferences.shared.lastSearchNum
    }
    private func setupButton(){
        searchButton.setTitle("開始查詢",for: .normal)
    }
    @IBAction func searchBtnClicked(_ sender: UIButton) {
        guard let text = numberTextField.text, !text.isEmpty else{
            return
        }
        UserPreferences.shared.lastSearchNum = text
        NetWorkManager.shared.requestData(limit: text.toInt()){(response: AQIResponseResult<AQIResponse>) in
            switch response{
            case .success(let results):
//                print(results.fields)
//                print("\n")
                print(results.records)
                self.aqiArray = results.records
                DispatchQueue.main.async {
                    self.apiTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    
    
}
extension MainViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aqiArray.count
    }
            
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AQITableViewCell.identifier,for: indexPath) as? AQITableViewCell else {
            fatalError("AQITableViewCell Load Failed!")
        }
        
        cell.setInit(county: aqiArray[indexPath.row].county, status: aqiArray[indexPath.row].status, aqi: aqiArray[indexPath.row].aqi.toInt())
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let nextVC = DetailViewController()
//        nextVC.county = aqiArray[indexPath.row].county
//        nextVC.aqi = aqiArray[indexPath.row].aqi
//        nextVC.status = aqiArray[indexPath.row].status
        UserPreferences.shared.aqi = aqiArray[indexPath.row].aqi
        UserPreferences.shared.county = aqiArray[indexPath.row].county
        UserPreferences.shared.status = aqiArray[indexPath.row].status
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
