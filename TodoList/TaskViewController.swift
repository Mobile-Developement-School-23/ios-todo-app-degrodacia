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
    
    
    
    
    let labelPrimaryColor = UIColor(named: "labelPrimary")
    
    override func viewDidLoad() {
//        choosePriority.setTitle("нет", forSegmentAt: 1)
        toDoTask.delegate = self
        toDoTask.text = "Что надо сделать?"
        toDoTask.textColor = UIColor.lightGray
        toDoTask.layer.cornerRadius = 16.0 // Установите желаемый радиус скругления
        toDoTask.layer.masksToBounds = true // Обязательно установите значение true, чтобы обрезать содержимое внутри скругленных рамок
//        backgroundView.layer.cornerRadius = 16
//        backgroundView.layer.masksToBounds = true
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
