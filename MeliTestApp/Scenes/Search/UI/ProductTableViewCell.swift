//
//  ProductTableViewCell.swift
//  MeliTestApp
//
//  Created by Fernando Farias on 21/07/2023.
//

import UIKit

private struct Constants {
    static let padding: CGFloat = 16
    static let height: CGFloat = 110
    static let imageWidth: CGFloat = 80
}

class ProductTableViewCell: UITableViewCell {

    // MARK: - Properties

    static var reusableIdentifier = String(describing: ProductTableViewCell.self)
    static let height: CGFloat = Constants.height

    private lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func setupView() {
        [thumbnailImageView, container].forEach {
            contentView.addSubview($0)
        }

        [titleLabel, priceLabel].forEach {
            container.addSubview($0)
        }
        selectionStyle = .none
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                        constant: Constants.padding),
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor,
                                                    constant: Constants.padding),
            thumbnailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                                       constant: -Constants.padding),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: Constants.imageWidth),

            container.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor,
                                               constant: Constants.padding),
            container.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.padding),
            container.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                constant: -Constants.padding),
            container.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,
                                              constant: -Constants.padding),

            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor,
                                                constant: -Constants.padding),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),

            priceLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            priceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: -8),
            priceLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            priceLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor),
        ])
    }

    // MARK: Public interface

    func setup(with product: Product) {
        if let thumbnail = product.thumbnail {
            thumbnailImageView.downloaded(from: thumbnail, contentMode: .scaleAspectFit)
        }

        titleLabel.text = product.title
        priceLabel.text = product.price?.priceFormatter ?? "$ 0"
    }
}
