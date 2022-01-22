//
//  ViewController.swift
//  RequestApp
//
//  Created by William Daniel da Silva Kuhs on 22/01/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = "https://api.sunrise-sunset.org/json?lat=36.7201600&lng=-4.4203400&formatted=0"
        getData(from: url)
    }

    private func getData(from url: String) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!){
            data, response, error in
            
            guard let data = data, error == nil else {
                print("Error")
                return
            }
            
            var result: Response?
            do {
                result = try JSONDecoder().decode(Response.self, from: data)
                print("Success")
            }
            catch {
                print("Catch Error")
            }
            
            guard let json = result else {
                return
            }
            
            print(json.status)
            print(json.results.sunrise)
            print(json.results.sunset)
        }
            
        task.resume()
    }
}


struct Response: Codable {
    let results: MyResult
    let status: String
}

struct MyResult: Codable {
    let sunrise: String
    let sunset: String
    let solar_noon: String
    let day_length: Int
    let civil_twilight_begin: String
    let civil_twilight_end: String
    let nautical_twilight_begin: String
    let nautical_twilight_end: String
    let astronomical_twilight_begin: String
    let astronomical_twilight_end: String
}

//{
//  "results":{
//      "sunrise":"2022-01-22T07:24:51+00:00",
//     "sunset":"2022-01-22T17:33:39+00:00",
//      "solar_noon":"2022-01-22T12:29:15+00:00",
//      "day_length":36528,
//      "civil_twilight_begin":"2022-01-22T06:58:30+00:00",
//      "civil_twilight_end":"2022-01-22T17:59:59+00:00",
//      "nautical_twilight_begin":"2022-01-22T06:27:03+00:00",
//      "nautical_twilight_end":"2022-01-22T18:31:27+00:00",
//      "astronomical_twilight_begin":"2022-01-22T05:56:14+00:00",
//      "astronomical_twilight_end":"2022-01-22T19:02:15+00:00"
//   },
//   "status":"OK"
//}
