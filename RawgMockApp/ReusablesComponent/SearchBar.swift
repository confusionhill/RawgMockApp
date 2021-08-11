//
//  SearchBar.swift
//  RawgMockApp
//
//  Created by Farhandika Zahrir Mufti guenia on 11/08/21.
//

import UIKit
import SwiftUI


struct SearchBar: UIViewRepresentable {

    @Binding var text: String
    var search: () -> Void

    class Coordinator: NSObject, UISearchBarDelegate {

        @Binding var text: String
        var search: () -> Void

        init(text: Binding<String>, searchAction: @escaping () -> Void) {
            _text = text
            self.search = searchAction
        }

        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
        
        func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            search()
        }
    }
    
    func makeCoordinator() -> SearchBar.Coordinator {
        return Coordinator(text: $text, searchAction: self.search)
    }

    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.delegate = context.coordinator
        searchBar.autocapitalizationType = .none
        return searchBar
    }

    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}
