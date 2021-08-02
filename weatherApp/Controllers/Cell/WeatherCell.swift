//
//  weatherCell.swift
//  weatherApp
//
//  Created by Timur Israilov on 02/08/21.
//

import UIKit

class WeatherCell: UITableViewCell {
    let cityLabel = UILabel()
    let degreeLabel = UILabel()
    let weatherConditionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureCityLabel()
        configureDegreeLabel()
        configureWeatherConditionLabel()
    }
    
    public func setData(model: WeatherModel) {
        cityLabel.text = model.info?.tzinfo?.name
        degreeLabel.text = "\(model.fact?.temp ?? 0)C"
        weatherConditionLabel.text = model.fact?.condition
    }
    
    private func configureWeatherConditionLabel() {
        contentView.addSubview(weatherConditionLabel)
        
        weatherConditionLabel.snp.makeConstraints { make in
            make.right.equalTo(-10)
            make.centerY.equalToSuperview()
        }
    }
    
    private func configureDegreeLabel() {
        contentView.addSubview(degreeLabel)
        
        degreeLabel.font = .systemFont(ofSize: 18)
        
        degreeLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func configureCityLabel() {
        contentView.addSubview(cityLabel)
        
        cityLabel.font = .systemFont(ofSize: 20)
        
        cityLabel.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.centerY.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
