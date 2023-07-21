//
//  SearchViewController.swift
//  MeliTestApp
//
//  Created by Fernando Farias on 18/07/2023.
//

import UIKit

protocol SearchViewProtocol: AnyObject {
    func showLoading()
    func hideLoading()
    func displaySearchResults(_ products: [Product])
    func displayError(_ message: String)
}

final class SearchViewController: UIViewController {

    // MARK: - Properties

    let presenter: SearchPresenterProtocol
    let searchBar = UISearchBar()
    // var tableView: UITableView

    // MARK: - Initializers

    init(presenter: SearchPresenterProtocol = SearchPresenter()) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        presenter.view = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.searchProducts(query: "iPhone X")
        // tableView.delegate = self
        // tableView.dataSource = self
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

/* extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in your data source
        return products.count // Replace `products` with your actual data array
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "YourCellIdentifier", for: indexPath) as! YourCustomTableViewCell

        // Configure the cell with the data from your data source
        let product = products[indexPath.row] // Replace `products` with your actual data array
        cell.titleLabel.text = product.title // Assuming you have a titleLabel in your custom cell

        return cell
    }
}*/


// MARK: - SearchViewProtocol

extension SearchViewController: SearchViewProtocol {
    func showLoading() {

    }

    func hideLoading() {

    }

    func displaySearchResults(_ products: [Product]) {

    }

    func displayError(_ message: String) {

    }
}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {

    }

    @objc func performSearch() {

    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {

    }
}
