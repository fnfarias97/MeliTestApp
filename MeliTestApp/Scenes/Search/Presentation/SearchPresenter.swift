//
//  SearchPresenter.swift
//  MeliTestApp
//
//  Created by Fernando Farias on 18/07/2023.
//

protocol SearchPresenterProtocol: AnyObject {
    var view: SearchViewProtocol? { get set }
    func searchProducts(query: String)
    func didSelectProduct(_ product: Product)
}

class SearchPresenter: SearchPresenterProtocol {

    weak var view: SearchViewProtocol?
    let service: ProductServiceProtocol

    init(service: ProductServiceProtocol = ProductDataManager()) {
        self.service = service
    }

    func searchProducts(query: String) {
        view?.showLoading()

        service.searchProducts(query: query) { [weak self] result in
            guard let self else { return }
            self.view?.hideLoading()

            switch result {
            case .success(let myQuery):
                guard let products = myQuery.results else { return }
                !products.isEmpty ? view?.displaySearchResults(products) : showError()
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }

    func didSelectProduct(_ product: Product) {
        // TODO: Complete
    }

    func showError() {

    }

}
