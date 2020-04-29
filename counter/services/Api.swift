//
//  Api.swift
//  counter
//
//  Created by Invitado on 4/29/20.
//  Copyright © 2020 Invitado. All rights reserved.
//

import Foundation


class Api: NSObject {

    //constantes de nuestra clase
    
    let urlBase = "https://ill1.li/"//url del servidor remoto
    
    
    //Funcion para obtener todos los contadores existentes en el servidor
    func apiGET(url:String, comletionHandler: @escaping (NSArray?) -> Void){
        
            //Concatenamos nuestr url base con el archivo .php que va a procesar la solicitud
            let url = URL(string: "\(urlBase)/\(url)")!//http://localhost:8888/2_1_webservice/webservice1.php
            //convertimos la constante url a tipo URLRequest
            var request = URLRequest(url: url)
        
            //establecemos las cabeceras de la petición JSON estándar
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
            request.httpMethod = "GET"
        
            

       
        
            let task = URLSession.shared.dataTask(with: request) { datos_recibidos, response, error in
                if error != nil{//detectamos un error y devolvemos el array vacío
                    comletionHandler(nil)
                }
                else{
                    //tratamos de convertir la respuesta en array
                    do {
                        //imprimimos en consola los datos enviados y los datos recibidos en modo debug
                        //print("datos recibidos: \(String(describing: String(data: datos_recibidos!, encoding: .utf8))) - datos enviados: \(datos_enviados)")
                       
                        //Convertimos el JSON recibido del servidor remoto en formato array para ser tratado por el dispositivo
                        if let array = try JSONSerialization.jsonObject(with: datos_recibidos!) as? NSArray {
                            //comletionHandler -> devuelve el array, es equivalente en otros lenguajes a  return(array)
                            comletionHandler(array)
                        }
                    } catch let parseError {
                        //Existe un error en el formato JSON, imprimimos en consola la respuesta para localizar el error
                        print("error servidor \(String(data: datos_recibidos!, encoding: .utf8)) \(parseError)")
                        //detectamos un error y devolvemos el array vacío
                        comletionHandler(nil)
                    }
                }
            }
            task.resume()
      
    }
    
    
    //Funcion para agregar un nuevo contador en la api
    func apiAdd(url:String, title:String, comletionHandler: @escaping (NSArray?) -> Void){
        
            
            let url = URL(string: "\(urlBase)/\(url)")!
            //convertimos la constante url a tipo URLRequest
            var request = URLRequest(url: url)
        
            //establecemos las cabeceras de la petición JSON estándar
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
            request.httpMethod = "POST"
        
            
        let datos_enviados:NSMutableDictionary = ["title":title]
       
            //Convertimos  el array en formato JSON antes de ser enviada
            request.httpBody = try! JSONSerialization.data(withJSONObject: datos_enviados)
        
            //realizamos la petición al servidor remoto
        
            let task = URLSession.shared.dataTask(with: request) { datos_recibidos, response, error in
                if error != nil{//detectamos un error y devolvemos el array vacío
                    comletionHandler(nil)
                }
                else{
                    //tratamos de convertir la respuesta en array
                    do {
                        //imprimimos en consola los datos enviados y los datos recibidos en modo debug
                        //print("datos recibidos: \(String(describing: String(data: datos_recibidos!, encoding: .utf8))) - datos enviados: \(datos_enviados)")
                       
                        //Convertimos el JSON recibido del servidor remoto en formato array para ser tratado por el dispositivo
                        if let array = try JSONSerialization.jsonObject(with: datos_recibidos!) as? NSArray {
                            //comletionHandler -> devuelve el array, es equivalente en otros lenguajes a  return(array)
                            comletionHandler(array)
                        }
                    } catch let parseError {
                        //Existe un error en el formato JSON, imprimimos en consola la respuesta para localizar el error
                        print("error servidor \(String(data: datos_recibidos!, encoding: .utf8)) \(parseError)")
                        //detectamos un error y devolvemos el array vacío
                        comletionHandler(nil)
                    }
                }
            }
            task.resume()
      
    }
    
    
    //Funcion para borrar un contador del servidor de la api
    
    
    func apiDelete(url:String, id:String, comletionHandler: @escaping (NSArray?) -> Void){
        
            //Concatenamos nuestr url base con el archivo .php que va a procesar la solicitud
            let url = URL(string: "\(urlBase)/\(url)")!//http://localhost:8888/2_1_webservice/webservice1.php
            //convertimos la constante url a tipo URLRequest
            var request = URLRequest(url: url)
        
            //establecemos las cabeceras de la petición JSON estándar
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
            request.httpMethod = "DELETE"
        
            
        let datos_enviados:NSMutableDictionary = ["id":id]
       
            //Convertimos  el array en formato JSON antes de ser enviada
            request.httpBody = try! JSONSerialization.data(withJSONObject: datos_enviados)
        
            //realizamos la petición al servidor remoto
        
            let task = URLSession.shared.dataTask(with: request) { datos_recibidos, response, error in
                if error != nil{//detectamos un error y devolvemos el array vacío
                    comletionHandler(nil)
                }
                else{
                    //tratamos de convertir la respuesta en array
                    do {
                        //imprimimos en consola los datos enviados y los datos recibidos en modo debug
                        print("datos recibidos: \(String(describing: String(data: datos_recibidos!, encoding: .utf8))) - datos enviados: \(datos_enviados)")
                       
                        //Convertimos el JSON recibido del servidor remoto en formato array para ser tratado por el dispositivo
                        if let array = try JSONSerialization.jsonObject(with: datos_recibidos!) as? NSArray {
                            //comletionHandler -> devuelve el array, es equivalente en otros lenguajes a  return(array)
                            comletionHandler(array)
                        }
                    } catch let parseError {
                        //Existe un error en el formato JSON, imprimimos en consola la respuesta para localizar el error
                        print("error servidor PHP \(String(data: datos_recibidos!, encoding: .utf8)) \(parseError)")
                        //detectamos un error y devolvemos el array vacío
                        comletionHandler(nil)
                    }
                }
            }
            task.resume()
      
    }
    
    
    
    //Funcion para incrementar o decrementar un contador 
    
    func apiIncDec(url:String, id:String, comletionHandler: @escaping (NSArray?) -> Void){
        
            //Concatenamos nuestr url base con el archivo .php que va a procesar la solicitud
            let url = URL(string: "\(urlBase)/\(url)")!//http://localhost:8888/2_1_webservice/webservice1.php
            //convertimos la constante url a tipo URLRequest
            var request = URLRequest(url: url)
        
            //establecemos las cabeceras de la petición JSON estándar
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")
            request.httpMethod = "POST"
        
            
        let datos_enviados:NSMutableDictionary = ["id":id]
       
            //Convertimos  el array en formato JSON antes de ser enviada
            request.httpBody = try! JSONSerialization.data(withJSONObject: datos_enviados)
        
            //realizamos la petición al servidor remoto
        
            let task = URLSession.shared.dataTask(with: request) { datos_recibidos, response, error in
                if error != nil{//detectamos un error y devolvemos el array vacío
                    comletionHandler(nil)
                }
                else{
                    //tratamos de convertir la respuesta en array
                    do {
                        //imprimimos en consola los datos enviados y los datos recibidos en modo debug
                        print("datos recibidos: \(String(describing: String(data: datos_recibidos!, encoding: .utf8))) - datos enviados: \(datos_enviados)")
                       
                        //Convertimos el JSON recibido del servidor remoto en formato array para ser tratado por el dispositivo
                        if let array = try JSONSerialization.jsonObject(with: datos_recibidos!) as? NSArray {
                            //comletionHandler -> devuelve el array, es equivalente en otros lenguajes a  return(array)
                            comletionHandler(array)
                        }
                    } catch let parseError {
                        //Existe un error en el formato JSON, imprimimos en consola la respuesta para localizar el error
                        print("error servidor \(String(data: datos_recibidos!, encoding: .utf8)) \(parseError)")
                        //detectamos un error y devolvemos el array vacío
                        comletionHandler(nil)
                    }
                }
            }
            task.resume()
      
    }
    
    
    
}
