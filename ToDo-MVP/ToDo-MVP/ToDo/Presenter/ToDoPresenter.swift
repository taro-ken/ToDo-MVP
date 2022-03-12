//
//  ToDoPresenter.swift
//  ToDo-MVP
//
//  Created by 木元健太郎 on 2022/03/07.
//

import Foundation

protocol ToDoPresenterInput {
    var numberOfItems: Int { get }
    func item(index: Int) -> ToDoModel
    func add(text:String?)
    func didSelect(index: Int)
    func didEditingDelete(index: IndexPath)
}

protocol ToDoPresenterOutput:AnyObject {
    func update()
    func alert(text:String?)
}

final class ToDoPresenter {
    private var output:ToDoPresenterOutput!
    private var todoModel:[ToDoModel]
    
    init(output:ToDoPresenterOutput){
        self.output = output
        self.todoModel = []
    }
}

extension ToDoPresenter:ToDoPresenterInput{
    func didSelect(index: Int) {
        output.alert(text: todoModel[index].title)
    }
    func didEditingDelete(index: IndexPath) {
        todoModel.remove(at: index.item)
        output.update()
    }
   
    func add(text:String?){
        guard let text = text, !text.isEmpty else { return }
        let todoModel = ToDoModel.init(title: text)
        self.todoModel.append(todoModel)
        output.update()
    }
   
    func item(index: Int) -> ToDoModel {
        todoModel[index]
    }
    
    var numberOfItems: Int {
        todoModel.count
    }
    
    
}
