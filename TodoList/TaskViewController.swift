//
//  ViewController.swift
//  TodoList
//
//  Created by Егор Черняев on 15.06.2023.
//

import UIKit

class TaskViewController: UIViewController {
    
    @IBOutlet weak var toDoTask: UITextView!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var textViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var choosePriority: UISegmentedControl!
    @IBOutlet weak var deadlineSwitch: UISwitch!
    @IBOutlet weak var backgroundView: UIView!
    
    
    
    
<<<<<<< Updated upstream
    let labelPrimaryColor = UIColor(named: "labelPrimary")
    
    override func viewDidLoad() {
//        choosePriority.setTitle("нет", forSegmentAt: 1)
=======
    
    
    
    

    
    
    
    
    
    
    
    
    
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    @objc func switchChanged(_ paramTagret: UISwitch){
        if paramTagret.isOn{
            deadlineButton.isHidden = false
            deadlineButton.isEnabled = true
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            let result = dateFormatter.string(from: .now + 24*60*60)
            deadlineButton.setTitle("\(result)", for: .normal)
        } else {
            deadlineButton.isHidden = true
            deadlineButton.isEnabled = false
            calendarView.isHidden = true
        }
    }
    
    
    
    @IBAction func deadlineSwitchValueChanged(_ sender: UISwitch) {
        
    }
    
    
    
    
    @IBAction func deadlineButtonTapped(_ sender: UIButton) {
        if flag == false{
            calendarView.isHidden = false
            flag = true
        } else {
            calendarView.isHidden = true
            flag = false
        }
    }
    

    
    
    let labelPrimaryColor = UIColor(named: "labelPrimary")
    
    let calendarView = UICalendarView()
    
    var flag = false
    
    var deadline = ""
    
    
    
    
    
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
            start: .now + 24*60*60 ,
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
        
        
        
        

        

        
        
        
        
        
        
        
        
        //MARK: - deadlineButton
        deadlineButton.isHidden = true
        deadlineButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deadlineButton.topAnchor.constraint(equalTo: toDoTask.bottomAnchor, constant: 90),
            deadlineButton.leadingAnchor.constraint(equalTo: backgroundView.leadingAnchor, constant: 5),
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
>>>>>>> Stashed changes
        toDoTask.delegate = self
        toDoTask.text = "Что надо сделать?"
        toDoTask.textColor = UIColor.lightGray
        toDoTask.layer.cornerRadius = 16.0 // Установите желаемый радиус скругления
        toDoTask.layer.masksToBounds = true // Обязательно установите значение true, чтобы обрезать содержимое внутри скругленных рамок
<<<<<<< Updated upstream
//        backgroundView.layer.cornerRadius = 16
//        backgroundView.layer.masksToBounds = true
=======
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
            deadlineLabel.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 10),
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
        self.deadlineSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        
        
        
        
        
        
        
        
        
        
        
        
        //MARK: - deleteButton
>>>>>>> Stashed changes
        deleteButton.layer.cornerRadius = 16
        deleteButton.layer.masksToBounds = true
        toDoTask.isScrollEnabled = false
        
        textViewHeightConstraint.constant = 120
        
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        // Определите высоту, на которую можно расширить textView
        let maxHeight: CGFloat = 300
        
        // Получите размеры, которые вмещают весь текст в textView
        let size = textView.sizeThatFits(CGSize(width: textView.frame.width, height: .greatestFiniteMagnitude))
        
        // Ограничьте размеры, чтобы не превышать максимальную высоту
        let clampedHeight = min(max(size.height, 120), maxHeight)
        
        // Обновите высоту textView
        textViewHeightConstraint.constant = clampedHeight
        
        // Обновите ограничения представлений, связанных с textView
        view.layoutIfNeeded()
        
        // Включите прокрутку, если текст превышает текущую высоту
        textView.isScrollEnabled = size.height > clampedHeight
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Обновите размеры текстового поля после изменения ограничений
        textViewDidChange(toDoTask)
    }
    
    
    
    
    
    
}



extension TaskViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = labelPrimaryColor
        }
        if textView.text.isEmpty {
            textViewHeightConstraint.constant = 120
            view.layoutIfNeeded()
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Что надо сделать?"
            textView.textColor = UIColor.lightGray
        }
    }
}
<<<<<<< Updated upstream
=======




extension TaskViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        // Скрыть клавиатуру при прокрутке
        toDoTask.resignFirstResponder()
    }
}



extension TaskViewController:UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate {
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        if let dateComponents{
            
            deadlineButton.setTitle("\(dateComponents.day!).0\(dateComponents.month!).\(dateComponents.year!)", for: .normal)
            calendarView.isHidden = true
        }
        
    }
    
    func dateSelection(_ selection: UICalendarSelectionSingleDate, canSelectDate dateComponents: DateComponents?) -> Bool {
        return true
    }
    
}



>>>>>>> Stashed changes
