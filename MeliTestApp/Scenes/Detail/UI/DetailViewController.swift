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
        // imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.autoresizingMask = .flexibleWidth
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

    private lazy var contentView: UIView = {
        let view = UIView()
        [mainLabel, imageView, priceLabel].forEach {
            view.addSubview($0)
        }
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    private var imageViewHeightConstraint: NSLayoutConstraint?

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
        super.viewDidLoad()
        setupLayout()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.contentSize = CGSize(width: view.bounds.width, height: contentView.bounds.height)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        let aspectRatio: CGFloat = size.width > size.height ? 16.0/9.0 : 9.0/16.0
        imageViewHeightConstraint = imageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: aspectRatio)
    }

    // MARK: - Private Utilities

    private func setupLayout() {
        navigationController?.navigationBar.topItem?.title = " "
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        setupScrollViewConstraints()
        setupConstraints()
        setupProductDetails()
    }

    private func setupScrollViewConstraints() {
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    private func setupConstraints() {
        contentView.fillSuperView()
        imageViewHeightConstraint = imageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 9.0/16.0)
        imageViewHeightConstraint?.isActive = true

        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),

            mainLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.padding),
            mainLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
            mainLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),

            imageView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: Constants.padding),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),

            priceLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Constants.padding),
            priceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Constants.padding),
            priceLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Constants.padding),
            priceLabel.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor,
                                               constant: -Constants.padding)
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
