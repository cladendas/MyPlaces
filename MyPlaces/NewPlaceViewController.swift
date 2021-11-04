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
            
            //меню для установки изображения
            let actionSheep = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
            
            //действие для алерта: изображение из камеры
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            
            //действие для алерта: изображение из библиотеки
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            actionSheep.addAction(camera)
            actionSheep.addAction(photo)
            actionSheep.addAction(cancel)
            
            present(actionSheep, animated: true)
            
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

// MARK: Work with image

extension NewPlaceViewController {
    
    ///Выбор изображения из указанного источника
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        //проверка доступности источника изображения
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            //возможность редактировать изображение
            imagePicker.allowsEditing = true
            //указываем тип источника изображения
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
        
    }
    
}
