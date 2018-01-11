//
//  SearchResultViewController.swift
//  Easy_Fun_Art
//
//  Created by 이혜진 on 2018. 1. 11..
//  Copyright © 2018년 hyejin. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    let searchbar = UISearchBar()

    override func viewDidLoad() {
        super.viewDidLoad()

        createSearchbar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension SearchResultViewController: UISearchBarDelegate {
    func createSearchbar() {
        searchbar.showsCancelButton = false
        searchbar.placeholder = "키워드로 검색 가능"
        searchbar.delegate = self
        searchbar.spellCheckingType = .no
        searchbar.autocapitalizationType = .none
        searchbar.autocorrectionType = .no
        
        self.navigationItem.titleView = searchbar
    }

}
