//
//  RowWithStepper.swift
//  RestaurantParts
//
//  Created by Igor Malyarov on 11.10.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct RowWithStepperDouble: View {
    var title: String
    var currency: Currency
    @Binding var amount: Double
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(currency.idd + amount.formattedGroupedWithDecimals)
                .foregroundColor(.orange)
            Stepper("Stepper for amount", onIncrement: {
                self.amount += 0.10
            }, onDecrement: {
                if self.amount > 0.10 {
                    self.amount -= 0.10
                }
            })
                .labelsHidden()
        }
    }
}

struct RowWithStepperPercentage: View {
    var title: String
    @Binding var amount: Double
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(amount.formattedPercentageWithDecimals)
                .foregroundColor(.orange)
            Stepper("Stepper for amount", onIncrement: {
                self.amount += 0.001
            }, onDecrement: {
                if self.amount > 0.001 {
                    self.amount -= 0.001
                }
            })
                .labelsHidden()
        }
    }
}


struct RowWithStepperInt: View {
    var title: String
    var currency: Currency
    @Binding var amount: Int
    
    var body: some View {
        HStack {
            Text(title)
            Spacer()
            Text(currency.idd + amount.formattedGrouped)
                .foregroundColor(.orange)
            Stepper("Stepper for amount", onIncrement: {
                self.amount += 1
            }, onDecrement: {
                if self.amount > 1 {
                    self.amount -= 1
                }
            })
                .labelsHidden()
        }
    }
}


struct RowWithStepper_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Form {
                RowWithStepperPercentage(title: "Percentage", amount: .constant(0.3456))
                RowWithStepperDouble(title: "Double", currency: Currency.euro, amount: .constant(1_000.34))
                RowWithStepperInt(title: "Int", currency: Currency.usd, amount: .constant(100_000))
            }
        }
        .environment(\.sizeCategory, .extraLarge)
        .preferredColorScheme(.dark)
        .environmentObject(UserData())
    }
}
