//
//  ContentView.swift
//  Xcode14SheetWarningExample
//
//  Created by Alex Buck on 9/15/22.
//

import SwiftUI

enum PresentedSheetView: Int, Identifiable {
    var id: Int { return self.rawValue }
    
    case mySheetView
}

class ContentViewModel: ObservableObject {
    
    @Published var sheet: PresentedSheetView?

    func presentSheetButtonAction() {
        sheet = .mySheetView
    }
    
}

struct ContentView: View {
    
    @ObservedObject var viewModel: ContentViewModel
    
    var body: some View {
        Button(action: viewModel.presentSheetButtonAction) {
            Text("Present Sheet")
        }
        .sheet(item: $viewModel.sheet, content: { sheetView in
            switch sheetView {
            case .mySheetView:
                MySheetView()
            }
        })
    }
}

struct MySheetView: View {
    
    //using presentation mode instead of dismiss because Production app supports iOS 13
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        VStack(spacing: 40) {
            VStack {
                Text("Dismissing this sheet will print in the console the following warning:")
                Text("\"Publishing changes from within view updates is not allowed, this will cause undefined behavior.\"")
                    .foregroundColor(.red)
            }
            .multilineTextAlignment(.center)
            
            Button(action: { presentationMode.wrappedValue.dismiss() }) {
                Text("Dismiss Sheet")
            }
        }
    }
    
}
