//
//  TabBarView.swift
//  CryptoSimulation
//
//  Created by Kento Akazawa on 11/26/23.
//

import SwiftUI

enum Tab: String, CaseIterable {
  case result = "Result"
  case variables = "Variables"
  case amount = "Amount"
}

struct TabBarView: View {

  @Binding var selectedTab: Tab

  // makes the image to be .fill (SF symbol)
  private var fillImage: String {
      selectedTab.rawValue + ".fill"
  }

  var body: some View {
    VStack {
        HStack {
            Picker(selection: $selectedTab) {
                ForEach(Tab.allCases, id: \.self) {
                    // fill image when selected
                    Image(systemName: selectedTab == $0 ? fillImage : $0.rawValue)
                        .scaleEffect(selectedTab == $0 ? 1.25 : 1)
                }
            } label: {
                EmptyView()
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        .cornerRadius(10)
    }
  }
}

#Preview {
  TabBarView(selectedTab: .constant(.result))
}
