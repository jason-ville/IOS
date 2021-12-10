//
//
//  Project Imail
//
//  Created by Jason Ville and Guilhem Couly on 18/11/2021.
//

import UIKit


class ThirdViewController: UIViewController
{
    //----------------------------------------
    
    @IBOutlet var ContentTextView : UITextView!     //
    @IBOutlet var ObjectTextView : UITextField!     //  Définition
    @IBOutlet var TitreTextView : UITextField!      //  Des objets
    @IBOutlet var gradientView3: UIView!            //
    
    //----------------------------------------
    
    lazy var gradient: CAGradientLayer =
        {
            //----------------------------------------
            
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
               
            //----------------------------------------
            
        }()
    //----------------------------------------
    
    override func viewDidLoad()
    {
        //----------------------------------------
        
        super.viewDidLoad()
        ContentTextView.text = contentTextView      //
        TitreTextView.text = titreTextView          // Associe les variables  Au contenue texte des objets
        ObjectTextView.text = objectTextView        //
        
        //----------------------------------------
        
        gradient.frame = view.bounds                //
        gradientView3.layer.addSublayer(gradient)   //  Initialise le dégradé
        
        //----------------------------------------
        
        ContentTextView.layer.borderWidth = 1                       // Definit la taille de la bordure de l'objet ContentTextView
        ContentTextView.layer.borderColor = UIColor.orange.cgColor  // Definit la couleur de la bordure de l'objet ContentTextView
        
        //----------------------------------------
    }
    func getDocumentDirectory() -> URL
    {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)   // Avec les autre cela me met des erreur index out of range et même en cheangeant le numéro de path cela bug
        return paths[0]
    }
    //----------------------------------------
    
    var contentTextView: String = ""            //
    var titreTextView: String = ""              //  Initialise les varaivles String à vide
    var objectTextView: String = ""             //
    
    //----------------------------------------
    
    @IBAction func newEmail()
    {
        //----------------------------------------
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)                                    //
        let secondVC = storyboard.instantiateViewController(identifier: "SecondViewController")     //   Permet de changer de vue vers la SecondViewController
        self.navigationController?.pushViewController(secondVC, animated: true)                     //
        
        //----------------------------------------
    }
    @IBAction func exporterFichier()
    {
        //----------------------------------------
        
        let content = contentTextView
        let title = objectTextView
        let email = titreTextView
        let textToWrite = content + " " + "Expiditeur:" + email
        
        //----------------------------------------
        
        let filename = getDocumentDirectory().appendingPathComponent(title + ".txt")
        do
        {
            try textToWrite.write(to: filename , atomically: true, encoding: String.Encoding.utf8)
        }
        catch
        {
    
           
            
        }
        print(filename)
        
        //----------------------------------------
    }
    //----------------------------------------
}
