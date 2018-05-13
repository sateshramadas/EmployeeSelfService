//
//  CalenderViewController.swift
//  EmployeeSelfService
//
//  Created by Satesh Ramadas on 5/12/18.
//  Copyright © 2018 GreenBins. All rights reserved.
//

import Foundation
import JTAppleCalendar

class CalendarViewController : UIViewController{
    let formatter = DateFormatter()    
}

extension CalendarViewController: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource{
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let myCustomCell = cell as! CustomCell
        myCustomCell.dateLabel.text = cellState.text
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let myCustomCell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        myCustomCell.dateLabel.text = cellState.text
        return myCustomCell
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone   = Calendar.current.timeZone
        formatter.locale     = Calendar.current.locale
        
        let startDate = formatter.date(from: "2018 01 01")
        let endDate   = formatter.date(from: "2018 12 31")
        
        let parameters = ConfigurationParameters(startDate: startDate!, endDate: endDate!)
        return parameters
    }
}
