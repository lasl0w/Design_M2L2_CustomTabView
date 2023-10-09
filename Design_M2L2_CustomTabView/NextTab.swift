//
//  NextTab.swift
//  Design_M2L2_CustomTabView
//
//  Created by tom montgomery on 10/2/23.
//

import SwiftUI

// Probably put these in their own file in real life
enum Tab {
    case Home
    case Account
    case Message
    case Search
    case Settings
}

// make Identifiable so you can loop through the foreach array without setting an id: \.self
struct tabInfo: Identifiable {
    // set id to make Identifiable
    var id = UUID()
    // Tab var sets which case we are in
    var view: Tab
    var icon: String
    var name: String
}

struct NextTab: View {
    
    //var tabIcons = ["person", "envelope", "magnifyingglass", "star.fill", "star"]
    
    // instantiate as empty array of tabInfo
    @State var tabs = [tabInfo]()
    
    @State var selectedTab = Tab.Home
    
    var body: some View {
        
        // Need a geometry reader to get the width of the space
        GeometryReader { geo in
            VStack {
                
                // Switch the view according to the currently selected tab
                switch(selectedTab) {
                case Tab.Home:
                    // Show home
                    Text("Home")
                case Tab.Account:
                    // show account
                    Text("Account")
                case Tab.Message:
                    Text("Message")
                case Tab.Search:
                    Text("Search")
                case Tab.Settings:
                    Text("Settings")
                    // no need for default if never executed
//                default:
//                    Text("default")
                }
                
                Spacer()
                
                // Tab bar
                VStack {
                    
                    Path({ path in
                        path.move(to: CGPoint(x: 0, y: 0))
                        print(geo.size.width)
                        path.addLine(to: CGPoint(x: geo.size.width, y: 0))
                    })
                    .stroke(Color.gray)
                    
                    // spacing: 0, says we will manage our own spacing
                    HStack(spacing: 0) {
                        Spacer()
                        ForEach(tabs) { tab in
                            
                            // maybe we treat Tab.Add special
                            if tab.view == Tab.Account {
                                // Demonstrate that we can treat a certain tab differently
                                CustomTabBarButton(tab: tab, selectedTab: $selectedTab)
                                // individual buttons should not know about the other buttons so we moved the geo dependent frame out of the CustomTabBarButton
                                    .frame(width: (geo.size.width - 40)/5)
                            }
                            else {
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
                                .frame(width: (geo.size.width - 40)/5, height: 50)
                                .onTapGesture {
                                    // set the selected tab - need state
                                    self.selectedTab = tab.view
                                }
                            }
                           
                        }
                        Spacer()

                    }
                    // give the tab bar a standard height (max).  Set on each icon+label instead
                    //.frame(height: 50)
                }
                // set the height of the path
                .frame(height: 60)

            }
            // so we can own.  maybe just some padding
            //.ignoresSafeArea(edges: .bottom)
        }
        .onAppear(perform: {
            // create tabs
            
            var newTabs = [tabInfo]()
            newTabs.append(tabInfo(view: Tab.Home, icon: "person", name: "Home"))
            newTabs.append(tabInfo(view: Tab.Message, icon: "envelope", name: "Message"))
            newTabs.append(tabInfo(view: Tab.Search, icon: "magnifyingglass", name: "Search"))
            newTabs.append(tabInfo(view: Tab.Account, icon: "star.fill", name: "Account"))
            newTabs.append(tabInfo(view: Tab.Settings, icon: "star", name: "Settings"))
            
            // triggers anything that is reading self.tabs to update the views
            self.tabs = newTabs
        })
        
        
        
    }
}

#Preview {
    NextTab()
}
