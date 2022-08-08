//
//  ContentView.swift
//  testFrameworkApp
//
//  Created by Takeshi Komori on 2022/08/09.
//

import SwiftUI
import testFramework

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .padding()
            .onAppear {
                MyClass.test()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
