//
//  Product.swift
//  MeliTestApp
//
//  Created by Fernando Farias on 13/07/2023.
//

struct Product: Codable {
    let id: String?
    let title: String?
    let condition: String?
    let listingTypeId: String?
    let permalink: String?
    let buyingMode: String?
    let siteId: String?
    let categoryId: String?
    let thumbnail: String?
    let currencyId: String?
    let price: Double?
    let soldQuantity: Int?
    let availableQuantity: Int?
    let officialStoreId: Int?
    let acceptsMercadopago: Bool?
    let tags: [String]?
    let stopTime: String?
    let catalogListing: Bool?
    let inventoryId: String?
}
