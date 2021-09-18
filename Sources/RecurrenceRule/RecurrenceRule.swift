//
//  RecurrenceRule.swift
//  RecurrenceRule
//
//  Created by nori on 2021/08/31.
//

import Foundation

public struct RecurrenceRule: Codable {

    public enum Frequency: String, Codable, CaseIterable, Hashable {
        case daily
        case weekly
        case monthly
        case yearly

        public var text: String {
            switch self {
                case .daily: return "day"
                case .weekly: return "week"
                case .monthly: return "month"
                case .yearly: return "year"
            }
        }
    }

    public enum Weekday: Int, Codable, CaseIterable, Hashable {
        case sunday = 1
        case monday = 2
        case tuesday = 3
        case wednesday = 4
        case thursday = 5
        case friday = 6
        case saturday = 7

        public var text: String {
            switch self {
                case .sunday: return "sunday"
                case .monday: return "monday"
                case .tuesday: return "tuesday"
                case .wednesday: return "wednesday"
                case .thursday: return "thursday"
                case .friday: return "friday"
                case .saturday: return "saturday"
            }
        }
    }

    public enum Month: Int, Codable, CaseIterable, Hashable {
        case january = 1
        case february = 2
        case march = 3
        case april = 4
        case may = 5
        case june = 6
        case july = 7
        case august = 8
        case september = 9
        case october = 10
        case november = 11
        case december = 12

        public var text: String {
            switch self {
                case .january: return "january"
                case .february: return "february"
                case .march: return "march"
                case .april: return "april"
                case .may: return "may"
                case .june: return "june"
                case .july: return "july"
                case .august: return "august"
                case .september: return "september"
                case .october: return "october"
                case .november: return "november"
                case .december: return "december"
            }
        }
    }

    public struct DayOfWeek: Codable, Hashable {
        public var dayOfTheWeek: Weekday
        public var weekNumber: Int

        public init(dayOfTheWeek: Weekday, weekNumber: Int = 0) {

            /// Values are from 1 to 7, with Sunday being 1.
            self.dayOfTheWeek = dayOfTheWeek

            /// Values range from –53 to 53.
            self.weekNumber = weekNumber
        }
    }

    public enum End: Codable, Hashable {
        case endDate(Date)
        case occurrenceCount(Int)
    }

    public var frequency: Frequency

    public var recurrenceEnd: End?

    public var interval: Int

    /// Values of 1 to 7 correspond to Sunday through Saturday. A value of 0 indicates that this property is not set for the recurrence rule.
    public var firstDayOfTheWeek: Int = 0       // 何曜日

    /// This property value is valid only for recurrence rules that were initialized with specific days of the week and a frequency type of Weekly, Monthly, or Yearly.
    public var daysOfTheWeek: [DayOfWeek]?      // 第何週

    /// Values can be from 1 to 31 and from -1 to -31.
    public var daysOfTheMonth: [Int]?           // 月の何日目

    /// Values can be from 1 to 366 and from -1 to -366.
    public var daysOfTheYear: [Int]?            // 年の何日目

    /// Values can be from 1 to 53 and from -1 to -53.
    public var weeksOfTheYear: [Int]?           // 年の何週目

    /// Values can be from 1 to 12.
    public var monthsOfTheYear: [Month]?          // 年の何ヶ月目

    public init(
        frequency: Frequency,
        recurrenceEnd: End? = nil,
        interval: Int,
        firstDayOfTheWeek: Int = 0,
        daysOfTheWeek: [DayOfWeek]? = nil,
        daysOfTheMonth: [Int]? = nil,
        daysOfTheYear: [Int]? = nil,
        weeksOfTheYear: [Int]? = nil,
        monthsOfTheYear: [Month]? = nil
    ) {
        self.frequency = frequency
        self.recurrenceEnd = recurrenceEnd
        self.interval = interval
        self.firstDayOfTheWeek = firstDayOfTheWeek
        self.daysOfTheWeek = daysOfTheWeek
        self.daysOfTheMonth = daysOfTheMonth
        self.daysOfTheYear = daysOfTheYear
        self.weeksOfTheYear = weeksOfTheYear
        self.monthsOfTheYear = monthsOfTheYear
    }
}

extension RecurrenceRule.End {

    enum CodingKeys: CodingKey {
        case endDate
        case occurrenceCount
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        switch self {
            case .endDate(let date):
                try container.encode(date, forKey: .endDate)
            case .occurrenceCount(let count):
                try container.encode(count, forKey: .occurrenceCount)
        }
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let key = container.allKeys.first
        switch key {
            case .endDate:
                let date = try container.decode(Date.self, forKey: .endDate)
                self = .endDate(date)
            case .occurrenceCount:
                let count = try container.decode(Int.self, forKey: .occurrenceCount)
                self = .occurrenceCount(count)
            default:
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        codingPath: container.codingPath,
                        debugDescription: "Unabled to decode enum."
                    )
                )
        }
    }
}

extension RecurrenceRule: Hashable {

    public static func == (lhs: RecurrenceRule, rhs: RecurrenceRule) -> Bool {
        lhs.hashValue == rhs.hashValue
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(frequency)
        hasher.combine(recurrenceEnd)
        hasher.combine(interval)
        hasher.combine(firstDayOfTheWeek)
        hasher.combine(daysOfTheWeek)
        hasher.combine(daysOfTheMonth)
        hasher.combine(daysOfTheYear)
        hasher.combine(weeksOfTheYear)
        hasher.combine(monthsOfTheYear)
    }
}
