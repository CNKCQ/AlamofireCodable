//
//  ViewController.swift
//  AlamofireCodable
//
//  Created by wangchengqvan@gmail.com on 11/14/2017.
//  Copyright (c) 2017 wangchengqvan@gmail.com. All rights reserved.
//

import UIKit
import AlamofireCodable
import Alamofire

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func objectRequest(_ sender: Any) {
        let form = WeatherForm()
        Alamofire.request(
                form.url,
                method: HTTPMethod.get,
                parameters: form.parameters(),
                encoding: form.encoding(),
                headers: form.headers()
            )
            .responseObject(keyPath: "data",completionHandler: { (response: DataResponse<Weather>) in
                switch response.result {
                case .success(let object):
                    debugPrint("🌹", object.location)
                case .failure(let error):
                    debugPrint("🌹", error.localizedDescription)
                }
            })
    }
    
    @IBAction func arrayRequest(_ sender: Any) {
        let form = WeatherForm()
        Alamofire.request(
                form.url,
                method: HTTPMethod.get,
                parameters: form.parameters(),
                encoding: form.encoding(),
                headers: form.headers()
            )
            .responseArray(keyPath: "data.three_day_forecast", completionHandler: { (response: DataResponse<[Forecast]>) in
                switch response.result {
                case .success(let array):
                    debugPrint("🌹", array)
                case .failure(let error):
                    debugPrint("🌹", error.localizedDescription)
                }
            })
//            .responseJSON { (response) in
//                print("🌹", response.result.value.debugDescription)
//        }
    }
    
    @IBAction func nestedRequest(_ sender: Any) {
        let form = WeatherForm()
        Alamofire.request(
            form.url,
            method: HTTPMethod.get,
            parameters: form.parameters(),
            encoding: form.encoding(),
            headers: form.headers()
            )
            .responseObject(completionHandler: { (response: DataResponse<RootModel>) in
                switch response.result {
                case .success(let root):
                    debugPrint("🌹", root)
                case .failure(let error):
                    debugPrint("🌹", error.localizedDescription)
                }
            })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

struct RootModel: Codable {
    
    var data: Weather
}


struct Weather: Codable {
    
    var location: String
    
    var three_day_forecast: [Forecast]
    
}

struct Forecast: Codable {
    
    var conditions: String
    
    var day: String
    
    var temperature: Int64
}

struct WeatherForm {
    
    var city = "shanghai"
    
    var method = Alamofire.HTTPMethod.get
    
    func parameters() -> [String: Any] {
        return ["city": city]
    }
    
    func encoding() -> ParameterEncoding {
        return Alamofire.URLEncoding.default
    }
    
    var url = "https://raw.githubusercontent.com/tristanhimmelman/AlamofireObjectMapper/"
        + "2ee8f34d21e8febfdefb2b3a403f18a43818d70a/sample_keypath_json"
    
    public func headers() -> [String: String] {
        return ["accessToken": "xxx"]
    }
}


