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

    private var searchBar: UISearchBar?

    private lazy var tableView: UITableView = {
        let view = UITableView(frame: .zero, style: .grouped)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var indicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        view.style = .large
        view.color = .black
        view.startAnimating()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private var originalView: UIView?

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
        originalView = view
        setupLayout()
    }

    // MARK: - Layout

    private func setupLayout() {
        setupViews()
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.reusableIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        setupConstraints()
        searchBar = MeliSearchBar(delegate: self)
        navigationItem.titleView = searchBar
    }

    private func setupViews() {
        view.backgroundColor = .white
        [tableView, indicatorView].forEach {
            view.addSubview($0)
        }
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            indicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

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

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = products[indexPath.row]
        let viewController = DetailViewController(product: product)
        navigationController?.pushViewController(viewController, animated: true)
    }
}


// MARK: - SearchViewProtocol

extension SearchViewController: SearchViewProtocol {
    func showLoading() {
        DispatchQueue.main.async {
            self.indicatorView.startAnimating()
            self.tableView.isHidden = true
        }
    }

    func hideLoading() {
        DispatchQueue.main.async {
            self.indicatorView.stopAnimating()
            self.tableView.isHidden = false
        }
    }

    func displaySearchResults(_ products: [Product]) {
        view = originalView
        self.products = products
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    func displayError(_ message: String) {
        guard let errorView = Bundle.main.loadNibNamed("ErrorScreen", owner: nil, options: nil)?.first as? ErrorView else {
            return
        }

         view = errorView
    }

}

// MARK: - UISearchBarDelegate

extension SearchViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let query = searchBar.text {
            presenter.searchProducts(query: query)
        }
        searchBar.resignFirstResponder()
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
    }
}
