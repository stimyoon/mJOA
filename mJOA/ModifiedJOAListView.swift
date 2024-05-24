//
//  ModifiedJOAListView.swift
//  mJOA
//
//  Created by Tim Yoon on 5/23/24.
//

import SwiftUI
import SwiftData

struct ModifiedJOAListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var joaList: [ModifiedJOA]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(joaList) { joa in
                    NavigationLink {
                        ModifiedJOAView(mJOA: joa)
                    } label: {
                        VStack {
                            Text("\(joa.timestamp)")
                            Text("\(joa.scoreText)")
                        }
                    }
                }
            }
            .navigationTitle("JOAs")
            .toolbar {
                Button(action: {
                    addItem()
                }, label: {
                    Image(systemName: "plus")
                })
            }
        }
    }
    private func addItem() {
        withAnimation {
            let newItem = ModifiedJOA()
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(joaList[index])
            }
        }
    }
}

#Preview {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try! ModelContainer(for: ModifiedJOA.self, configurations: config)
    
    
    return ModifiedJOAListView()
        .modelContainer(container)
}
