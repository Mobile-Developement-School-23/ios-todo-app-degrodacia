//
//  ViewController.swift
//  TodoList
//
//  Created by Егор Черняев on 15.06.2023.
//

import UIKit


class TaskViewController:
    UIViewController{
    

    
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var toDoTask: UITextView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var choosePriority: UISegmentedControl!
    @IBOutlet weak var deadlineSwitch: UISwitch!
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var priorityLabel: UILabel!
    @IBOutlet weak var deadlineLabel: UILabel!
    @IBOutlet weak var dividerView: UIView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var deadlineButton: UIButton!
    
    
    
    
    
    
    
    

    
    
    
    
    
    
    
    
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func deadlineSwitchValueChanged(_ sender: UISwitch) {
        deadlineButton.isHidden = !sender.isOn
        deadlineButton.isEnabled = sender.isOn
//        if sender.isOn{
//            NSLayoutConstraint.activate([
//                deadlineLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 8),
//                deadlineLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
//                deadlineLabel.trailingAnchor.constraint(equalTo: deadlineSwitch.leadingAnchor, constant: 173),
//                deadlineLabel.widthAnchor.constraint(equalToConstant: 91),
//                deadlineLabel.heightAnchor.constraint(equalToConstant: 22)
//            ])
//        }
    }
    
    
    
    
    @IBAction func deadlineButtonTapped(_ sender: UIButton) {
//        datePicker.isHidden = false
//        datePicker.preferredDatePickerStyle = .inline
//        datePicker.backgroundColor = UIColor(named: "backSecondary")
//        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        calendarView.isHidden = false
        
        
    }
    

    
    
    let labelPrimaryColor = UIColor(named: "labelPrimary")
    
    let calendarView = UICalendarView()
    
    
    
    
    
    
    
    override func viewDidLoad() {
        calendarView.delegate = self
        calendarView.isHidden = true
        calendarView.calendar = .current
        calendarView.locale = .current
        calendarView.layer.cornerRadius = 16
        
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        calendarView.selectionBehavior = dateSelection
        
        calendarView.backgroundColor = UIColor(named: "backSecondary")
        calendarView.availableDateRange = DateInterval(
            start: .now ,
            end: Date.distantFuture
        )
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(calendarView)
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: deadlineButton.bottomAnchor, constant: 16),
            calendarView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            calendarView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            calendarView.widthAnchor.constraint(equalToConstant: 311),
            calendarView.heightAnchor.constraint(equalToConstant: 312)
        ])
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        contentView.backgroundColor = UIColor(named: "backPrimary")
        scrollView.delegate = self
        
        
        
        
        
        
        //MARK: - datePicker
//        datePicker.datePickerMode = .dateAndTime
//        datePicker.isHidden = true
//        datePicker.preferredDatePickerStyle = .inline
//        datePicker.layer.cornerRadius = 16
//        datePicker.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            datePicker.topAnchor.constraint(equalTo: deadlineButton.bottomAnchor, constant: 16),
//            datePicker.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
//            datePicker.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
//            datePicker.widthAnchor.constraint(equalToConstant: 311),
//            datePicker.heightAnchor.constraint(equalToConstant: 312)
//        ])
        
        

        
        
        
        
        
        
        
        
        //MARK: - deadlineButton
        deadlineButton.isHidden = true
        deadlineButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deadlineButton.topAnchor.constraint(equalTo: toDoTask.bottomAnchor, constant: 95),
            deadlineButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 6),
            //            deadlineButton.trailingAnchor.constraint(equalTo: deadlineSwitch.leadingAnchor, constant: 16),
            deadlineButton.bottomAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 9),
            deadlineButton.heightAnchor.constraint(equalToConstant: 25),
        ])
        deadlineButton.contentHorizontalAlignment = .left
        
        
        

        
        
        
        
        
        
        //MARK: - toDoTask
        toDoTask.translatesAutoresizingMaskIntoConstraints = false
        toDoTask.backgroundColor = UIColor(named: "backSecondary")
        NSLayoutConstraint.activate([
            toDoTask.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 72),
            toDoTask.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            toDoTask.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            toDoTask.heightAnchor.constraint(greaterThanOrEqualToConstant: 120)
        ])
        toDoTask.delegate = self
        toDoTask.text = "Что надо сделать?"
        toDoTask.textColor = UIColor.lightGray
        toDoTask.layer.cornerRadius = 16.0 // Установите желаемый радиус скругления
        toDoTask.layer.masksToBounds = true // Обязательно установите значение true, чтобы обрезать содержимое внутри скругленных рамок
        backgroundView.layer.cornerRadius = 16
        backgroundView.layer.masksToBounds = true
        toDoTask.isScrollEnabled = false
        // Регистрируем обработчик жестов
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
        view.addGestureRecognizer(tapGesture)
        tapGesture.cancelsTouchesInView = false
        
        
        
        
        
        
        //MARK: - backgroundView
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            backgroundView.topAnchor.constraint(equalTo: toDoTask.bottomAnchor, constant: 16),
            backgroundView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            backgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            backgroundView.heightAnchor.constraint(equalToConstant: 113)
        ])
        
        
        
        
        
        
        
        //MARK: - priorityLabel
        priorityLabel.translatesAutoresizingMaskIntoConstraints = false
        priorityLabel.text = "Важность"
        NSLayoutConstraint.activate([
            priorityLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 16),
            priorityLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            priorityLabel.trailingAnchor.constraint(equalTo: choosePriority.leadingAnchor, constant: -16),
            priorityLabel.widthAnchor.constraint(equalToConstant: 149),
            priorityLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
        
        
        
        
        
        
        
        //MARK: - choosePriority
        choosePriority.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            choosePriority.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 10),
            choosePriority.leadingAnchor.constraint(equalTo: priorityLabel.trailingAnchor, constant: 16),
            choosePriority.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12),
            choosePriority.widthAnchor.constraint(equalToConstant: 150),
            choosePriority.heightAnchor.constraint(equalToConstant: 36)
        ])
        choosePriority.addTarget(self, action: #selector(segmentControlValueChanged), for: .valueChanged)
        
        
        
        
        
        
        
        
        
        //MARK: - deadlineLabel
        deadlineLabel.text = "Сделать до"
        deadlineLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deadlineLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 16),
            deadlineLabel.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            deadlineLabel.trailingAnchor.constraint(equalTo: deadlineSwitch.leadingAnchor, constant: 173),
            deadlineLabel.widthAnchor.constraint(equalToConstant: 91),
            deadlineLabel.heightAnchor.constraint(equalToConstant: 22)
        ])
        
        
        
        
        
        
        //MARK: - dividerView
        dividerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            dividerView.topAnchor.constraint(equalTo: choosePriority.bottomAnchor, constant: 10),
            dividerView.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 16),
            dividerView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -16),
            dividerView.widthAnchor.constraint(equalToConstant: 311),
            dividerView.heightAnchor.constraint(equalToConstant: 0.5)
        ])
        
        
        
        
        
        
        
        
        
        //MARK: - deadlineSwitch
        deadlineSwitch.setOn(false, animated: false)
        deadlineSwitch.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deadlineSwitch.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 12.5),
            deadlineSwitch.leadingAnchor.constraint(equalTo: deadlineLabel.trailingAnchor, constant: 173),
            deadlineSwitch.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: -12),
            deadlineSwitch.widthAnchor.constraint(equalToConstant: 51),
            deadlineSwitch.heightAnchor.constraint(equalToConstant: 31)
        ])
        
        
        
        
        
        
        
        
        
        
        
        
        
        //MARK: - deleteButton
        deleteButton.layer.cornerRadius = 16
        deleteButton.layer.masksToBounds = true
        deleteButton.backgroundColor = UIColor(named: "backSecondary")
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: backgroundView.bottomAnchor, constant: 16),
            deleteButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            deleteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            deleteButton.widthAnchor.constraint(equalToConstant: 343),
            deleteButton.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        
        
        
        
        
        //MARK: - scrollView
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.widthAnchor.constraint(equalToConstant: 375)
        ])
        
        
        
    }
    
    
    

    
    
    
    
    
    
    
    @objc func segmentControlValueChanged(_ sender: UISegmentedControl) {
        // Ваш код обработки изменения значения
    }
    
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        // Проверяем, что пользователь нажал мимо textView
        if !toDoTask.bounds.contains(gesture.location(in: toDoTask)) {
            // Скрываем клавиатуру
            toDoTask.resignFirstResponder()
        }
    }
    
    
    
    
    
}



extension TaskViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = labelPrimaryColor
        }
        if textView.text.isEmpty {
            view.layoutIfNeeded()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Что надо сделать?"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let contentHeight = Double(textView.contentSize.height)
        scrollView.contentSize = CGSize(width: 375, height: contentHeight + 369)
    }
}




extension TaskViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // Скрыть клавиатуру при прокрутке
        toDoTask.resignFirstResponder()
    }
}



extension TaskViewController:UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
         
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
        return true
    }
    
}

