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
    @IBOutlet var answersText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let url = "https://opentdb.com/api.php?amount=1"
        getData(from: url)
        //self.answerButton2.setTitle("ddd", for: .normal)
    }

    private func getData(from url:String)
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
            
            self.categoryLabel.text = json.results[0].category
            self.questionText.text = json.results[0].question
           
            var i = 1
            var text = "#" + String(i) + ": " + json.results[0].correct_answer;
            for item in json.results[0].incorrect_answers
            {
                i += 1
                text += "\n#" + String(i) + ": " + item
            }
            
            self.answersText.text = text
            
        })
            
        task.resume()
    }

}

struct Response : Codable
{
    let response_code: Int
    let results: Array<Result>
}

struct Result :Codable
{
    let category: String
    //type":"multiple",
    //"difficulty":"easy",
    let question: String
    let correct_answer: String
    let incorrect_answers: Array<String>
}
