//
//  CustomTabBarButton.swift
//  Design_M2L2_CustomTabView
//
//  Created by tom montgomery on 10/5/23.
//

import SwiftUI

struct CustomTabBarButton: View {
    
    var tab: tabInfo
    
    // Need to be able to manipulate the selectedTab - need binding
    @Binding var selectedTab: Tab
    
    var body: some View {
        ZStack {
            VStack(spacing: 5) {
                Rectangle()
                    .foregroundColor(.blue)
                    .frame(height: 2)
                    .opacity(tab.view == selectedTab ? 1 : 0)
                // a single tab:  Icon + label
                Image(systemName: tab.icon)
                    .frame(height: 20)
                // make icons the same height, else our vertical line above is squiggly
                Text(tab.name)
                    .font(.caption)
            }
        }
        // maybe make it more prominent / higher
        .offset(x: 0, y: tab.view == selectedTab ? -10.0 : 0)
        // space out slightly

        // Highlight the selected tab
        .foregroundColor(tab.view == selectedTab ? Color.blue : Color.gray)
        // have fun with it - maybe add a shadow
        .shadow(radius: tab.view == selectedTab ? 15 : 0)
        // bring it off the bottom edge of the phone
        .padding(.vertical)
        // take away margins, 20 left, 20 right, then divide by num of icons
        .frame(height: 50)
        .onTapGesture {
            // set the selected tab - need state
            self.selectedTab = tab.view
        }
    }
}

//#Preview {
//    CustomTabBarButton()
//}
