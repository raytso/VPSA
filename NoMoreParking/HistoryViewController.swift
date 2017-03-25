//
//  HistoryViewController.swift
//  NoMoreParking
//
//  Created by Ray Tso on 3/24/17.
//  Copyright © 2017 Ray Tso. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet weak var navBar: UINavigationBar!
    
//    @IBOutlet weak var shadowBuffer: UIImageView!
    
    @IBOutlet weak var historyDataTableContainer: UIView! {
        didSet{
//            historyDataTableContainer.translatesAutoresizingMaskIntoConstraints = true
        }
    }
    
//    private var model: HistoryViewModel?
    
    private var dataTable: HistoryDataTableViewController?
    
    // MARK: - UDFs
    
    private func addShadow(layer: CALayer) {
        layer.masksToBounds = false
        layer.shadowColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 4.0
        layer.shadowOffset = CGSize(width: 0.0, height: 6.0)
        // shadowPath causes shadow width problem on 7, layer width?
//        layer.shadowPath = UIBezierPath(rect: layer.bounds).cgPath
        layer.zPosition = 2.0
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tab = self.tabBarController as! AppMenuTabBarViewController
        dataTable?.model = tab.database
        // Do any additional setup after loading the view.
//        let image = #imageLiteral(resourceName: "buffer").
//        let imv = UIImageView(image: image)
//        shadowBuffer.addSubview(imv)
//        addShadow(layer: shadowBuffer.layer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        UIApplication.shared.statusBarStyle = .default
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let controller = segue.destination as? HistoryDataTableViewController {
            dataTable = controller
        }
    }
    

}
