//
//  ObservableList.swift
//  SwiftUIPractice
//
//  Created by miori Lee on 2022/07/20.
//

import SwiftUI

struct ObservableList: View {
    @State private var value: String = ""
    
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        VStack {
            Text(viewModel.title)
                .font(.largeTitle)
            
            Button {
                viewModel.title = "안바뀌지"
            } label: {
                Text("Update Title")
            }
            .padding()
            
            HStack(spacing: 10) {
                TextField("Value", text: $value)
                    .textFieldStyle(.roundedBorder)
                    .padding()
                Button {
                    viewModel.list.insert(value, at: 0)
                    value = ""
                } label: {
                    Text("Add to List")
                }
                .padding()
            }
            List(viewModel.list, id:\.self) { item in
                Text(item)
            }

        }
    }
}

struct ObservableList_Previews: PreviewProvider {
    static var previews: some View {
        ObservableList()
    }
}
