//
//  ViewController.swift
//  final
//
//  Created by Alexandru Bargan on 3/5/20.
//  Copyright © 2020 Catalin. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var categoryLabel: UILabel!
    @IBOutlet var questionText: UITextView!
    @IBOutlet var viewTest: UIStackView!
    
    let url = Constants.questionsURL
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        getData(url)
        //self.answerButton2.setTitle("ddd", for: .normal)
    }
    
    
    
    @objc func buttonTapped(_ sender: UIButton)
    {
        print("button id = ", sender.tag)
        
        self.getData(url)
    }

    private func getData(_ url:String)
    {
        let task = URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            guard let data = data, error == nil else {
                print("Error...")
                return
            }
            
            var result: Response?
            do {
                result = try JSONDecoder().decode(Response.self, from: data)
            }
            catch {
                print("Error... \(error.localizedDescription)")
            }
            
            guard let json = result else {
                return
            }
            
            print(json.response_code)
            print(json.results[0].category)
            print(json.results[0].question)
            print(json.results[0].correct_answer)
            
            DispatchQueue.main.async {
                self.categoryLabel.text = json.results[0].category
                self.questionText.text = json.results[0].question
                
                self.viewTest.arrangedSubviews.forEach { $0.removeFromSuperview() }
               
                var i = 1
                var text = "#" + String(i) + ": " + json.results[0].correct_answer;
                let button = UIButton()
                button.tag = i
                button.setTitle(String(i) + ": " + json.results[0].correct_answer, for: .normal)
                button.addTarget(self, action: #selector(self.buttonTapped(_:)), for: UIControl.Event.touchUpInside)
                self.viewTest.addArrangedSubview(button)
                
                
                for item in json.results[0].incorrect_answers
                {
                    i += 1
                    text += "\n#" + String(i) + ": " + item
                    
                    let button = UIButton()
                    button.tag = i
                    button.setTitle(String(i) + ": " + item, for: .normal)
                    button.addTarget(self, action: #selector(self.buttonTapped(_:)), for: UIControl.Event.touchUpInside)
                    self.viewTest.addArrangedSubview(button)
                }
                
                
            }
        })
            
        task.resume()
    }

}
