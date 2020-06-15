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
    var id: UUID
}
struct ContentView: View {
    private var backgroundColor = Color(NSColor.windowBackgroundColor)
    
    @State var searchText: String = ""
    @State var hosts: [HostEntry] = ([HostEntry("192.168.1.1   localhost  flarp"),
                                      HostEntry("192.168.1.2   flerbo.com.eg  flarp"),
                                      HostEntry("192.168.1.3   carpe.diem  flarp"),
                                      HostEntry("192.168.1.4   google.com"),
                                      HostEntry("192.168.1.5   auth.test.com"),
                                      HostEntry("192.168.1.6   localhost"),
                                      HostEntry("192.168.1.7   localhost")
    ])
    
    var body: some View {
        
        let filteredHosts = self.hosts.enumerated().map { (index, item) -> IndexedHostEntry in
            return IndexedHostEntry(hostEntry: item, index: index, id: UUID())
        }.filter { (he: IndexedHostEntry) -> Bool in
            if(searchText.count == 0) {
                return true;
            }
            return he.hostEntry.description.uppercased().contains(searchText.uppercased())
        }
        let containerHeight = min(CGFloat( 30.0 * Double(filteredHosts.count)+10),500)
        
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
            VStack(){
            if(filteredHosts.count > 0) {
                ScrollView {
                    ForEach(filteredHosts, id:\.index) { fh in
                        return HostEntryView(hostEntry: Binding<HostEntry>(
                            get: {
                                return self.hosts[fh.index]
                        },
                            set: {
                                // this is to handle the case when the delete happens before an edit is processed
                                // this is still the wrong way to do this
                                if(filteredHosts.contains(where: { (ih: IndexedHostEntry) -> Bool in
                                    ih.id == fh.id
                                })) {
                                    if(fh.index <= self.hosts.count - 1){
                                        self.hosts[fh.index] = $0
                                    }
                                }
                        }
                        ), disabled: Binding.constant(false)).onDelete {
                            // I realize that this approach is just asking for trouble
                            // TODO: Persist UUID as part of host entry state, and use the uiud for all edit / delete ops
                            if(fh.index <= self.hosts.count - 1){
                                self.hosts.remove(at: fh.index)
                            }
                        }.animation(.none)
                        
                    }
                }.padding(5).frame(width: 500, height: containerHeight, alignment: .top)
            } else {
                VStack(alignment: .center) {
                    Text("No Entries")
                        .font(.title)
                        .multilineTextAlignment(.center)
                }
                .frame(width: 500.0, height: 100.0)
               
            }
            }.animation(.easeInOut(duration: 0.28))

            
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
