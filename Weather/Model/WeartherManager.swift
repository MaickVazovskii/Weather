//
//  WearData.swift
//  Weather
//
//  Created by Тимур Гутиев on 15.09.2021.
//

import Foundation

protocol WeatherManagerDelegate {
    func updateWeather(weatherData from: WeatherData)
}

struct WeartherManager {
    
    let baseURL = "https://api.openweathermap.org/data/2.5/weather?appid=78fe7457234f6c90693e22232ca07a2c&units=metric&q="
    
    var delegate: WeatherManagerDelegate?
    
    func getWeather(cityName: String) { // принимает название города, которое юзер указывает в textField (см HomeViewController)
//        print(cityName)
        let urlString = "\(baseURL)\(cityName)"
        performRequest(with: urlString) // принимает baseURL, дополненный названием города
    }
    
    func performRequest(with urlString: String ) { // принимает url и скачивает в память данные
        if let url = URL(string: urlString) {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { data, response, error in // задача извлекает данные,а closure принимает скаченные данные и выполняет код
                if error != nil {
                    print(error!)
                }else{
                    if let safeData = data { // сами скаченные данные
//                        let stringData = String(data: safeData, encoding: .utf8)
//                        print(stringData!)
                        if let parsedData = parseJSON(from: safeData) { // преобразует данные из формата JSON и возвращает данные определенного типа
                            self.delegate?.updateWeather(weatherData: parsedData) // в качесте принимаемого параметра принимает преобразованные данные
                        }
                        
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(from weatherData: Data) ->WeatherData? { // преобразует скаченные данные из формата JSON и возвращает данные определенного типа, например of type WeatherData
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData) // декодер преобразует принимаемый JSON object, т.е. weatherData и returns a value of the type you specify, т.е. decodedData будет иметь тип WeatherData. Это значит, что у decodedData будут свойста и методы, присущие типу WeatherData
            
            print(decodedData.main.temp)
            return decodedData
//            let weatherInfo =
            
        }catch{
            print(error)
            return nil
        }
    }
    
    
}
