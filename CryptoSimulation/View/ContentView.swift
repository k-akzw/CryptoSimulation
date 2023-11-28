//
//  ContentView.swift
//  CryptoSimulation
//
//  Created by Kento Akazawa on 11/10/23.
//

import SwiftUI

struct ContentView: View {
  
  // MARK: - Properties
  
  @State private var selectedTab: Tab = .result

  var body: some View {
    VStack {
      switch selectedTab {
      case .result:
        ResultView()
      case .variables:
        VariableView()
      case .amount:
        BalanceView()
      }
      
      TabBarView(selectedTab: $selectedTab)
    }
  }
}

#Preview {
  ContentView()
}
