//
//  ViewController.swift
//  counter
//
//  Created by Invitado on 4/29/20.
//  Copyright © 2020 Invitado. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tb: UITableView!
    @IBOutlet weak var textAdd: UITextField!
    @IBOutlet weak var total: UILabel!
    
    
    
    var datosCont: [contador] = []
    let dataService = Api()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tb.dataSource = self
        self.tb.delegate = self
        
        
        dataService.apiGET(url:"api/v1/counters"){ (array_respuesta) in
        
            DispatchQueue.main.async {//proceso principal
                
                guard let dat = array_respuesta else {
                    print("Error obteniendo datos")
                    return
                }
                
                let datosDic =  array_respuesta as! [NSDictionary]
                    
                self.datosCont = self.convertirData(datosDic: datosDic)
                print(self.datosCont)
                self.tb.reloadData()
                self.sumaTotal()
                
                
            }
        }
        
    }
    
    func convertirData(datosDic:[NSDictionary] )-> [contador]{
        
        var datos :[contador] = []
        for data in datosDic{
            let dato: contador = contador();
            dato.id = data.object(forKey: "id") as! String
            
            dato.title = data.object(forKey: "title") as! String
            dato.count = data.object(forKey: "count") as! Int
            datos.append(dato)
            
        }
        
        return datos
        
    }
    
    func sumaTotal() {
        var valorTotal:Int = 0
        for item in datosCont{
            valorTotal += item.count ?? 0
        }
        
        total.text = String(valorTotal)
    }
    
    func incDec(inc:Bool, id:String){
        
        let urlInc = "api/v1/counter/inc"
        let urlDec = "api/v1/counter/dec"
        var url = ""
        
        if(inc){
            url = urlInc
        }
        else{
            url = urlDec
        }
        
        dataService.apiIncDec(url:url,id:id){ (array_respuesta) in
        
            DispatchQueue.main.async {//proceso principal
                
                guard let dat = array_respuesta else {
                    print("Error obteniendo datos")
                    return
                }
                
                let datosDic =  array_respuesta as! [NSDictionary]
                    
                self.datosCont = self.convertirData(datosDic: datosDic)
                print(self.datosCont)
                self.tb.reloadData()
                self.sumaTotal()
                
                
            }
        }
        
        
    }
    
    //Funciones de la UITABLEVIEW
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datosCont.count
    }
     
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContadorCell", for: indexPath) as! ContadorTableViewCell
        
        
            
            cell.title.text = self.datosCont[indexPath.row].title
            cell.cantidad.text = String (self.datosCont[indexPath.row].count!)
            
            cell.btnIncrementar.tag = indexPath.row
            cell.btnDec.tag = indexPath.row
            cell.btnDelete.tag = indexPath.row
            cell.btnIncrementar.addTarget(self, action: #selector(incrementar), for: .touchUpInside)
            cell.btnDec.addTarget(self, action: #selector(decrementar), for: .touchUpInside)
            cell.btnDelete.addTarget(self, action: #selector(borrar), for: .touchUpInside)
         
        
        return cell
    }
    
    /// Incrementar contador
    @objc func incrementar(sender: UIButton){
        
        print(sender.tag)
        let id:String = self.datosCont[sender.tag].id!
        incDec(inc: true, id: id)
        
    }
    
    //INcremetnar Contador
    @objc func decrementar(sender: UIButton){
           
           print(sender.tag)
           let id:String = self.datosCont[sender.tag].id!
           incDec(inc: false, id: id)
           
       }
    
    //Borrar contador
    
    @objc func borrar(sender: UIButton){
        
        print(sender.tag)
        let id:String = self.datosCont[sender.tag].id!
        dataService.apiDelete(url:"api/v1/counter",id:id){ (array_respuesta) in
        
            DispatchQueue.main.async {//proceso principal
                
                guard let dat = array_respuesta else {
                    print("Error obteniendo datos")
                    return
                }
                
                let datosDic =  array_respuesta as! [NSDictionary]
                    
                self.datosCont = self.convertirData(datosDic: datosDic)
               // print(self.datosCont)
                self.tb.reloadData()
                self.sumaTotal()
                
                
            }
        }
        
    }
    
    
    
    
    
    //Agregar Nuevo COntador
    @IBAction func addContador(_ sender: Any) {
        
        let titulo:String = textAdd.text ?? ""
        
        if(titulo == ""){
            return
        }
        
        dataService.apiAdd(url:"api/v1/counter",title:titulo){ (array_respuesta) in
        
            DispatchQueue.main.async {//proceso principal
                
                guard let dat = array_respuesta else {
                    print("Error obteniendo datos")
                    return
                }
                
                let datosDic =  array_respuesta as! [NSDictionary]
                    
                self.datosCont = self.convertirData(datosDic: datosDic)
               // print(self.datosCont)
                self.textAdd.text = ""
                self.tb.reloadData()
                self.sumaTotal()
                
                
            }
        }
        
        
        
        
    }
    
}

