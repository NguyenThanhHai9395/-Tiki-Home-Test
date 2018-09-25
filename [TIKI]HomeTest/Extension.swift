//
//  Extension.swift
//  [TIKI]HomeTest
//
//  Created by ThanhHai on 9/24/18.
//  Copyright © 2018 ThanhHai. All rights reserved.
//

import UIKit
import Foundation

struct Constant {
    static let colors: [Int] = [0x16702e, 0x005a51, 0x996c00, 0x5c0a6b, 0x006d90, 0x974e06, 0x99272e, 0x89221f, 0x00345d]
}

//UIColor
extension UIColor{
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid red component")
        assert(blue >= 0 && blue <= 255, "Invalid red component")
        
        self.init(red: CGFloat(red)/255, green: CGFloat(green)/255, blue: CGFloat(blue)/255, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: rgb >> 16 & 0xFF,
            green: rgb >> 8 & 0xFF,
            blue: rgb & 0xFF)
    }
}

//UIImageView
extension UIImageView{
    func download(from url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let data = data, error == nil,
                let image = UIImage(data: data) else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }.resume()
    }
    
    func download(from link: String, contentMode mode: UIViewContentMode = .scaleAspectFit){
        guard let url = URL(string: link) else {
            return
        }
        download(from: url, contentMode: mode)
    }
}
//JSONDecoder
extension JSONDecoder {
    
    static func decode<T: Decodable>(_ type: T.Type, from data: Data?, completion: @escaping (_ error: String?,_ result: T?) -> Void) {
        
        guard let data = data else {
            completion("The data couldn't be read because it is missing", nil)
            return
        }
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let result = try jsonDecoder.decode(type, from: data)
            completion(nil, result)
        } catch (let error) {
            completion(error.localizedDescription, nil)
        }
        
    }
    
}


extension UIViewController{
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}








