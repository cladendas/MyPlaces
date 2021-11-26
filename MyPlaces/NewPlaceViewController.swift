//
//  NewPlaceViewController.swift
//  MyPlaces
//
//  Created by cladendas on 04.11.2021.
//

import UIKit

class NewPlaceViewController: UITableViewController {
    
    ///Выбранная для редактирования ячейка
    var currentPlace: Place?
    ///проверка, что пользователь добавил своё изображение
    var imageIsChanged = false

    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var placeImage: UIImageView!
    @IBOutlet var placeName: UITextField!
    @IBOutlet var placeLocation: UITextField!
    @IBOutlet var placeType: UITextField!
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Чтобы убрать разлиновку в пустых строках
        tableView.tableFooterView = UIView(frame: CGRect(x: 0,
                                                         y: 0,
                                                         width: tableView.frame.size.width,
                                                         height: 1))
        
        //Нельзя сохранять, если наименование места пусто
        saveButton.isEnabled = false
        
        //метод срабатывает при редактировании поля
        placeName.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        setupEditScreen()
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //скрывать клавиатуру при нажатии на ячейку
        if indexPath.row == 0 {
            
            let cameraIcon = #imageLiteral(resourceName: "icons8-camera")
            let photoIcon = #imageLiteral(resourceName: "icons8-image")
            
            //меню для установки изображения
            let actionSheep = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
            
            //действие для алерта: изображение из камеры
            let camera = UIAlertAction(title: "Camera", style: .default) { _ in
                self.chooseImagePicker(source: .camera)
            }
            
            //устанавливаем картинку возле кнопки в алерете
            camera.setValue(cameraIcon, forKey: "image")
            
            //текст кнопки выравниваем по левому краю
            camera.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            //действие для алерта: изображение из библиотеки
            let photo = UIAlertAction(title: "Photo", style: .default) { _ in
                self.chooseImagePicker(source: .photoLibrary)
            }
            
            //устанавливаем картинку возле кнопки в алерете
            photo.setValue(photoIcon, forKey: "image")
            
            //текст кнопки выравниваем по левому краю
            photo.setValue(CATextLayerAlignmentMode.left, forKey: "titleTextAlignment")
            
            let cancel = UIAlertAction(title: "Cancel", style: .cancel)
            
            actionSheep.addAction(camera)
            actionSheep.addAction(photo)
            actionSheep.addAction(cancel)
            
            present(actionSheep, animated: true)
            
        } else {
            view.endEditing(true)
        }
    }
    
    func savePlace() {
        
        var image: UIImage?
        
        //если пользователь указал изображение, то отобразить его, если нет - отобразить изображение по умолчанию
        if imageIsChanged {
            image = placeImage.image
        } else {
            image = #imageLiteral(resourceName: "icons8-tableware")
        }
        
        let imageData = image?.pngData()
        
        let newPlace = Place(name: placeName.text!,
                             location: placeLocation.text,
                             type: placeType.text,
                             imageData: imageData)
        
        if currentPlace != nil {
            try! realm.write({
                currentPlace?.name = newPlace.name
                currentPlace?.location = newPlace.location
                currentPlace?.type = newPlace.type
                currentPlace?.imageData = newPlace.imageData
            })
        } else {
            StorageManager.saveObject(newPlace)
        }
        
        
    }
    
    ///окно редактирования выбранной ячейки
    private func setupEditScreen() {
        if currentPlace != nil {
            
            setupNavigationBar()
            imageIsChanged = true
            
            guard let data = currentPlace?.imageData, let image = UIImage(data: data) else { return }
            placeImage.image = image
            placeImage.contentMode = .scaleAspectFit
            placeName.text = currentPlace?.name
            placeLocation.text = currentPlace?.location
            placeType.text = currentPlace?.type
        }
    }
    
    private func setupNavigationBar() {
        
        ///Убирает название заголовка возле кнопки возврата
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        
        navigationItem.leftBarButtonItem = nil
        title = currentPlace?.name
        saveButton.isEnabled = true
    }

}

// MARK: - Text Field Delegate

extension NewPlaceViewController: UITextFieldDelegate {
    
    //Скрываем клаву при нажатии на Done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc
    private func textFieldChanged() {
        
        //если в поле есть текст, то можно сохранить
        if placeName.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
        
    }
}

// MARK: Work with image

extension NewPlaceViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    ///Выбор изображения из указанного источника
    func chooseImagePicker(source: UIImagePickerController.SourceType) {
        
        //проверка доступности источника изображения
        if UIImagePickerController.isSourceTypeAvailable(source) {
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            
            //возможность редактировать изображение
            imagePicker.allowsEditing = true
            //указываем тип источника изображения
            imagePicker.sourceType = source
            present(imagePicker, animated: true)
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        placeImage.image = info[.editedImage] as? UIImage
        placeImage.contentMode = .scaleAspectFill
        placeImage.clipsToBounds = true

        imageIsChanged = true
        
        dismiss(animated: true)
    }
}
