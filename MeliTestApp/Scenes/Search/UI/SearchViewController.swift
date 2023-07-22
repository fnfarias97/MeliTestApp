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
    var products: [Product] = []
    let searchBar = UISearchBar()
    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    // MARK: - Initializers

    init(presenter: SearchPresenterProtocol = SearchPresenter()) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        presenter.view = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.searchProducts(query: "iPhone X")
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.reusableIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        setupViews()
        setupConstraints()
    }

    // MARK: - Layout

    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(tableView)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ProductTableViewCell.reusableIdentifier,
                                                       for: indexPath) as? ProductTableViewCell else {
            return UITableViewCell()
        }

        let product = products[indexPath.row]
        cell.setup(with: product)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ProductTableViewCell.height
    }
}


// MARK: - SearchViewProtocol

extension SearchViewController: SearchViewProtocol {
    func showLoading() {

    }

    func hideLoading() {

    }

    func displaySearchResults(_ products: [Product]) {
        self.products = products
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
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
