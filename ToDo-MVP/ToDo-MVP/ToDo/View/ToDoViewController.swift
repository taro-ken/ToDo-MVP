//
//  ViewController.swift
//  ToDo-MVP
//
//  Created by 木元健太郎 on 2022/03/07.
//

import UIKit

class ToDoViewController: UIViewController {
    
    @IBOutlet weak var todoText: UITextField!
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(UINib.init(nibName: ToDoTableViewCell.className, bundle: nil), forCellReuseIdentifier: ToDoTableViewCell.className)
            tableView.delegate = self
            tableView.dataSource = self
        }
    }
    
    private var presenter: ToDoPresenterInput!
    func inject(presenter: ToDoPresenterInput) {
        self.presenter = presenter
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func tapAdd(_ sender: Any) {
        presenter.add(text: todoText.text)
        todoText.text = ""
    }
    
    
}

private extension ToDoViewController {
    //アラートを出す処理
    func showAlert(text: String?) {
        let alertVC = UIAlertController(title: "タイトル", message: text, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
}

extension ToDoViewController:ToDoPresenterOutput{
    func alert(text: String?) {
        self.showAlert(text: text)
    }
    
    func update() {
        tableView.reloadData()
    }
}
extension ToDoViewController:UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ToDoTableViewCell.className) as? ToDoTableViewCell else {
            fatalError()
        }
        let todoModel = presenter.item(index: indexPath.item)
        cell.configure(todoModel: todoModel)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelect(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            presenter.didEditingDelete(index: indexPath)
        }
    }
    
}
