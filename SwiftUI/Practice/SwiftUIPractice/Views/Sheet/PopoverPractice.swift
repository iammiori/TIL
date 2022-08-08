//
//  PopoverPractice.swift
//  SwiftUIPractice
//
//  Created by miori Lee on 2022/03/29.
//

import SwiftUI

struct PopoverPractice: View {
    @State private var showPopover : Bool = false
    var body: some View {
        Button {
            showPopover = true
        } label: {
            Text("Show Popover")
        }
        .padding()
        .popover(isPresented: $showPopover, attachmentAnchor: .rect(Anchor<CGRect>.Source.bounds)) {
//            FormLayout_Form()
//                .frame(minWidth: 320, minHeight: 520)
        }

    }
}

struct PopoverPractice_Previews: PreviewProvider {
    static var previews: some View {
        PopoverPractice()
    }
}
