//
//  ToDoTableViewCell.swift
//  ToDo-MVP
//
//  Created by 木元健太郎 on 2022/03/07.
//

import UIKit


final class ToDoTableViewCell: UITableViewCell {
    
    static var className: String { String(describing: ToDoTableViewCell.self) }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    func configure(todoModel: ToDoModel) {
        self.titleLabel.text = todoModel.title
        
    }
}

