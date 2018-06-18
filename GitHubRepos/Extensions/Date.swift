//
//  Date.swift
//  GitHubRepos
//
//  Created by admin on 18/06/2018.
//  Copyright © 2018 Aviv Eyal. All rights reserved.
//

import Foundation
extension Date {
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var lastWeek: Date {
        return Calendar.current.date(byAdding: .day, value: -7, to: noon)!
    }
    var lastMonth: Date {
        return Calendar.current.date(byAdding: .month, value: -1, to: noon)!
    }
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return tomorrow.month != month
    }
}
