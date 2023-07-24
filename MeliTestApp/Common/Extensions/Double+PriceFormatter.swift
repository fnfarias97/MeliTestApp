//
//  Double+PriceFormatter.swift
//  MeliTestApp
//
//  Created by Fernando Farias on 22/07/2023.
//

import Foundation

extension Double {
    var priceFormatter: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency

        formatter.locale = Locale(identifier: "es_AR")
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        return formatter.string(from: self as NSNumber)!
    }
}
