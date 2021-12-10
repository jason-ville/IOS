//----------------------------------------
//
//   Project Imail
//
//  Created by Jason Ville and Guilhem Couly on 18/11/2021.
//
//----------------------------------------

import UIKit

//----------------------------------------
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource, UISearchBarDelegate ,FirstViewDelegate
{
   
    //----------------------------------------
    
    var tableViewContent: [String] = [String]()     //   Tableaux permmetant de stocket le contenue du mail qui a été envoyé depuis la SecondViewController
    var tableViewTitre: [String] = [String]()       //   Tableaux permetant de stoker  le titre des mail depuis la SecondViewController
    var tableViewObject: [String] = [String]()      //   Tableaux permetant de stocker l'objet des mail depuis la SecondViewController
    var tableViewObjectFiltered: [String] = [String]()      //   Tableaux permetant de stocker l'objet des mail depuis la SecondViewController
    
    
    //----------------------------------------
    
    let cellReuseIdentifier = "email"       // Variavle permetant de recupére les donnée de la vue email de lobejt cellule de la table view controller
   
    //----------------------------------------
    
    @IBOutlet var gradientView: UIView!          //
    @IBOutlet var searchBarView: UISearchBar!    //Définition des objets
    @IBOutlet var tableView: UITableView!        //
   
    //----------------------------------------
    
   
    
    //----------------------------------------
    
    lazy var gradient: CAGradientLayer =
        {
            let gradient = CAGradientLayer()                // Définit la variable gradiant par raport a la classe CAGradientLayer()
            gradient.type = .axial                          // Définit le type de dégradé dans notre cas un dégradé en ligne
            gradient.colors =                               // Définit tout les couleur du dégrédé
            [                                               //
                UIColor.black.cgColor,                      // Choisit la premiére couleur du dégradé
                UIColor.gray.cgColor,                       // Choisit la seconde couleur du dégradé
                UIColor.orange.cgColor                      // Choisit la troisiéme couleur du dégradé
            ]                                               //
            gradient.locations = [0, 0.25, 1]               //
            gradient.startPoint = CGPoint(x: 0, y: 0)       // Choisit le point de départ du dégradé
            gradient.endPoint = CGPoint(x: 1, y: 1)         // Choisir le point d'arrivée du dégradé
            return gradient                                 // retour la varible gradiant pour l'affichege du dégradé dans la View
        }()
    
    //----------------------------------------
    
    override func viewDidLoad()
    {
       super.viewDidLoad()
        
        //----------------------------------------
        
        tableView.delegate = self       //
        tableView.dataSource = self     // Permet de récupérer les données de l'objet Table View
        tableView.reloadData()          // Permet de reecharger les données de l'objet Table View avec la mise à jour des informations
        
        //----------------------------------------
        
        gradient.frame = view.bounds                    //
        gradientView.layer.addSublayer(gradient)       // Initialise le dégradé
        
        //----------------------------------------
        
        searchBarView.delegate = self
 /*
        
//        searchBarView.subviews.forEach { subview in
//          if subview is _UISearchBarSearchContainerView {
//                subview.subviews.forEach { secondSubview in
//                    if secondSubview is UITextField {
//                        (secondSubview as! UITextField).textColor = .orange
//                    }
//                }
//            }
//        }
        
        let svs = searchBarView.subviews.flatMap{$0.subviews}
//        guard let tf = (svs.filter{$0 is UISearchBarSearchContainerView}).first as? UISearchBarSearchContainerView else {return}
        guard let tf = (svs.filter{$0 is UITextField}).first as? UITextField else {return}
        tf.textColor = UIColor.orange*/
    }
    
    //----------------------------------------
    
    func sendText(_ text: String,_ text2: String,_ text3: String/*_ text4: String*/)
    {
        //----------------------------------------
        tableViewContent.append(text)       //
        tableViewTitre.append(text2)        // Stocke les valeurs dans un tableaux
        tableViewObject.append(text3)       //
        
        tableViewObjectFiltered = tableViewObject
                        //
        //----------------------------------------
        
        DispatchQueue.main.async
        {
            self.tableView.reloadData()  // Permer de recherger les données de la tableView
        }
                //----------------------------------------
       
        print(text)         //
        print(text2)        // Test pour afficher les valeurs des text dans la consolle
        print(text3)        //
    }
    
    //----------------------------------------
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return tableViewObjectFiltered.count //self.tableViewContent.count     //
    }
    
    //----------------------------------------
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        
        //----------------------------------------
        
        let cell = (self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier)!) as! MailTableViewCell   //
        print("dddddddd" ,indexPath.row , tableViewObject.count)
            cell.configure(text1: self.tableViewTitre[indexPath.row],       //
                           text2: self.tableViewContent[indexPath.row],     //
                           text3: self.tableViewObjectFiltered[indexPath.row]
                               )     //
                                                      //
            
        
        
        //----------------------------------------
        
        print(tableView)        // Test affiche pour afficher la table view dans la console
        
        //----------------------------------------
        
        return cell  // Return la varaible cell
    }
    
    //----------------------------------------
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        
        //----------------------------------------
        
        print("You tapped cell number \(indexPath.row).")                                                                   //
        let storyboard = UIStoryboard(name: "Main", bundle: nil)                                                            //
        let thirdVC = storyboard.instantiateViewController(identifier: "ThirdViewController") as! ThirdViewController       //
        
        //----------------------------------------
        
        thirdVC.contentTextView = self.tableViewContent[indexPath.row]      //
        thirdVC.objectTextView = self.tableViewObject[indexPath.row]        //
        thirdVC.titreTextView = self.tableViewTitre[indexPath.row]          //
        
        //----------------------------------------
        
        self.navigationController?.pushViewController(thirdVC, animated: true)      // Permet de passer sur la ThirdViewController sachant que push affiche une nouvelle forme de la View
        
        //----------------------------------------
        
    }
    
    //----------------------------------------

    func searchBar (_ searchBar: UISearchBar, textDidChange searchText: String)
    {
        if searchText == "" {
            tableViewObjectFiltered = tableViewObject
            
        } else {
        var resultFilter = [String]()
        tableViewObject.forEach { item in
            if item.lowercased().contains(searchText.lowercased()) {
                resultFilter.append(item)
            }
        }
        
        tableViewObjectFiltered = resultFilter
        }
        
//        test = searchText.isEmpty ? tableViewObject : tableViewObject.filter
//        {
//            (item: String)-> Bool in
//            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
//        }
        tableView.reloadData()
    }

    //----------------------------------------
    
    @IBAction func firstButtonAction()
    {
        //----------------------------------------
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)                                                            //
        let secondVC = storyboard.instantiateViewController(identifier: "SecondViewController") as! SecondViewController    // Permet de changer de vue
        secondVC.firstViewDelegate = self                                                                                   //  Vers la SecondViewController
        self.navigationController?.pushViewController(secondVC, animated: true)                                             //
        
        //----------------------------------------
        
    }
    
    //----------------------------------------
    
    @IBAction func secondButtonAction()
    {
        //----------------------------------------
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)                                //
        let thirdVC = storyboard.instantiateViewController(identifier: "ThirdViewController")   // Permet de changer de vue
        self.navigationController?.pushViewController(thirdVC, animated: true)                  // Vers la ThirdViewController
        
        //----------------------------------------
    }
   
    //----------------------------------------
}

