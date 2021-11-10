//
//  WeatherManager.swift
//  Clima
//
//  Created by Nayan Balla on 24/2/20.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUptadeWeather(_ weatherManager: WeatherManager,  weather: WeatherModel)
    func didFailWithError(error: Error)
        
  }


struct WeatherManager {
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=8951339650404ba5c96e0100e6f16a3b&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    
    func fetchWeather(cityName: String) {
        
        let urlString = "\(weatherURL)&q=\(cityName)"
        print("The URL Is: \(urlString)")
        performRequest(urlString: urlString)
        
    }
    
    func performRequest(urlString: String) {
        
        if let url = URL(string: urlString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parsedJSON(safeData) {
                        let weatherVC = WeatherViewController()
                        self.delegate?.didUptadeWeather(self, weather: weather)
                    }
                }
              
            }
            
            task.resume()
        }
        
        
    }
    
    func parsedJSON(_ weatherData: Data) -> WeatherModel? {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodeData.weather[0].id
            let temp = decodeData.main.temp
            let name = decodeData.name
            let weather = WeatherModel(conditionId: id, cityName: name, temprature: temp)
            
            
            print("The temp is: \(weather.temprature)")
            
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
     return nil
    }
}


    


 
