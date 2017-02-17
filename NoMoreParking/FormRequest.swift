//
//  FormRequest.swift
//  NoMoreParking
//
//  Created by Ray Tso on 12/30/16.
//  Copyright © 2016 Ray Tso. All rights reserved.
//

import Foundation

class FormSessionRequest: NSObject, URLSessionDelegate, URLSessionTaskDelegate {
    private var form: ViolationForm?
    private var package: PostPackage?
    var isSubmitSuccessful: Bool = false
    
//    private func createForm() -> PostPackage? {
//        if let submitForm = form.createSubmitForm() {
//            return submitForm
//        } else {
//            debugPrint("failed to create form")
//            return nil
//        }
//    }
//    
    private func postData(packageData: PostPackage) {
        let tcpdURL = URL(string: "https://www.tcpd.gov.tw/tcpd/cht/index.php?act=traffic&code=add")
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue.main)
        var request = URLRequest(url: tcpdURL!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: .init(30))
        
        request.setValue(PostFields.UserAgent, forHTTPHeaderField: "User-Agent")
        request.setValue(packageData.contentType, forHTTPHeaderField: "Content-Type")
    //    request.setValue("www.tcpd.gov.tw", forHTTPHeaderField: "Host")
        request.setValue(PostFields.Connection, forHTTPHeaderField: "Connection")
        request.setValue(PostFields.CacheControl, forHTTPHeaderField: "Cache-Control")
        request.setValue(PostFields.Origin, forHTTPHeaderField: "Origin")
        request.setValue(PostFields.Accept, forHTTPHeaderField: "Accept")
        request.setValue(PostFields.AcceptLanguage, forHTTPHeaderField: "Accept-Language")
        request.setValue(PostFields.AcceptEncoding, forHTTPHeaderField: "Accept-Encoding")
        request.setValue(PostFields.Cookie, forHTTPHeaderField: "Cookie")
        request.setValue(PostFields.Referer, forHTTPHeaderField: "Referer")
        request.setValue(PostFields.UpgradeInsecureRequests, forHTTPHeaderField: "Upgrade-Insecure-Requests")

        request.httpBody = packageData.body
        request.httpMethod = PostFields.PostMethod
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            if error != nil {
                debugPrint("error=\(error)")
            }
            guard data!.count < 20000 else {
                debugPrint("\n...FAIL...")
                return
            }
            debugPrint("...SUCCESS!!!\n")
            self.isSubmitSuccessful = true
            let dataText = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print(dataText!)
        }
        task.resume()
    }
    
    internal func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            completionHandler(.useCredential, credential)
        }
    }
    
    func post(formToSubmit: ViolationForm) {
        let package = formToSubmit.createSubmitForm()
        guard package != nil else {
            debugPrint("Package is nil")
            return
        }
        postData(packageData: package!)
    }
    
    struct PostFields {
        static let UserAgent = "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_11_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/55.0.2883.75 Safari/537.36"
        static let Connection = "keep-alive"
        static let CacheControl = "max-age=0"
        static let Origin = "http://www.tcpd.gov.tw"
        static let Accept = "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
        static let AcceptLanguage = "en-US,en;q=0.8,zh-TW;q=0.6,zh;q=0.4,ja;q=0.2,zh-CN;q=0.2"
        static let AcceptEncoding = "gzip, deflate, br"
        static let Cookie = "PHPSESSID=42de5a75f0569b660f3a4b0aee6ff0dd"
        static let Referer = "http://www.tcpd.gov.tw/tcpd/cht/index.php?act=traffic&code=add"
        static let UpgradeInsecureRequests = "1"
        static let PostMethod = "POST"
    }
}





//func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
//        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
//            let credential = URLCredential(trust: challenge.protectionSpace.serverTrust!)
//            completionHandler(.useCredential, credential)
//        }
//    }
//
//    //
//    func postData(inputKey: Array <String>, inputValue: Array <String>) {
//        let myUrl = URL(string: "https://www.tcpd.gov.tw/tcpd/cht/index.php?act=traffic&code=add")
//        let session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue.main)
//        var request = URLRequest(url: myUrl!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: .init(10))
//
//        // Set content
//        let contentType = "multipart/form-data; boundary=" + Boundary.const
//        var dataBody: String = ""
//        var packageData = Data.init()



//
//
//        print("\nHTTP headers:")
//        print(request.allHTTPHeaderFields)
//
//        // Uploading data to server
//        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
//
//            if error != nil {
//                print("error=\(error)")
//                return
//            }
//            print("response = \(response)")
//            guard data!.count < 20000 else {
//                print("\n...FAIL...")
//                return
//            }
//            print("...SUCCESS!!!\n")
//            print(data?.count)
//            let dataText = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//            print(dataText!)
//        }
//        task.resume()
//    }



