//
//  DetailViewController.swift
//  weatherApp
//
//  Created by Timur Israilov on 02/08/21.
//

import UIKit

class DetailViewController: UIViewController {
    private let cityLabel = UILabel()
    private let degreeLabel = UILabel()
    private let humidityLabel = UILabel()
    private let weatherConditionLabel = UILabel()
    private let feelsLikeLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Detail Information"
        configureCityLabel()
        configureDegreeLabel()
        configureHumidityLabelLabel()
        configureWeatherConditionLabel()
        configureFeelsLikeLabelLabel()
    }
    
    public func setData(model: WeatherModel) {
        cityLabel.text = model.info?.tzinfo?.name
        degreeLabel.text = "\(model.fact?.temp ?? 0)C"
        weatherConditionLabel.text = model.fact?.condition
        feelsLikeLabel.text = "Feel's Like \(model.fact?.feels_like ?? 0)C"
        humidityLabel.text = "Humidity \(model.fact?.humidity ?? 0)%"
    }
    
    private func configureCityLabel() {
        view.addSubview(cityLabel)
        
        cityLabel.font = .systemFont(ofSize: 24)
        
        cityLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(200)
        }
    }
    
    private func configureDegreeLabel() {
        view.addSubview(degreeLabel)
        
        degreeLabel.font = .systemFont(ofSize: 28)
        
        degreeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(cityLabel.snp.bottom).offset(20)
        }
    }
    
    private func configureHumidityLabelLabel() {
        view.addSubview(humidityLabel)
        
        humidityLabel.font = .systemFont(ofSize: 15)
        
        humidityLabel.snp.makeConstraints { make in
            make.right.equalTo(-24)
            make.top.equalTo(degreeLabel.snp.bottom).offset(10)
        }
    }
    
    private func configureWeatherConditionLabel() {
        view.addSubview(weatherConditionLabel)
        
        weatherConditionLabel.font = .systemFont(ofSize: 15)
        
        weatherConditionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(degreeLabel.snp.bottom).offset(10)
        }
    }
    
    private func configureFeelsLikeLabelLabel() {
        view.addSubview(feelsLikeLabel)
        
        feelsLikeLabel.font = .systemFont(ofSize: 15)
        
        feelsLikeLabel.snp.makeConstraints { make in
            make.left.equalTo(24)
            make.top.equalTo(degreeLabel.snp.bottom).offset(10)
        }
    }
}
