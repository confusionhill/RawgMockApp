//
//  TabViewController.swift
//  RawgMockApp
//
//  Created by Farhandika Zahrir Mufti guenia on 05/08/21.
//

import Foundation
import SwiftUI

public struct TabViewController: View {
    @Binding var TabViewSelection:TabViewLink
    @ViewBuilder public var body: some View {
        switch self.TabViewSelection {
        case .home:
            HomeView()
        case .bookmart:
            HomeView()
        case .account:
            HomeView()
        }
        
    }
}
