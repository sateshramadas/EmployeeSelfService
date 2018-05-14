//
//  CalenderViewController.swift
//  EmployeeSelfService
//
//  Created by Satesh Ramadas on 5/12/18.
//  Copyright © 2018 GreenBins. All rights reserved.
//

import Foundation
import UIKit
import JTAppleCalendar

class CalendarViewController : UIViewController{
    let formatter = DateFormatter()
    @IBOutlet weak var monthOfCalendar: UILabel!
    
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var yearOfCalendar: UILabel!
    
    override func viewDidLoad() {
        setupCalendarView()
        self.navigationItem.title =  "TimeSheets"
    }
    func setupCalendarView(){
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        calendarView.visibleDates { (visibleDates) in
            self.setupViewsOfCalendar(from: visibleDates)
        }
    }
    
    
}

extension CalendarViewController: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource{
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let myCustomCell = cell as! CustomCell
        buildACellForDisplay(myCustomCell: myCustomCell, cellState: cellState, date: date)
        handleCellTextColor(cell: myCustomCell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let myCustomCell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        buildACellForDisplay(myCustomCell: myCustomCell, cellState: cellState, date: date)
        handleCellTextColor(cell: myCustomCell, cellState: cellState)
        return myCustomCell
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        //set some default start and end dates for Calendar
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone   = Calendar.current.timeZone
        formatter.locale     = Calendar.current.locale
        
        let startDate = formatter.date(from: "2018 01 01")
        let endDate   = formatter.date(from: "2018 12 31")
        
        let parameters = ConfigurationParameters(startDate: startDate!, endDate: endDate!)
        return parameters
    }
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? CustomCell else {return}
        buildACellForDisplay(myCustomCell: validCell, cellState: cellState, date: date)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? CustomCell else {return}
        buildACellForDisplay(myCustomCell: validCell, cellState: cellState, date: date)
    }
    
    //General Cell Display Module and also change colors for indates, outdates and Current Month
    func buildACellForDisplay(myCustomCell: CustomCell, cellState: CellState, date: Date){
        myCustomCell.dateLabel.text = cellState.text
        if cellState.isSelected{
            myCustomCell.selectedView.isHidden = false
            myCustomCell.dateLabel.textColor = UIColor.black
        }else{
            myCustomCell.selectedView.isHidden = true
            myCustomCell.dateLabel.textColor = UIColor.white
        }
    }
    
    //TexColor change for selected and DeSelected Cells
    func handleCellTextColor(cell: JTAppleCell?, cellState: CellState){
        guard let validCell = cell as? CustomCell else { return }
        
        if cellState.dateBelongsTo == .thisMonth{
            validCell.dateLabel.textColor = UIColor.white
        }else{
            validCell.dateLabel.textColor = UIColor.gray
        }
    }
    
    //This is to change the month and date
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalendar(from: visibleDates)
    }
    
    //SetupViewsOfCalendar
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo){
        let date = visibleDates.monthDates.first!.date
        
        formatter.dateFormat = "yyyy"
        yearOfCalendar.text = formatter.string(from: date)
        
        formatter.dateFormat = "MMMM"
        monthOfCalendar.text = formatter.string(from: date)
    }
    
}
