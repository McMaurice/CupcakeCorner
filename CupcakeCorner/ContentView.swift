//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Macmaurice Osuji on 4/13/23.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var order = Order()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select cake type", selection: $order.type) {
                        ForEach(Order.types.indices) {
                            Text(Order.types[$0])
                        }
                    }
                    Stepper("Number of cakes:      \(order.quantity)", value: $order.quantity, in: 3...20)
                }
                Section {
                    Toggle("Any special request", isOn: $order.specialRequestEnabled.animation())
                    
                    if order.specialRequestEnabled {
                        Toggle("Add Sprinkles", isOn: $order.addSprinkles)
                        Toggle("Add Extra frosting", isOn: $order.extraFrosting)
                    }
                }
                Section {
                    NavigationLink {
                        AddressView(order: order)
                    } label: {
                        Text("Deliver details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }//
    
}//

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
