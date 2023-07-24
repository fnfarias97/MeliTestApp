//
//  String+Localized.swift
//  MeliTestApp
//
//  Created by Fernando Farias on 22/07/2023.
//

import Foundation

extension String {
    var localized: String {
        let bundle = Bundle.main
        return NSLocalizedString(self, bundle: bundle, comment: "")
    }
}
