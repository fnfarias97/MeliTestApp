//
//  MeliSearchBar.swift
//  MeliTestApp
//
//  Created by Fernando Farias on 22/07/2023.
//

import UIKit

class MeliSearchBar: UISearchBar {

    public convenience init(delegate: UISearchBarDelegate) {
        self.init()
        self.delegate = delegate
        setupSearchBar()
    }

    private func setupSearchBar() {
        placeholder = "SearchBar.placeholder".localized
        searchTextField.backgroundColor = .white
        searchTextField.clipsToBounds = true
        searchTextField.layer.cornerRadius = 20
        searchTextField.font = .systemFont(ofSize: 12)
    }
}
