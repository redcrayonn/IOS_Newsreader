//
//  ArticleTableViewController.swift
//  IOS Newsreader
//
//  Created by Dev Olaf on 22/01/2018.
//  Copyright © 2018 Dev Olaf. All rights reserved.
//

import UIKit

class ArticleTableViewController: UITableViewController {

    @IBOutlet weak var LoginButton: UIBarButtonItem!
    
    //MARK: Properties
    var articles = [Article]()
    var articleService: ArticleService = ArticleService()
    var nextId: Int?
    var pendingRequest: URLSessionTask? = nil
    var toasts: Toasts = Toasts()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        self.loadArticles()
        
        // Refresh table view articles
        self.refreshControl = UIRefreshControl();
        self.refreshControl!.addTarget((target: self), action: #selector(refresh),
                                       for: UIControlEvents.valueChanged)
        
        //loadSampleMeals()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return articles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return articles.count
    }

    // Infinite scrolling
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if  indexPath.row >= self.articles.count - 1 && self.pendingRequest == nil {
            self.loadArticles()
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCellIdentifier", for: indexPath) as? ArticleTableViewCell
        cell?.mapTo(with: articles[indexPath.row])
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 100.0;
    }
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "ArticleTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ArticleTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }

        let article = articles[indexPath.row]
        
        // Configure the cell...
        
        // cell.articleTitle.text = article.Title
        // cell.articleImage.image = article.photo
        
        return cell
    } */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation
     
    //     In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //         Get the new view controller using segue.destinationViewController.
        //         Pass the selected object to the new view controller.
        if let detailVC = segue.destination as? DetailViewController {
            if let cell = sender as? ArticleTableViewCell {
                detailVC.article = cell.article!
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super .viewWillAppear(animated)
        
        if User.currentUser().isLoggedIn {
            //registerBtn.isEnabled = false
        }
        
        self.refreshTable()
    }
    
    
    /* Navigation */
    /*
    @IBAction func toLoginView(_ sender: UIBarButtonItem) {
        if !User.currentUser().isLoggedIn{
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            let nextViewController = storyBoard.instantiateViewController(
                withIdentifier: "SBLogin") as! LoginViewController
            self.present(nextViewController, animated:true, completion:nil)
        } else {
            // Present an alert to the user which wants to log out
            self.alerts.logoutAlert(atVC: self, onLogout: {
                User.currentUser().username = nil
                User.currentUser().authToken = nil
                self.LoginButton.title = "Login"
                self.reloadArticles()
            })
        }
    }*/
    
    @IBAction func refresh() {
        checkInternetConnection { [weak self] in
            
            self?.refreshControl?.endRefreshing()
            self?.refreshTable()
        }
    }
    
    /*Custom functions*/
    
    // Refreshes the table view
    func refreshTable(){
        // Send async call to UI-thread
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func popoverDismissed() {
        self.navigationController?.dismiss(animated: true, completion: nil)
        
        if User.currentUser().isLoggedIn {
            self.LoginButton.title = "Logout"
        }
        
        self.reloadArticles()
    }
    
    func reloadArticles() {
        self.nextId = nil
        self.articles = []
        self.loadArticles()
    }
    
    func checkInternetConnection(whenConnected: @escaping () -> ()) {
        if toasts.isInternetAvailable() {
            whenConnected()
        } else {
            self.toasts.noInternetConnectionError(atVC: self, tryAgain: {
                self.reloadArticles()
            })
        }
    }
    
    func loadArticles() {
        checkInternetConnection {
            self.articleService.getArticles(nextId: self.nextId,
                                            onSuccess: { (result) in
                                                self.nextId = result.nextId!
                                                for article: Article in result.articleResults! {
                                                    self.articles.append(article)
                                                }
                                                self.refreshTable()
            }) {
                print("Something went wrong")
            }
        }
    }
    
    
    /* Dummy functions */
    /*
    private func loadSampleMeals() {
        
        
        let photo1 = UIImage(named: "placeholder")
        let photo2 = UIImage(named: "placeholder")
        let photo3 = UIImage(named: "placeholder")
        
        
        
        let meal1 = Article(Title: "Caprese Salad", photo: photo1)
        
        let meal2 = Article(Title: "Chicken and Potatoes", photo: photo2)
        
        let meal3 = Article(Title: "Pasta with Meatballs", photo: photo3)
        
        articles += [meal1, meal2, meal3]
    }
     */
}
