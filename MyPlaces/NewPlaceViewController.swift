//
//  NewPlaceViewController.swift
//  MyPlaces
//
//  Created by cladendas on 04.11.2021.
//

import UIKit

class NewPlaceViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        //Чтобы убрать разлиновку в пустых строках
        tableView.tableFooterView = UIView()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //скрывать клавиатуру при нажатии на ячейку
        if indexPath.row == 0 {
            
        } else {
            view.endEditing(true)
        }
    }

}

// MARK: - Text Field Delegate

extension NewPlaceViewController: UITextFieldDelegate {
    //Скрываем клаву при нажатии на Done
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
