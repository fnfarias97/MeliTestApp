//
//  DetailViewController.swift
//  MeliTestApp
//
//  Created by Fernando Farias on 18/07/2023.
//

import UIKit

private struct Constants {
    static let padding: CGFloat = 16
    static let margin: CGFloat = 24
}


class DetailViewController: UIViewController {

    // MARK: - Properties

    private let product: Product

    private lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 30)
        return label
    }()

    // MARK: - Initializers

    required init(product: Product) {
        self.product = product
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        setupLayout()
    }

    // MARK: - Private Utilities

    private func setupLayout() {
        view.backgroundColor = .white

        [mainLabel, imageView, priceLabel].forEach {
            view.addSubview($0)
        }

        setupConstraints()
        setupProductDetails()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.padding),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.padding),
            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.padding),

            imageView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: Constants.margin),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.padding),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.padding),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor),

            priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.margin),
            priceLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.padding),
            priceLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Constants.padding),
            priceLabel.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -Constants.padding)
        ])
    }

    private func setupProductDetails() {
        mainLabel.text = product.title
        if let thumbnail = product.thumbnail {
            imageView.downloaded(from: thumbnail, contentMode: .scaleAspectFit)
        }
        priceLabel.text = product.price?.priceFormatter ?? "$ 0"
    }
}
