//
//  ContentView.swift
//  Design_M2L2_CustomTabView
//
//  Created by tom montgomery on 10/2/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        // Need a geometry reader to get the width of the space
        GeometryReader { geo in
            VStack {
                Text("Hello, world!")
                    .padding()
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
                        ForEach(0..<5, id: \.self) { _ in
                            // space out slightly
                            VStack(spacing: 5) {
                                // a single tab:  Icon + label
                                Image(systemName: "magnifyingglass")
                                Text("Search")
                                    .font(.caption)
                            }
                            .foregroundColor(.gray)
                            // bring it off the bottom edge of the phone
                            .padding(.vertical)
                            // take away margins, 20 left, 20 right, then divide by num of icons
                            .frame(width: (geo.size.width - 40)/5, height: 50)
                        }
                        Spacer()

                    }
                    // give the tab bar a standard height (max).  Set on each icon+label instead
                    //.frame(height: 50)
                }
                // set the height of the path
                .frame(height: 60)

            }
            // so we can own
            .ignoresSafeArea(edges: .bottom)
        }
        
        
        
    }
}

#Preview {
    ContentView()
}
