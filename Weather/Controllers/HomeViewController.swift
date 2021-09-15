//
//  HomeViewController.swift
//  Weather
//
//  Created by Тимур Гутиев on 14.09.2021.
//

import UIKit

class HomeViewController: UIViewController {

    var weatherManager = WeartherManager()
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.delegate = self
        weatherManager.delegate = self
    }
}

// MARK: - WeatherManagerDelegate

extension HomeViewController: WeatherManagerDelegate {
    func updateWeather(weatherData from: WeatherData) {
        DispatchQueue.main.async {
            self.cityLabel.text = from.name
            self.temperatureLabel.text = from.main.stringTemp
            self.weatherImage.image = UIImage(systemName: from.weather[0].weatherCondition)
        }
        
    }
    
    
}

// MARK: - UITextFieldDelegate

extension HomeViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
       return textField.endEditing(true)
        
    }
    
    @IBAction func searchButton(_ sender: UIButton) {
        textField.endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text != "" {
            weatherManager.getWeather(cityName: textField.text!)
        }else{
            textField.placeholder = "Please Enter City Name"
        }
    }
    
}





