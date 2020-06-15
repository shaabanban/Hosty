//
//  NSTokenFieldControl.swift
//  Hosty
//
//  Created by Ahmed Shaaban on 6/13/20.
//  Copyright © 2020 Shaabs. All rights reserved.
//

import Foundation
import AppKit
import SwiftUI

struct NSTokenFieldControl: NSViewRepresentable {
    @Binding var text: String;
    
    var disabled: Binding<Bool>?;

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    typealias NSViewType = NSTokenField
    
    
    func makeNSView(context: Context) -> NSTokenField {
        var view = NSTokenField()
        view.delegate = context.coordinator
        view.tokenizingCharacterSet = [" ", "\t"]
        view.stringValue = text;
        return view;
    }
    
    func updateNSView(_ nsView: NSTokenField, context: Context) {
        nsView.stringValue = text
        nsView.isEditable = disabled?.wrappedValue ?? true;
    }
    
}

extension NSTokenFieldControl {
    class Coordinator: NSObject, NSTokenFieldDelegate {
        var parent: NSTokenFieldControl
        
        init(_ parent: NSTokenFieldControl) {
            self.parent = parent
        }

        func tokenField(_ tokenField: NSTokenField, shouldAdd tokens: [Any], at index: Int) -> [Any] {
            // I don't like this hack... Basically it emits a change before adding tokens
            self.parent.text = tokenField.stringValue

            return tokens
        }
        
        func controlTextDidEndEditing(_ notification: Notification) {
            guard let textView = notification.object as? NSTokenField else {
                return
            }
            
            self.parent.text = textView.stringValue
        }
        
        
    }
}
