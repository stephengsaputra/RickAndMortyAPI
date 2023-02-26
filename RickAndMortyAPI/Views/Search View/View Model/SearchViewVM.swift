//
//  SearchViewVM.swift
//  RickAndMortyAPI
//
//  Created by Stephen Giovanni Saputra on 04/02/23.
//

import Foundation

final class SearchViewVM {
    
    let config: SearchVC.Config
    
    private var optionMap: [SearchInputViewVM.DynamicOption: String] = [:]
    private var searchText = ""
    
    private var optionMapUpdateBlock: (((SearchInputViewVM.DynamicOption, String)) -> Void)?
    private var searchResultHandler: (() -> Void)?
    
    init(config: SearchVC.Config) {
        self.config = config
    }
    
    public func executeSearch() {
        
        var queryParams: [URLQueryItem] = [
            URLQueryItem(name: "name", value: searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
        ]
        
        queryParams.append(contentsOf: optionMap.enumerated().compactMap({ _, element in
            let key: SearchInputViewVM.DynamicOption = element.key
            let value: String = element.value
            return URLQueryItem(name: key.queryArgument, value: value)
        }))
        
        let request = APIRequest(
            endpoint: config.type.endpoint,
            queryParameters: queryParams
        )
        
        APIService.shared.execute(request, expecting: CharactersResponse.self) { result in
            
            switch result {
            case .success(let success):
                print(String(describing: success.results?.count))
            case .failure(_):
                break
            }
        }
        
        // Notify view for change
    }
    
    public func registerSearchResultHandler(_ block: @escaping () -> Void) {
        self.searchResultHandler = block
    }
    
    public func set(query text: String) {
        self.searchText = text
    }
    
    public func set(value: String, for option: SearchInputViewVM.DynamicOption) {
        
        optionMap[option] = value
        let tuple = (option, value)
        optionMapUpdateBlock?(tuple)
    }
    
    public func registerOptionChangeBlock(_ block: @escaping ((SearchInputViewVM.DynamicOption, String)) -> Void) {
        self.optionMapUpdateBlock = block
    }
}
