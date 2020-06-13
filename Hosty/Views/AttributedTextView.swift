//
//  TextView.swift
//  Hosty
//
//  Created by Ahmed Shaaban on 6/6/20.
//  Copyright © 2020 Shaabs. All rights reserved.
//
import SwiftUI
import Foundation
import AppKit

struct AttributedTextView: NSViewRepresentable {
    typealias NSViewType = TokenTextView
    
    @Binding var attributedString: NSAttributedString;
    
    var onEditingChanged: () -> Void       = {}
    var onCommit        : () -> Void       = {}
    var onTextChange    : (NSAttributedString) -> Void = { _ in }

    
    func makeCoordinator() -> Coordinator {
           Coordinator(self)
    }

    func makeNSView(context: Context) -> TokenTextView {
        var view = TokenTextView()
        view.delegate = context.coordinator
        view.isEditable = true;
        
        return view;
    }

    func updateNSView(_ nsView: TokenTextView, context: Context) {
//        let ogCursor = nsView.selectedRanges;

//        nsView.stringValue = host.description
        nsView.attributedStringValue = self.attributedString;
//        nsView.selectedRanges = ogCursor;
//        nsView.selectedRanges = context.coordinator.selectedRanges


    }
}

extension AttributedTextView {
    class Coordinator: NSObject, NSTextFieldDelegate {
           var parent: AttributedTextView
           var selectedRanges: [NSValue] = []
           
           init(_ parent: AttributedTextView) {
               self.parent = parent
           }
           
        
           func textDidBeginEditing(_ notification: Notification) {
               guard let textView = notification.object as? NSTextField else {
                   return
               }
               
               self.parent.attributedString = textView.attributedStringValue
               self.parent.onEditingChanged()
           }
           
           func textDidChange(_ notification: Notification) {
               guard let textView = notification.object as? NSTextField else {
                   return
               }

               self.parent.attributedString = textView.attributedStringValue
           }
           
           func textDidEndEditing(_ notification: Notification) {
               guard let textView = notification.object as? NSTextField else {
                   return
               }
               
               self.parent.attributedString = textView.attributedStringValue
               self.parent.onCommit()
           }
       }
}
