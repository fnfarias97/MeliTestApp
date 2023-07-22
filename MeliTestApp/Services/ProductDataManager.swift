//
//  ProductDataManager.swift
//  MeliTestApp
//
//  Created by Fernando Farias on 13/07/2023.
//

import Alamofire

protocol ProductServiceProtocol {
    func searchProducts(query: String, completion: @escaping (Result<Query, Error>) -> Void)
}

class ProductDataManager: ProductServiceProtocol {
    func searchProducts(query: String, completion: @escaping (Result<Query, Error>) -> Void) {
        let queryParam = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? query
        let url = "https://api.mercadolibre.com/sites/MLA/search?q=" + queryParam
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        AF.request(url).validate().responseDecodable(of: Query.self, decoder: decoder) { response in
            switch response.result {
            case .success(let products):
                completion(.success(products))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
