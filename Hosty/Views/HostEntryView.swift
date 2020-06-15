//
//  HostGroupView.swift
//  Hosty
//
//  Created by Ahmed Shaaban on 6/3/20.
//  Copyright © 2020 Shaabs. All rights reserved.
//

import Foundation
//
//  ContentView.swift
//  Ambar
//
//  Created by Anagh Sharma on 12/11/19.
//  Copyright © 2019 Golden Chopper. All rights reserved.
//

import SwiftUI
import AppKit

struct HostEntryView: View {
    @Binding var hostEntry: HostEntry;
    @State var hovered: Bool = false;
    var delete:  (() -> Void)?
    var body: some View {
        let deleteStyle = IconButtonStyle(normalImage: Image("trash"),
                                          pressedImage: Image("trash-red"),
                                          width: 20.0, height: 20.0);
        let textVal = Binding<String>(
            get: {
                return self.hostEntry.description
        },
            set: {
                
                self.hostEntry = HostEntry($0)
                if let del = self.delete {
                    if($0.count == 0) {
                        del()
                        return;
                    }
                }
        }
        );
        
        return HStack {
            Toggle("", isOn: self.$hostEntry.enabled)
            NSTokenFieldControl(text: textVal)
            if self.delete != nil {
                Button(action: {
                    self.delete!()
                }){
                    Spacer()
                }.buttonStyle(deleteStyle).opacity(hovered ? 1 : 0)
                Spacer()
            }
        }.padding(.leading, 10).frame(height: 22).onHover { (hovered: Bool) in
            self.hovered = hovered;
        }
    }
}

extension HostEntryView {
    func onDelete(perform action: @escaping () -> Void ) -> Self {
        var copy = self
        copy.delete = action
        return copy
    }
}

struct HostEntryView_Previews: PreviewProvider {
    static var previews: some View {
        HostEntryView(hostEntry: Binding.constant(HostEntry("   192.168.1.1   localhost  flarp"))).onDelete {
            
        }
    }
    
}
