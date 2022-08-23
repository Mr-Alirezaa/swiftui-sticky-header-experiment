//
//  ContentView.swift
//  StickyHeader
//
//  Created by Alireza Asadi on 31/5/1401 AP.
//

import SwiftUI

struct ContentView: View {
    @Namespace private var namespace
    @State private var tabIndex: Int = 0
    @State private var tabBarSize: CGSize = .zero
    @State private var dismissButtonInTabBar: Bool = false

    @Environment(\.dismiss) private var dismiss
    @Environment(\.safeAreaInsets) private var safeAreaInsets

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                header

                LazyVStack(alignment: .leading, pinnedViews: [.sectionHeaders]) {
                    Section {
                        ForEach(0..<25, id: \.self) { index in
                            Text("Hello, World! \(index)")
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundColor(Color.white)
                                .padding()
                        }
                    } header: {
                        GeometryReader { geom in
                            let frame = geom.frame(in: .named("Scroll"))

                            ZStack(alignment: .bottom) {
                                Color.black
                                    .frame(height: frame.minY < safeAreaInsets.top ? tabBarSize.height + safeAreaInsets.top - frame.minY : tabBarSize.height, alignment: .bottom)

                                HStack {
                                    pinningTabBar
                                }
                                .readingSize { size in
                                    tabBarSize = size
                                }
                            }
                        }
                        .frame(height: tabBarSize.height)
                    }
                }
            }
        }
        .coordinateSpace(name: "Scroll")
        .background(Color.black)
        .ignoresSafeArea(.container, edges: .top)
        .animation(.easeOut, value: tabIndex)
        .navigationBarHidden(true)
    }

    @ViewBuilder
    var dismissButton: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "chevron.left.circle.fill")
                .font(.title)
                .foregroundColor(.white)
        }
        .padding()
    }

    @ViewBuilder
    var pinningTabBar: some View {
        HStack {
            if dismissButtonInTabBar {
                dismissButton
                    .matchedGeometryEffect(id: "Dismiss", in: namespace, properties: .position)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 20) {
                    ForEach(0..<6) { index in
                        Button {
                            withAnimation {
                                tabIndex = index
                            }
                        } label: {
                            Text("Tab Index \(index)")
                                .foregroundColor(index == tabIndex ? .white : .gray)
                                .font(.headline)
                                .padding()
                                .background {
                                    if index == tabIndex {
                                        Capsule()
                                            .fill(Color.white.opacity(0.1))
                                            .matchedGeometryEffect(id: "Capsule", in: namespace, properties: .position, isSource: true)
                                    }
                                }
                        }
                    }
                }
                .padding([.vertical, .trailing])
                .padding(dismissButtonInTabBar ? [] : [.leading])
            }
        }
    }

    @ViewBuilder
    var header: some View {
        GeometryReader { geometry in
            let frame = geometry.frame(in: .named("Scroll"))
            let height = max(frame.size.height + frame.minY, 0)

            Image("food")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: frame.width, height: height, alignment: .top)
                .overlay {
                    LinearGradient(colors: [.clear, .black.opacity(0.7)], startPoint: .top, endPoint: .bottom)
                }
                .overlay(alignment: .topLeading) {
                    if !dismissButtonInTabBar {
                        dismissButton
                            .matchedGeometryEffect(id: "Dismiss", in: namespace, properties: .position)
                            .offset(y: safeAreaInsets.top)
                    }
                }
                .clipShape(Rectangle())
                .offset(y: -frame.minY)
                .onChange(of: height) { value in
                    withAnimation {
                        if value < safeAreaInsets.top {
                            dismissButtonInTabBar = true
                        } else {
                            dismissButtonInTabBar = false
                        }
                    }
                }
        }
        .frame(height: 300)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
