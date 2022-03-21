//
//  Calendar+RecurrenceRule.swift
//  
//
//  Created by nori on 2022/03/19.
//

import Foundation


extension Calendar {

    private func startDayOfWeekOfMonth(_ date: Date) -> Date { dateComponents([.calendar, .timeZone, .year, .month, .yearForWeekOfYear, .weekOfYear, .weekOfMonth], from: date).date! }

    private func startDayOfMonth(_ date: Date) -> Date { dateComponents([.calendar, .timeZone, .year, .month], from: date).date! }

    private func startDayOfYear(_ date: Date) -> Date { dateComponents([.calendar, .timeZone, .year], from: date).date! }

    private func hasNotExceededOccurrenceCount(_ count: Int, end: RecurrenceRule.End?) -> Bool {
        if let end = end, case let .occurrenceCount(occurrenceCount) = end {
            return count <= occurrenceCount
        }
        return true
    }

    private func matchesCycle(_ date: Date, of recurrenceRule: RecurrenceRule, occurenceDate: Date, end: RecurrenceRule.End?) -> Bool {
        if let end = end, case let .endDate(endDate) = end, endDate < date {
            return false
        }
        let interval: Int = recurrenceRule.interval
        switch recurrenceRule.frequency {
            case .daily:
                let day = self.dateComponents([.day], from: occurenceDate, to: date).day!
                let (count, remainder) = day.quotientAndRemainder(dividingBy: interval)
                return remainder == 0 && hasNotExceededOccurrenceCount(count, end: end)
            case .weekly:
                let weekOfMonth = self.dateComponents([.weekOfMonth], from: startDayOfWeekOfMonth(occurenceDate), to: date).weekOfMonth!
                guard weekOfMonth != 0 else { return true }
                let (count, remainder) = weekOfMonth.quotientAndRemainder(dividingBy: interval)
                return remainder == 0 && hasNotExceededOccurrenceCount(count, end: end)
            case .monthly:
                let month = self.dateComponents([.month], from: startDayOfMonth(occurenceDate), to: date).month!
                guard month != 0 else { return true }
                let (count, remainder) = month.quotientAndRemainder(dividingBy: interval)
                return remainder == 0 && hasNotExceededOccurrenceCount(count, end: end)
            case .yearly:
                let year = self.dateComponents([.year], from: startDayOfYear(occurenceDate), to: date).year!
                guard year != 0 else { return true }
                let (count, remainder) = year.quotientAndRemainder(dividingBy: interval)
                return remainder == 0 && hasNotExceededOccurrenceCount(count, end: end)
        }
    }

    public func contains(_ date: Date, in recurrenceRules: [RecurrenceRule], occurenceDate: Date) -> Bool {
        recurrenceRules.contains { contains(date, in: $0, occurenceDate: occurenceDate) }
    }

    public func contains(_ date: Date, in recurrenceRule: RecurrenceRule, occurenceDate: Date) -> Bool {
        let end: RecurrenceRule.End? = recurrenceRule.recurrenceEnd
        let isMatchingCycle = matchesCycle(date, of: recurrenceRule, occurenceDate: occurenceDate, end: end)
        switch recurrenceRule.frequency {
            case .daily: return isMatchingCycle
            case .weekly:
                if isMatchingCycle {
                    let weekday = self.dateComponents([.weekday], from: date).weekday!
                    if let daysOfTheWeek = recurrenceRule.daysOfTheWeek {
                        return  daysOfTheWeek.contains(where: { $0.dayOfTheWeek.rawValue == weekday })
                    }
                    return weekday == self.dateComponents([.weekday], from: occurenceDate).weekday!
                }
                return false
            case .monthly:
                if isMatchingCycle {
                    if let daysOfTheWeek = recurrenceRule.daysOfTheWeek {
                        let weekday = self.dateComponents([.weekday], from: date).weekday!
                        return daysOfTheWeek.contains { dayOfWeek in
                            if dayOfWeek.weekNumber != 0 {
                                let weekOfMonth = self.dateComponents([.weekOfMonth], from: date).weekOfMonth!
                                return dayOfWeek.weekNumber == weekOfMonth
                            }
                            return dayOfWeek.dayOfTheWeek.rawValue == weekday
                        }
                    } else if let daysOfTheMonth = recurrenceRule.daysOfTheMonth {
                        let day = self.dateComponents([.day], from: date).day!
                        return daysOfTheMonth.contains(where: { $0 == day })
                    }
                    let day = self.dateComponents([.day], from: date).day!
                    return day == self.dateComponents([.day], from: occurenceDate).day!
                }
                return false
            case .yearly:
                if isMatchingCycle {
                    if let monthsOfTheYear = recurrenceRule.monthsOfTheYear {
                        let month = self.dateComponents([.month], from: date).month!
                        let isMatching = monthsOfTheYear.contains(where: { $0.rawValue == month })
                        if let daysOfTheWeek = recurrenceRule.daysOfTheWeek {
                            let weekday = self.dateComponents([.weekday], from: date).weekday!
                            return daysOfTheWeek.contains { dayOfWeek in
                                if dayOfWeek.weekNumber != 0 {
                                    let weekOfMonth = self.dateComponents([.weekOfMonth], from: date).weekOfMonth!
                                    return dayOfWeek.weekNumber == weekOfMonth
                                }
                                return dayOfWeek.dayOfTheWeek.rawValue == weekday
                            } && isMatching
                        } else if let daysOfTheMonth = recurrenceRule.daysOfTheMonth {
                            let day = self.dateComponents([.day], from: date).day!
                            return daysOfTheMonth.contains(where: { $0 == day }) && isMatching
                        }
                        let day = self.dateComponents([.day], from: date).day!
                        return day == self.dateComponents([.day], from: occurenceDate).day! && isMatching
                    }
                }
                return false
        }
    }
}
