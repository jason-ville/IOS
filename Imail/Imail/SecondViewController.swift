//
//
//  Project Imail
//
//  Created by Jason Ville and Guilhem Coulyon 18/11/2021.
//

import UIKit
import InstantSearchVoiceOverlay

//----------------------------------------

protocol FirstViewDelegate: AnyObject       // Le protocole permet de faire remonter les information d'une vu
                                            // inférieur vers une vue supérieur , Exemple : de SecondeViewControler vers ViewController
{
    //----------------------------------------
    
    func sendText(_ text1: String,  //
                  _ text2 : String, // Recupére les valeur des différents text qui sont de type string pour les envoyées vers une autre vu
                  _ text3 : String) //
    
    //----------------------------------------
}

//----------------------------------------

class SecondViewController: UIViewController
{
    //----------------------------------------
    
    
    //----------------------------------------
    
    @IBOutlet var mailTextView: UITextView!             //
    @IBOutlet var objectTextView: UITextField!          //
    @IBOutlet var destinataireTextView: UITextField!    //   Définition des objets
    @IBOutlet var vocalbouton : UIButton!               //
    @IBOutlet var gradientView2: UIView!                //
    
    //----------------------------------------
    
    lazy var speech : VoiceOverlayController =
        {
            let record =
                {
                    return SpeechController(locale: Locale(identifier: "fr_FR"))
                    
                }
            return VoiceOverlayController(speechControllerHandler: record)
            
        }()
    
    //----------------------------------------
    
    weak var firstViewDelegate: FirstViewDelegate!      // weak permet de crée un lien faible entre les vu pour le protocole
    
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
        super.viewDidLoad()
        
        //----------------------------------------
        
        gradient.frame = view.bounds                    //
        gradientView2.layer.addSublayer(gradient)       //  Initialise le dégradé
        
        //----------------------------------------
        
        mailTextView.layer.borderWidth = 1                          // Definit la taille de la bordure de l'objet ContentTextView
        mailTextView.layer.borderColor = UIColor.orange.cgColor     // Definit la couleur de la bordure de l'objet ContentTextView
        
        //----------------------------------------
        
    }
    
    //----------------------------------------
    
    @IBAction func BoutonStock()
    {
        //----------------------------------------
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)                                    //
        _ = storyboard.instantiateViewController(identifier: "ViewController") as! ViewController   //
        let destinataire = destinataireTextView.text?.components(separatedBy: ",")                  // Crée une varaible permetant d'inclure plusieur
                                                                                                    // destinataire si ils sont séparé par une variable
                                                                                                    //
        var emailValide = true                                                                      // Définit une varaible emailValide qui initialisé à vrai par défaut
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"                           // Crée un patern pour l'adresse Email ce qui sert a obligée l'utilisateur a un format valide
        let emailPred = NSPredicate(format:"SELF MATCHES %@", pattern)                              //
        
        //----------------------------------------
        
        for i in 0...destinataire!.count - 1                //
        {
            if(!emailPred.evaluate(with:destinataire![i]))      //
            {
                emailValide = false     // Retourne si la condtion est vrai que emailValide et faux
            }
        }
        
        if (emailValide)
        {
            self.firstViewDelegate.sendText(mailTextView.text , destinataireTextView.text! , objectTextView.text!)      // Si la condition vérifié envoie avec le protocole les différente                                                                                                                 // information sour forme de texte
        }
        
        //----------------------------------------
        
        else
        {
            
            //----------------------------------------
            
            let alert = UIAlertController(title: "ERREUR!!!!", message: "Veullez saisir une adresse email valide", preferredStyle: .alert)   // Définit  le pop up de type alert avec le titre
                                                                                                                                             // et le message à affichée
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"),                                         //
                                          style: .default, handler: {_ in NSLog("The\"OK\" alert occured." )                                 //
                                          }))                                                                                                //
            self.present(alert, animated: true, completion: nil)                                                                             // Permet l'animation du pop up
           
            //----------------------------------------
            
        }
        
        self.navigationController?.popViewController(animated: true)     // Si pas d'execption alors on revien à la vue précédente
        
        //----------------------------------------
    }
    
    //----------------------------------------
    
   
    
    //----------------------------------------
    
    @IBAction func BoutonSpeak()
    {
         speechToText(objectTextView, nil)    // appelle la fonction speechtotext pour transférer ce qu'on récupére avec la saisie vocal dans un TextView
    }
    
    //----------------------------------------
    
    @IBAction func BoutonSpeak2()
    {
         speechToText(nil , mailTextView)  // Appelle la fonction speechtotext pour transférer ce qu'on récupére avec la saisie vocal dans un TextView
    }
    
    //----------------------------------------
    
    func speechToText(_ texteField : UITextField? ,_ textview : UITextView?)
    {
        speech.start(on: self)
                        {
                            texttospeech , final, _ in
                            if final
                            {
                                if texteField == nil {
                                    
                                    textview?.text = texttospeech
                                    
                                }
                                else
                                {
                                    texteField?.text=texttospeech
                                    
                                }
                                print("Final text: \(texttospeech)")
                                
                            }
                            else
                            {
                                print("In progress: \(texttospeech)")
                                if texteField == nil {
                                    
                                    textview?.text = texttospeech
                                    
                                }
                                else
                                {
                                    texteField?.text=texttospeech
                                    
                                }
                                
                            }
                        } errorHandler:
                            {
                                error in
                                print("Error")
                            }
                    
        
        
    }
    
    //----------------------------------------
    
}
