//
//  Restaurant.swift
//
//  Created by Igor Malyarov on 16.07.2019.
//  Copyright © 2019 Igor Malyarov. All rights reserved.
//

import SwiftUI

struct Restaurant: Identifiable, Codable, Hashable {
    var id = UUID()
    
    var name: String = "название ресторана"
    var projectName: String = "название проекта"
    
    var type: RestaurantType = .fullService
    var city = "город"
    
    var concept: String = "концепция"
    var description: String = "описание"
    var comment: String = "комментарий про ресторан"
    var status: Status = .idea
    
    var budget: Int = 100000
    var currency: Currency = .euro
    
    var insideSeating: Int = 80
    var outsideSeating: Int = 60
    
    var area: Int = 120
    var kitchenArea: Int = 60
    var totalArea: Int = 180
    
    var sales = Sales(meals: [])
    var opex = Opex(opexes: [])
    var capex = Capex(capexes: [])
    var kpi = KPI(kpis: [])
    
    var taxRate: Double = 0.30
    
    var modificationDate: Date = Date()
}

extension Restaurant {
    init(from restaurant: Restaurant) {
        self.name = restaurant.name
        self.projectName = restaurant.projectName
        
        self.type = restaurant.type
        self.city = restaurant.city
        
        self.concept = restaurant.concept
        self.description = restaurant.description
        self.comment = restaurant.comment
        self.status = restaurant.status
        
        self.budget = restaurant.budget
        self.currency = restaurant.currency
        
        self.insideSeating = restaurant.insideSeating
        self.outsideSeating = restaurant.outsideSeating
        
        self.area = restaurant.area
        self.kitchenArea = restaurant.kitchenArea
        self.totalArea = restaurant.totalArea
        
        self.sales = restaurant.sales
        self.opex = restaurant.opex
        self.capex = restaurant.capex
        self.kpi = restaurant.kpi
        
        self.taxRate = restaurant.taxRate
    }
}

extension Restaurant {
    init(projectName: String) {
        self.init()
        self.projectName = projectName
    }
    
    init(name: String, projectName: String) {
        self.init()
        self.name = name
        self.projectName = projectName
    }
}

extension Restaurant {
    var investment: Double { capex.capexes.reduce(0, { $0 + Double($1.amount) }) }
    
    //  MARK: может быть опция — включать kitchen salary в себестоимость или нет
    var grossProfitPerMonthDUMMY: Double { sales.revenuePerMonth - sales.cogsPerMonth}
    //  Full Production Cost
    var grossFPCProfitPerMonth: Double { sales.revenuePerMonth - sales.cogsPerMonth - salaryKitchenPerMonth}
    
    var salaryPerMonth: Double { Double(opex.opexes
        .filter { $0.type == .salaryKitchen || $0.type == .salaryExKitchen }
        .reduce(0, { $0 + $1.amount })) }
    
    var salaryKitchenPerMonth: Double { Double(opex.opexes
        .filter { $0.type == .salaryKitchen }
        .reduce(0, { $0 + $1.amount })) }
    
    var salaryExKitchenPerMonth: Double { Double(opex.opexes
        .filter { $0.type == .salaryExKitchen }
        .reduce(0, { $0 + $1.amount })) }
    
    var primeCostPerMonth: Double { sales.foodcostPerMonth + salaryPerMonth }
    
    var opExPerMonth: Double { Double(opex.opexes.reduce(0, { $0 + $1.amount})) }
    
    var capEx: Double { Double(capex.capexes.reduce(0, { $0 + $1.amount})) }
    
    //  https://pos.toasttab.com/blog/restaurant-profit-and-loss-statement
    var occupancyCostsPerMonth: Double { Double(opex.opexes
        .filter { $0.type == .rent }
        .reduce(0, { $0 + $1.amount })) }
    
    var rentPerMonth: Double { occupancyCostsPerMonth }
    
    var utilitiesPerMonth: Double { Double(opex.opexes
        .filter { $0.type == .utilities }
        .reduce(0, { $0 + $1.amount })) }
    
    var marketingPerMonth: Double { Double(opex.opexes
        .filter { $0.type == .marketing }
        .reduce(0, { $0 + $1.amount })) }
    
    var otherOpExPerMonth: Double { Double(opex.opexes
        .filter { $0.type == .other }
        .reduce(0, { $0 + $1.amount })) }
    
    var depreciationPerMonth: Double { capex.capexes
        .reduce(0, { $0 + $1.depreciationPerMonth }) }
    
    var ebitPerMonth: Double { sales.revenuePerMonth - sales.foodcostPerMonth - opExPerMonth - depreciationPerMonth }
    
    var ebitdaPerMonth: Double { sales.revenuePerMonth - sales.foodcostPerMonth - opExPerMonth }
    
    var taxPerMonth: Double { if ebitPerMonth > 0 { return ebitPerMonth * taxRate } else { return 0 } }
    
    var profitPerMonth: Double { ebitPerMonth - taxPerMonth }
    
    var cashEarningsPerMonth: Double { profitPerMonth + depreciationPerMonth }
}

extension Restaurant {
    var profitPerYear: Double { profitPerMonth * 12 }
    var cashEarningsPerYear: Double { cashEarningsPerMonth * 12 }
}

extension Restaurant {
    var reports: [Report] {
        [
            profitAndLossExtrasReport,
            operatingExpensesReport,
            
            
            cashEarningsReport,
            profitAndLoss4PartsReport,
            profitAndLossReport,
            profitAndLossReportFPC
        ]
    }
}

extension Restaurant {
    var revenue: Double { sales.revenuePerMonth }
    var foodcost: Double { sales.foodcostPerMonth }
    var expenses: Double { opExPerMonth - salaryPerMonth + depreciationPerMonth + taxPerMonth }
    var opExForPandL: Double { opExPerMonth - salaryKitchenPerMonth }
    
    var cashEarningsReport: Report {
        Report(name: "Investment and Cash Flow",
               description: "Owner's perspective",
               lines: [ReportLine(title: "Investment",
                                  subtitle: "CAPEX and Working Capital, total",
                                  detail: currency.idd + investment.formattedGrouped,
                                  subdetail: ""),
                       ReportLine(title: "Net Profit, per year",
                                  subtitle: "per month",
                                  detail: currency.idd +    profitPerYear.formattedGrouped,
                                  subdetail: currency.idd + profitPerMonth.formattedGrouped),
                       ReportLine(title: "Cash Earnings, per year",
                                  subtitle: "Net Profit + D&A, per month",
                                  detail: currency.idd +    cashEarningsPerYear.formattedGrouped,
                                  subdetail: currency.idd + cashEarningsPerMonth.formattedGrouped),
                       ReportLine(title: "", subtitle: "", detail: "", subdetail: ""),
                       
                       ReportLine(title: cashEarningsPerMonth > 0 ? "Investment Return in" : "No data or negative Cash Earnings",
                                  subtitle: cashEarningsPerMonth > 0 ? "Estimation of the project ramp up period of 6 months is added." : "",
                                  detail: cashEarningsPerMonth > 0 ? (investment / cashEarningsPerMonth).rounded(.up).formattedGrouped + "-" + (investment / cashEarningsPerMonth + 6).rounded(.up).formattedGrouped + " months" : "",
                                  subdetail: "")
        ])
    }
    
    var profitAndLoss4PartsReport: Report {
        if revenue > 0 {
            return Report(name: "P&L: \"4 Pieces of the Pie\"",
                          description: "Simplistic Profit and Loss Statement, monthly",
                          lines: [
                            ReportLine(title: "Revenue (sales), ex VAT",
                                       subtitle: "\(sales.noOfActiveRevenueStreams) active revenue streams (\(sales.noOfRevenueStreams) total)",
                                detail: currency.idd + revenue.formattedGrouped,
                                subdetail: ""),
                            ReportLine(title: "", subtitle: "", detail: "", subdetail: ""),
                            ReportLine(title: "Foodcost",
                                       subtitle: "Food and beverages cost (GOGS)",
                                       detail: currency.idd + foodcost.formattedGrouped,
                                       subdetail: (foodcost / revenue).formattedPercentageWithDecimals),
                            ReportLine(title: "Salary",
                                       subtitle: "Payroll Expenses, total",
                                       detail: currency.idd + salaryPerMonth.formattedGrouped,
                                       subdetail: (salaryPerMonth / revenue).formattedPercentageWithDecimals),
                            ReportLine(title: "Expenses, ex Salary",
                                       subtitle: "Rent, Other OpEx, D&A, Tax",
                                       detail: currency.idd + expenses.formattedGrouped,
                                       subdetail: (expenses / revenue).formattedPercentageWithDecimals),
                            ReportLine(title: "Net Profit/Loss",
                                       subtitle: "",
                                       detail: currency.idd + profitPerMonth.formattedGrouped,
                                       subdetail: (profitPerMonth / revenue).formattedPercentageWithDecimals),
                            ReportLine(title: "",
                                       subtitle: "Note: All data is ex VAT (\"netto\").",
                                       detail: "",
                                       subdetail: "")
            ])
        } else {
            return Report(name: "P&L: 4 Pieces of the Pie report is not available", description: "No Revenue Streams Yet", lines: [])
        }
    }
    
    var profitAndLossReport: Report {
        if revenue > 0 {
            return Report(name: "P&L",
                          description: "Profit and Loss Statement, monthly",
                          lines: [
                            ReportLine(title: "Revenue (sales), ex VAT",
                                       subtitle: "\(sales.noOfActiveRevenueStreams) active revenue streams (\(sales.noOfRevenueStreams) total)",
                                detail: currency.idd + revenue.formattedGrouped,
                                subdetail: ""),
                            //                            ReportLine(title: "", subtitle: "", detail: "", subdetail: ""),
                            
                            ReportLine(title: "Foodcost",
                                       subtitle: "Food and beverages cost (GOGS)",
                                       detail: currency.idd + foodcost.formattedGrouped,
                                       subdetail: (foodcost / revenue).formattedPercentageWithDecimals),
                            
                            ReportLine(title: "", subtitle: "", detail: "", subdetail: ""),
                            
                            ReportLine(title: "Gross Profit",
                                       subtitle: "Gross Margin",
                                       detail: currency.idd + grossProfitPerMonthDUMMY.formattedGrouped,
                                       subdetail: (grossProfitPerMonthDUMMY / revenue).formattedPercentageWithDecimals),
                            
                            ReportLine(title: "Operating Expenses",
                                       subtitle: "Ex D&A",
                                       detail: currency.idd + opExPerMonth.formattedGrouped,
                                       subdetail: (opExPerMonth / revenue).formattedPercentageWithDecimals),
                            
                            //                            //  https://pos.toasttab.com/blog/restaurant-profit-and-loss-statement
                            //                            ReportLine(title: "Occupancy Costs",
                            //                                       subtitle: "Fixed overhead (Rent, etc.)",
                            //                                       detail: currency.idd + occupancyCostsPerMonth.formattedGrouped,
                            //                                       subdetail: (occupancyCostsPerMonth / revenue).formattedPercentageWithDecimals),
                            
                            
                            ReportLine(title: "Depreciation and Amortization",
                                       subtitle: "Including items with 1 year lifetime",
                                       detail: currency.idd + depreciationPerMonth.formattedGrouped,
                                       subdetail: (depreciationPerMonth / revenue).formattedPercentageWithDecimals),
                            
                            ReportLine(title: "", subtitle: "", detail: "", subdetail: ""),
                            
                            ReportLine(title: "EBIT",
                                       subtitle: "Operating Margin",
                                       detail: currency.idd + ebitPerMonth.formattedGrouped,
                                       subdetail: (ebitPerMonth / revenue).formattedPercentageWithDecimals),
                            
                            ReportLine(title: "Tax",
                                       subtitle: "All Corporate Income Taxes",
                                       detail: currency.idd + taxPerMonth.formattedGrouped,
                                       subdetail: (taxPerMonth / revenue).formattedPercentageWithDecimals),
                            
                            ReportLine(title: "", subtitle: "", detail: "", subdetail: ""),
                            
                            ReportLine(title: "Net Profit/Loss",
                                       subtitle: "",
                                       detail: currency.idd + profitPerMonth.formattedGrouped,
                                       subdetail: (profitPerMonth / revenue).formattedPercentageWithDecimals),
                            ReportLine(title: "",
                                       subtitle: "Note: All data is ex VAT (\"netto\"). Percentage to Revenue.",
                                       detail: "",
                                       subdetail: "")
            ])
        } else {
            return Report(name: "Profit and Loss Statement is not available", description: "No Revenue Streams Yet", lines: [])
        }
    }
    
    var profitAndLossReportFPC: Report {
        if revenue > 0 {
            return Report(name: "P&L (Full Production Cost)",
                          description: "Salary Kitchen as part of Production Cost, monthly",
                          lines: [
                            ReportLine(title: "Revenue (sales), ex VAT",
                                       subtitle: "\(sales.noOfActiveRevenueStreams) active revenue streams (\(sales.noOfRevenueStreams) total)",
                                detail: currency.idd + revenue.formattedGrouped,
                                subdetail: ""),
                            //                            ReportLine(title: "", subtitle: "", detail: "", subdetail: ""),
                            
                            ReportLine(title: "Foodcost",
                                       subtitle: "Food and beverages cost (GOGS)",
                                       detail: currency.idd + foodcost.formattedGrouped,
                                       subdetail: (foodcost / revenue).formattedPercentageWithDecimals),
                            
                            ReportLine(title: "Salary Kitchen",
                                       subtitle: "(as part of Production cost)",
                                       
                                       detail: currency.idd + salaryKitchenPerMonth.formattedGrouped,
                                       subdetail: (salaryKitchenPerMonth / revenue).formattedPercentageWithDecimals),
                            
                            ReportLine(title: "", subtitle: "", detail: "", subdetail: ""),
                            
                            ReportLine(title: "Gross Profit",
                                       subtitle: "Gross Margin",
                                       detail: currency.idd + grossFPCProfitPerMonth.formattedGrouped,
                                       subdetail: (grossFPCProfitPerMonth / revenue).formattedPercentageWithDecimals),
                            
                            ReportLine(title: "Operating Expenses",
                                       subtitle: "ex Salary Kitchen",
                                       detail: currency.idd + opExForPandL.formattedGrouped,
                                       subdetail: (opExForPandL / revenue).formattedPercentageWithDecimals),
                            
                            //                            //  https://pos.toasttab.com/blog/restaurant-profit-and-loss-statement
                            //                            ReportLine(title: "Occupancy Costs",
                            //                                       subtitle: "Fixed overhead (Rent, etc.)",
                            //                                       detail: currency.idd + occupancyCostsPerMonth.formattedGrouped,
                            //                                       subdetail: (occupancyCostsPerMonth / revenue).formattedPercentageWithDecimals),
                            
                            
                            ReportLine(title: "Depreciation and Amortization",
                                       subtitle: "Including items with 1 year lifetime",
                                       detail: currency.idd + depreciationPerMonth.formattedGrouped,
                                       subdetail: (depreciationPerMonth / revenue).formattedPercentageWithDecimals),
                            
                            ReportLine(title: "", subtitle: "", detail: "", subdetail: ""),
                            
                            ReportLine(title: "EBIT",
                                       subtitle: "Operating Margin",
                                       detail: currency.idd + ebitPerMonth.formattedGrouped,
                                       subdetail: (ebitPerMonth / revenue).formattedPercentageWithDecimals),
                            
                            ReportLine(title: "Tax",
                                       subtitle: "All Corporate Income Taxes",
                                       detail: currency.idd + taxPerMonth.formattedGrouped,
                                       subdetail: (taxPerMonth / revenue).formattedPercentageWithDecimals),
                            
                            ReportLine(title: "", subtitle: "", detail: "", subdetail: ""),
                            
                            ReportLine(title: "Net Profit/Loss",
                                       subtitle: "",
                                       detail: currency.idd + profitPerMonth.formattedGrouped,
                                       subdetail: (profitPerMonth / revenue).formattedPercentageWithDecimals),
                            ReportLine(title: "",
                                       subtitle: "Note: All data is ex VAT (\"netto\"). Percentage to Revenue.",
                                       detail: "",
                                       subdetail: "")
            ])
        } else {
            return Report(name: "Profit and Loss Statement is not available", description: "No Revenue Streams Yet", lines: [])
        }
    }
    
    var profitAndLossExtrasReport: Report {
        if revenue > 0 {
            return Report(name: "P&L Ratios",
                          description: "",
                          lines: [ReportLine(title: "Prime Cost",
                                             subtitle: "Foodcost + Salary",
                                             detail: currency.idd + (foodcost + salaryPerMonth).formattedGrouped,
                                             subdetail: ((foodcost + salaryPerMonth) / revenue).formattedPercentageWithDecimals),
                                  ReportLine(title: "EBITDA",
                                             subtitle: "",
                                             detail: currency.idd + ebitPerMonth.formattedGrouped,
                                             subdetail: (ebitPerMonth / revenue).formattedPercentageWithDecimals)
                            
            ])
        } else {
            return Report(name: "Profit and Loss Extras report is not available", description: "No Revenue Streams Yet", lines: [])
        }
    }
    
    var operatingExpensesReport: Report {
        if revenue > 0 {
            return Report(name: "Operating Expenses",
                          description: "OpEx, monthly. Ratio to Revenue",
                          lines: [ReportLine(title: "Total OpEx",
                                             subtitle: "Operating Expenses",
                                             detail: currency.idd + opExPerMonth.formattedGrouped,
                                             subdetail: (opExPerMonth / revenue).formattedPercentageWithDecimals),
                                  ReportLine(title: "Salary",
                                             subtitle: "All Payroll Expenses",
                                             detail: currency.idd + salaryPerMonth.formattedGrouped,
                                             subdetail: (salaryPerMonth / revenue).formattedPercentageWithDecimals),
                                  ReportLine(title: "Occupancy Costs",
                                             subtitle: "Rent, etc",
                                             detail: currency.idd + occupancyCostsPerMonth.formattedGrouped,
                                             subdetail: (occupancyCostsPerMonth / revenue).formattedPercentageWithDecimals),
                                  ReportLine(title: "Utilities",
                                             subtitle: "Utilities",
                                             detail: currency.idd + utilitiesPerMonth.formattedGrouped,
                                             subdetail: (utilitiesPerMonth / revenue).formattedPercentageWithDecimals),
                                  ReportLine(title: "Marketing",
                                             subtitle: "Marketing",
                                             detail: currency.idd + marketingPerMonth.formattedGrouped,
                                             subdetail: (marketingPerMonth / revenue).formattedPercentageWithDecimals),
                                  ReportLine(title: "Other OpEx",
                                             subtitle: "OtherOpEx",
                                             detail: currency.idd + otherOpExPerMonth.formattedGrouped,
                                             subdetail: (otherOpExPerMonth / revenue).formattedPercentageWithDecimals),
                                  ReportLine(title: "", subtitle: "", detail: "", subdetail: ""),
                                  ReportLine(title: "non Salary OpEx",
                                             subtitle: "OpEx without Payroll Expenses",
                                             detail: currency.idd + (opExPerMonth - salaryPerMonth).formattedGrouped,
                                             subdetail: ((opExPerMonth - salaryPerMonth) / revenue).formattedPercentageWithDecimals),
                                  ReportLine(title: "", subtitle: "", detail: "", subdetail: ""),
                                  ReportLine(title: "Salary",
                                             subtitle: "Incl Payroll Expenses to OpEx",
                                             detail: currency.idd + salaryPerMonth.formattedGrouped,
                                             subdetail: (salaryPerMonth / opExPerMonth).formattedPercentageWithDecimals),
                                  ReportLine(title: "Salary Kitchen",
                                             subtitle: "to Salary Total",
                                             detail: currency.idd + salaryKitchenPerMonth.formattedGrouped,
                                             subdetail: (salaryKitchenPerMonth / salaryPerMonth).formattedPercentageWithDecimals),
                                  ReportLine(title: "Salary ex Kitchen",
                                             subtitle: "to Salary Total",
                                             detail: currency.idd + salaryExKitchenPerMonth.formattedGrouped,
                                             subdetail: (salaryExKitchenPerMonth / salaryPerMonth).formattedPercentageWithDecimals)
            ])
        } else {
            return Report(name: "Operating Expenses report is not available", description: "No Revenue Streams Yet", lines: [])
        }
    }
}
