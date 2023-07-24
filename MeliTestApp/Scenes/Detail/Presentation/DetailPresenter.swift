//
//  DetailPresenter.swift
//  MeliTestApp
//
//  Created by Fernando Farias on 18/07/2023.
//

protocol DetailPresenterProtocol: AnyObject {
    func loadProduct(_ product: Product)
}

/* class DetailPresenter: DetailPresenterProtocol {

    weak var view: DetailViewProtocol?

    func loadProduct(_ product: Product) {
        view?.showLoading()

        service.searchProducts(query: query) { [weak self] result in
            guard let self else { return }
            self.view?.hideLoading()

            switch result {
            case .success(let myQuery):
                guard let results = myQuery.results else { return }
                for product in results {
                    print("Product ID: \(product.id)")
                    print("Title: \(product.title)")
                    // Access other properties of the product as needed
                }
            case .failure(let error):
                // Handle the error
                print("Error: \(error)")
            }
        }
    }
}
*/
