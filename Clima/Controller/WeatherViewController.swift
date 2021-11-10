//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate, WeatherManagerDelegate   {
   
    

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager = WeatherManager()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     searchTextField.delegate = self
        weatherManager.delegate = self
    }
    @IBAction func searchedPressed(_ sender: UIButton) {
        searchTextField.endEditing(true)
        if var dummy = searchTextField.text {
        print(dummy)
            weatherManager.fetchWeather(cityName: dummy)
            
            
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text != "" {
            return false
        } else {
            textField.placeholder = "Type Something"
            return false
            
        }
    }
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
       
        if let city = searchTextField.text {
           print("The current City is: \(city)")
          //  weatherManager.fetchWeather(cityName: city)
            
        }
        
        
        searchTextField.text = ""
    }
}
    func didUptadeWeather(_ weatherManager: WeatherManager,  weather: WeatherModel) {
        temperatureLabel.text = weather.tempatureString
    }
    
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}
