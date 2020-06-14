//
//  ContentView.swift
//  Ambar
//
//  Created by Anagh Sharma on 12/11/19.
//  Copyright © 2019 Golden Chopper. All rights reserved.
//

import SwiftUI
import AppKit
extension NSTextField {
    open override var focusRingType: NSFocusRingType {
        get { .none }
        set { }
    }
}

struct IndexedHostEntry {
    var hostEntry: HostEntry;
    var index: Int;
}
struct ContentView: View {
    private var backgroundColor = Color(NSColor.windowBackgroundColor)
    @State var searchText: String = ""
    @State var hosts: [HostEntry] = ([HostEntry("192.168.1.1   localhost  flarp"),
                                      HostEntry("192.168.1.1   localhost  flarp"),
                                      HostEntry("192.168.1.1   localhost  flarp"),
                                      HostEntry("192.168.1.1   localhost  flarp"),
                                      HostEntry("192.168.1.1   localhost  flarp"),
                                      HostEntry("192.168.1.1   localhost  flarp"),
                                      HostEntry("192.168.1.1   localhost  flarp"),
                                      HostEntry("192.168.1.1   localhost  flarp"),
                                      HostEntry("192.168.1.1   localhost  flarp"),
                                      HostEntry("192.168.1.1   localhost  flarp"),
                                      HostEntry("192.168.1.1   localhost  flarp"),
                                      HostEntry("192.168.1.1   localhost  flarp"),
                                      HostEntry("192.168.1.1   localhost  flarp"),
                                      HostEntry("192.168.1.1   localhost  flarp"),
                                      HostEntry("192.168.1.1   localhost  flarp"),
                                      HostEntry("192.168.1.1   localhost  flarp"),
                                      HostEntry("192.168.1.1   localhost  flarp")])
    
    var body: some View {
        
        let filteredHosts = self.hosts.enumerated().map { (index, item) -> IndexedHostEntry in
            return IndexedHostEntry(hostEntry: item, index: index)
        }.filter { (he: IndexedHostEntry) -> Bool in
            if(searchText.count == 0) {
                return true;
            }
            return he.hostEntry.description.uppercased().contains(searchText.uppercased())
        }
        
        return VStack(alignment: .leading, spacing: 0) {
            HStack {
                Image("search").resizable().opacity(0.5)
                    .frame(width: 14, height: 14)
                    .padding(.leading, 10)
                TextField("Search or Insert", text: $searchText)
                    .textFieldStyle(PlainTextFieldStyle())
                    .foregroundColor(.primary)
                    .padding(5)
                if(self.searchText.count > 0) {
                Button(action: {
                    self.hosts.insert(HostEntry(self.searchText), at: 0)
                    self.searchText = ""
                    
                }) {
                    Text("Insert")
                }
                Spacer()
                }
            }.foregroundColor(.secondary)
                .background(backgroundColor)
            if(filteredHosts.count > 0) {
            ScrollView {
                ForEach(filteredHosts, id:\.index) { fh in
                    return HostEntryView(hostEntry: Binding<HostEntry>(
                        get: {
                            return self.hosts[fh.index]
                    },
                        set: {
                            self.hosts[fh.index] = $0
                    }
                    )).onDelete {
                        self.hosts.remove(at: fh.index)
                    }
                    
                }
            }.padding(5).frame(width: 500, height: 400, alignment: .top)
            } else {
                VStack(alignment: .center) {
                    Text("No Entries")
                        .font(.title)
                        .multilineTextAlignment(.center)
                }
                .frame(width: 500.0, height: 100.0)
            }

        }
        .padding(0)
                .frame(width: 500.0, alignment: .top)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
