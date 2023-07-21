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
    let listing_type_id: String?
    let permalink: String?
    let buying_mode: String?
    let site_id: String?
    let category_id: String?
    let thumbnail: String?
    let currency_id: String?
    let price: Double?
    let sold_quantity: Int?
    let available_quantity: Int?
    let official_store_id: Int?
    let accepts_mercadopago: Bool?
    let tags: [String]?
    let stop_time: String?
    let catalog_listing: Bool?
    let inventory_id: String?
}
