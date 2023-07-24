//
//  ErrorView.swift
//  MeliTestApp
//
//  Created by Fernando Farias on 24/07/2023.
//

import UIKit

class ErrorView: UIView {
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var descriptionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    private func configure() {
        titleLabel.text = "ErrorScreen.title".localized
        descriptionLabel.text = "ErrorScreen.body".localized
    }
}
