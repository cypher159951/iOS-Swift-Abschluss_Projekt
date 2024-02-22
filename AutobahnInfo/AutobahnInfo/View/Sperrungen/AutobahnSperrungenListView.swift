//
//  AutobahnSperrungenListView.swift
//  AutobahnInfo
//
//  Created by Yannik Bleistein on 02.02.24.
//

import SwiftUI

struct AutobahnSperrungenListView: View {
    var road: String
    @StateObject var closureViewModel = ClosureViewModel()

    var body: some View {
        Group {
            if closureViewModel.closures.isEmpty {
                VStack {
                    Image(systemName: "checkmark.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.green)
                    Text("Keine Sperrungen")
                        .font(.title)
                }
                .toolbarBackground(Color.gray.opacity(0.8), for: .navigationBar)
             //   .listStyle(PlainListStyle())
                .scrollContentBackground(.hidden)
                .background(
                    Image("sperrungen2_background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                //    Color.clear
                )
                .padding()
                .onAppear {
                    closureViewModel.fetchClosures(for: road)
                }
            } else {
                List {
                    ForEach(closureViewModel.closures, id: \.identifier) { closure in
                        NavigationLink(destination: SperrungenDetailView(closure: closure)) {
                            Text(closure.title) 
                        }
                    }
                    .listRowBackground(BlurView(style: .extraLight))
                }
                .toolbarBackground(Color.red.opacity(0.6), for: .navigationBar)
             //   .listStyle(PlainListStyle())
                .scrollContentBackground(.hidden)
                .background(
                    Image("sperrungen2_background")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                //    Color.clear
                )
            }
        }
        .navigationTitle("Sperrungen für \(road)")
    }
}

struct AutobahnSperrungenListView_Previews: PreviewProvider {
    static var previews: some View {
        AutobahnSperrungenListView(road: "A2")
    }
}
