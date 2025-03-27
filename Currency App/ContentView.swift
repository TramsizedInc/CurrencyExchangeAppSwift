//
//  ContentView.swift
//  Currency App
//
//  Created by Federico on 04/11/2021.
//

import SwiftUI
import Alamofire

struct ContentView: View {
    @State var currencyList = [String]()
    @State var input = "1000"
    @State var base = "HUF"
    @FocusState private var inputIsFocused: Bool
    
    //"https://api.exchangerate.host/latest?base=\(base)&amount=\(input)"
    func makeRequest(showAll: Bool, currencies: [String] = ["USD", "GBP", "EUR", "CHF","BGN","JPY","CZK","GBP",]) {
        apiRequest(url:"https://api.freecurrencyapi.com/v1/latest?apikey=fca_live_TlsIHGFiUp3LqNSgG9ZFRKmtnHgWmqbB7Gw5iGrG&currencies=EUR%2CUSD%2CCAD%2CCHF&base_currency=\(base)") { currency in
            //print("ContentView", currency.rates)
            var tempList = [String]()
            
            for currency in currency.data {
                
                if showAll {
                    tempList.append("\(currency.key) \(String(format: "%.7f",currency.value))")
                } else if currencies.contains(currency.key)  {
                    tempList.append("\(currency.key) \(String(format: "%.7f",currency.value))")
                }
                tempList.sort()
            }
            currencyList.self = tempList
            
        }
    }
    
    func makeConversion(){
        apiRequest(url:"https://api.freecurrencyapi.com/v1/latest?apikey=fca_live_TlsIHGFiUp3LqNSgG9ZFRKmtnHgWmqbB7Gw5iGrG&currencies=EUR%2CUSD%2CCAD%2CCHF&base_currency=\(base)") { currency in
            //print("ContentView", currency.rates)
            var tempList = [String]()
            
            for currency in currency.data {
                tempList.append("\(currency.key) \(String(format: "%.7f", Double(currency.value)*Double(input)!))")
                tempList.sort()
            }
            currencyList.self = tempList
            
        }
    }
    
    var body: some View {
        VStack() {
            HStack {
                Text("Currencies")
                    .font(.system(size: 30))
                    .bold()
                
                Image(systemName: "eurosign.circle.fill")
                    .font(.system(size: 30))
                    .foregroundColor(.blue)
                
            }
            List {
                ForEach(currencyList, id: \.self) { currency in
                    Text(currency)
                }
            }
            VStack {
                Rectangle()
                    .frame(height: 8.0)
                    .foregroundColor(.blue)
                    .opacity(0.90)
                TextField("Enter an amount" ,text: $input)
                    .padding()
                    .background(Color.gray.opacity(0.10))
                    .cornerRadius(20.0)
                    .padding()
                    .keyboardType(.decimalPad)
                    .focused($inputIsFocused)
                TextField("Enter a currency" ,text: $base)
                    .padding()
                    .background(Color.gray.opacity(0.10))
                    .cornerRadius(20.0)
                    .padding()
                    .focused($inputIsFocused)
                Button("Convert!") {
                    makeConversion()
                    inputIsFocused = false
                }.padding()
            }
            
        }.onAppear() {
            makeRequest(showAll: true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
