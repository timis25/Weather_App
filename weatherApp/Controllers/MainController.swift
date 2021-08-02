//
//  ViewController.swift
//  weatherApp
//
//  Created by Timur Israilov on 02/08/21.
//

import UIKit
import SnapKit

class MainController: UIViewController {
    private let tableView = UITableView()
    private var weatherModel = [WeatherModel]()
    private let lats = ["41.2646500", "55.7522", "52.5244", "25.2854", "40.7143", "54.7431", "39.9075", "50.4547", "54.7431", "59.9386"]
    private let lons = ["69.2162700", "37.6156", "13.4105", "51.531", "-74.006", "55.9678", "39.9075", "30.5238", "55.9678", "30.3141"]
    private let searchController = UISearchController(searchResultsController: nil)
    private var filteredWeather = [WeatherModel]()
    private var searchBarIsEmpty: Bool {
        guard let text = searchController.searchBar.text else { return false}
        return text.isEmpty
    }
    private var isFiltering: Bool {
        return searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "All cities"
        configureTableView()
        configureSearchController()
        getData()
    }
    
    private func getData() {
        for (i, _) in lats.enumerated() {
            NetworkManager.shared.getCurrentWeather(lat: lats[i], lon: lons[i]){ (result) in
                switch result {
                case .success(let WeatherModel):
                    self.weatherModel.append(WeatherModel)
                    self.tableView.reloadData()
                case .failure(let AFError):
                    print(AFError)
                }
            }
        }
    }
    
    private func configureSearchController() {
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Go searching...."
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(WeatherCell.self, forCellReuseIdentifier: String(describing: WeatherCell.self))
        
        tableView.snp.makeConstraints { make in
            make.width.height.equalToSuperview()
        }
    }
}

extension MainController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filteredWeather.count
        }
        return weatherModel.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: WeatherCell.self), for: indexPath) as? WeatherCell {
            
            if isFiltering {
                cell.setData(model: filteredWeather[indexPath.row])
            } else {
                cell.setData(model: weatherModel[indexPath.row])
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let DetailVC = DetailViewController()
        
        if isFiltering {
            DetailVC.setData(model: filteredWeather[indexPath.row])
        } else {
            DetailVC.setData(model: weatherModel[indexPath.row])
        }
        
        navigationController?.pushViewController(DetailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterWeatherForSearchText(searchController.searchBar.text!)
    }
    
    private func filterWeatherForSearchText(_ searchText: String) {
        filteredWeather = weatherModel.filter({ (weather) -> Bool in
            return (weather.info?.tzinfo?.name?.lowercased().contains(searchText.lowercased()))!
        })
        tableView.reloadData()
    }
}
