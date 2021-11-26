//
//  RatingControl.swift
//  MyPlaces
//
//  Created by cladendas on 26.11.2021.
//

import UIKit

//@IBDesignable позволяет в реальном времени отобразить в сториборде изменения, внесённые в код
//@IBDesignable
class RatingControl: UIStackView {
    
    ///кнопки рейтинга
    private var ratingButtons = [UIButton]()
    
    //@IBInspectable позволяет отобразить дайнное св-во в атрибут-инспекторе
    //didSet здесь позволит сразу же отобразить на сторибор изменения, которые были в несены в данное св-во через атрибут-инспектор
    @IBInspectable var starSize: CGSize = CGSize(width: 44.0, height: 44.0) {
        didSet {
            setupButtons()
        }
    }
    
    //didSet здесь позволит сразу же отобразить на сторибор изменения, которые были в несены в данное св-во через атрибут-инспектор
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    ///текущее значение рейтинга
    var rating = 0

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupButtons()
    }

    //инициализатор для работы с экземпляром класса через сториборд
    required init(coder: NSCoder) {
        super.init(coder: coder)
        
        setupButtons()
    }
    
    ///действие на кнопке
    @objc func ratingButtonTapped(button: UIButton) {
        print("Button pressed")
    }
    
    ///создание кнопок и добавление на саб-вью
    private func setupButtons() {
        
        //это нужно, если изменяются значения св-в в атрибут-инспекторе
        //пример: при указании кол-ва кнопок в атрибут-инспекторе, указанное кол-во добавляется к кол-ву по умолчанию
        //а реализация ниже сначала удаляет все кнопки, а потом добавляет указанное кол-во
        for button in ratingButtons {
            //удаление из списка саб-вью
            removeArrangedSubview(button)
            //удаление из стэк-вью
            button.removeFromSuperview()
        }
        ratingButtons.removeAll()
        
        for _ in 0..<starCount {
            let button = UIButton()
            button.backgroundColor = .red
            
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            button.addTarget(self, action: #selector(ratingButtonTapped(button:)), for: .touchUpInside)
            
            ///добавление кнопки в список представлений, как саб-вью класса стэк-вью
            addArrangedSubview(button)
            
            ratingButtons.append(button)
        }
    }
}
