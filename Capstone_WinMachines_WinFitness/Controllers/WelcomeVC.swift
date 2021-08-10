//
//  WelcomeVC.swift
//  Capstone_WinMachines_WinFitness
//
//  Created by Tej on 8/4/21.
//

import UIKit
import Firebase

class WelcomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createWorkouts()
        if let _ = Auth.auth().currentUser{
            let vc = storyboard?.instantiateViewController(identifier: Constants.HomeVC) as! HomeVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.segToSignup{
            let vc = segue.destination as! LoginVC
            vc.comeForLogin = false
        }
    }
    @IBAction func handleLogin(_ sender: Any) {
        performSegue(withIdentifier: Constants.segToLogin, sender: self)
    }
    @IBAction func handleSingup(_ sender: Any) {
        performSegue(withIdentifier: Constants.segToSignup, sender: self)
    }
    func createWorkouts(){
//        let x1 =  ["WorkoutName":"Squats",
//                  "Equipments":[],
//                  "video":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/videos%2F1.mp4?alt=media&token=34c3d7e5-4c2c-4fc9-94e3-f983d449df3f",
//                  "type":"reps","desc":"Sit back – make sure to move your butt backward, don’t just bend your knees. Be careful to keep your knees in line with your toes, don’t let them cave in. Don’t forget about your upper body – look straight ahead and don’t round your back"] as [String : Any]
//        let x2 =  ["WorkoutName":"Glute Bridge",
//                  "Equipments":["Mats"],
//                  "video":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/videos%2F3.mp4?alt=media&token=871e85cc-d1d4-4abc-863b-5d9942ba99fa",
//                  "type":"time","desc":"Lie face up on the floor, with your knees bent and feet flat on the ground. Keep your arms at your side with your palms down.Lift your hips off the ground until your knees, hips and shoulders form a straight line. Squeeze those glutes hard and keep your abs drawn in so you don’t overextend your back during the exercise.Hold your bridged position for a couple of seconds before easing back down."] as [String : Any]
//        let x3 =  ["WorkoutName":"Rest",
//                  "type":"rest"] as [String : Any]
//        let x4 =  ["WorkoutName":"Dumbbell Biceps Curl",
//                  "Equipments":["Mats","Dumbell"],
//                  "video":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/videos%2F2.mp4?alt=media&token=a995f7b2-5013-455c-9516-d5f0bdf2d8f9",
//                  "type":"reps","desc":"From standing, use an underhand grip to curl the weight into your shoulders. Avoid swinging the weights and keep your elbows forward and close to your sides."] as [String : Any]
//
//        let x5 =  ["WorkoutName":"Crunches",
//                  "Equipments":["Mats"],
//                  "video":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/videos%2F4.mp4?alt=media&token=453ee386-f6da-4e95-832a-246082badda9",
//                  "type":"reps","desc":"Lie down on your back. Plant your feet on the floor, hip-width apart. Bend your knees and place your arms across your chest. Contract your abs and inhale.Exhale and lift your upper body, keeping your head and neck relaxed.Inhale and return to the starting position."] as [String : Any]
//        let x6 =  ["WorkoutName":"Rest",
//                  "type":"rest"] as [String : Any]
//        let x7 =  ["WorkoutName":"Dumbbell lying squats",
//                  "Equipments":["Mats","Dumbell"],
//                  "video":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/videos%2F6.mp4?alt=media&token=f8c2f87a-d9ee-42be-ae20-db44bec4fd41",
//                  "type":"reps","desc":"Lie face down and extend your arms forward and your legs back. Lift your chest and legs off the ground, and hold this position as you perform a rowing movement squeezing the traps."] as [String : Any]
//        let _ = Database.database().reference().child("Workouts").childByAutoId().setValue(x1)
//        let _ = Database.database().reference().child("Workouts").childByAutoId().setValue(x2)
//        let _ = Database.database().reference().child("Workouts").childByAutoId().setValue(x3)
//        let _ = Database.database().reference().child("Workouts").childByAutoId().setValue(x4)
//        let _ = Database.database().reference().child("Workouts").childByAutoId().setValue(x5)
//        let _ = Database.database().reference().child("Workouts").childByAutoId().setValue(x6)
//        let _ = Database.database().reference().child("Workouts").childByAutoId().setValue(x7)
//        let b1 = ["name":"Egg Breakfast Recipes","image":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/images%2Fb1.jpg?alt=media&token=7e54bf91-20b3-4bec-988d-88693f3e718e","link":"https://www.loveandlemons.com/frittata-recipe/"]
//        let b2 = ["name":"Strawberry Banana Smoothie","image":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/images%2Fb2.jpg?alt=media&token=8973a8e8-7d54-4ff5-99e9-afa658de61ab","link":"https://www.loveandlemons.com/strawberry-banana-smoothie/"]
//        let b3 = ["name":"Avocado & Egg Brown Rice Bowls","image":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/images%2Fb3.jpg?alt=media&token=9c9bca95-0d49-40a1-9bd4-8c57fbfa9dad","link":"https://www.loveandlemons.com/avocado-egg-brown-rice-bowl/"]
//        let b4 = ["name":"Vegan Banana Pancakes","image":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/images%2Fb4.jpg?alt=media&token=7e62ec4b-f6a0-4ffc-b313-f84384608006","link":"https://www.loveandlemons.com/vegan-banana-pancakes/"]
//        let b5 = ["name":"Healthy Green Breakfast Tacos","image":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/images%2Fb5.jpg?alt=media&token=0227687c-28e9-4592-87a9-33db8205c663","link":"https://www.loveandlemons.com/healthy-breakfast-tacos/"]
//        let b6 = ["name":"Avocado Toast, with Banh Mi toppings","image":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/images%2Fb6.jpg?alt=media&token=25d68e2d-8b7c-4d2e-b66e-8a1819c2476f","link":"https://www.loveandlemons.com/avocado-toast/"]
//        let l1 = ["name":"Chipotle Veggie Burritos","image":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/images%2Fl1.jpeg?alt=media&token=516c9aaa-8922-4b67-9ab1-842f34b40a8f","link":"https://www.foodnetwork.com/recipes/food-network-kitchen/chipotle-veggie-burritos-3362667"]
//        let l2 = ["name":"Lemon-Herb Rice Salad","image":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/images%2Fl2.jpeg?alt=media&token=1fc9fb89-053f-4251-9d9f-7c726e42f4fb","link":"https://www.foodnetwork.com/recipes/food-network-kitchen/lemon-herb-rice-salad-recipe-2107971"]
//        let l3 = ["name":"Miso Soup","image":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/images%2Fl3.jpeg?alt=media&token=cbe84ba5-8c37-49a2-bf86-007c094fe7c3","link":"https://www.foodnetwork.com/recipes/food-network-kitchen/miso-soup-recipe-2102742"]
//        let l4 = ["name":"Keto Tuna Salad Cups","image":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/images%2Fl4.jpeg?alt=media&token=e1c3b646-7c62-4874-a919-84a184a2a06f","link":"https://www.foodnetwork.com/recipes/food-network-kitchen/keto-tuna-salad-cups-5266429"]
//        let l5 = ["name":"Lightened-Up Stuffed Peppers","image":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/images%2Fl5.jpeg?alt=media&token=9901229b-e7aa-4236-a4e4-ab392873b798","link":"https://www.foodnetwork.com/recipes/food-network-kitchen/lightened-up-stuffed-peppers-recipe-2119293"]
//        let l6 = ["name":"Tex-Mex Chicken Quinoa","image":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/images%2Fl6.jpeg?alt=media&token=5b72ef6d-7713-4f05-8631-658961c7ff9c","link":"https://www.foodnetwork.com/recipes/tex-mex-chicken-quinoa-3415260"]
//        let d1 = ["name":"Pan-Fried Tilapia","image":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/images%2Fd1.jpg?alt=media&token=f265f4dd-8d68-4a9f-85fb-cf7a2df0a74e","link":"https://www.delish.com/cooking/recipe-ideas/a25137966/pan-fried-tilapia-recipe/"]
//        let d2 = ["name":"Italian Sausage Stuffed Zucchini","image":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/images%2Fd2.jpg?alt=media&token=6d134c48-997a-4d33-830f-46e01183dd8f","link":"https://www.delish.com/cooking/recipe-ideas/recipes/a48829/italian-sausage-stuffed-zucchini-recipe/"]
//        let d3 = ["name":"Chicken Parm Stuffed Peppers","image":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/images%2Fd3.jpg?alt=media&token=750201d1-9e18-443a-82cb-2b5f17263b2c","link":"https://www.delish.com/cooking/recipe-ideas/recipes/a51054/chicken-parm-stuffed-peppers-recipe/"]
//        let d4 = ["name":"Baked Catfish","image":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/images%2Fd4.png?alt=media&token=659d216f-226e-4ec7-b59d-fe34e6ed3ac7","link":"https://www.delish.com/cooking/recipe-ideas/a26595303/best-baked-catfish-recipe/"]
//        let d5 = ["name":"Stuffed Cabbage","image":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/images%2Fd5.jpg?alt=media&token=591afa02-fbe8-4006-94be-b7c177848448","link":"https://www.delish.com/cooking/recipe-ideas/a23481075/stuffed-cabbage-rolls/"]
//        let d6 = ["name":"Caprese Zoodles","image":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/images%2Fd6.jpg?alt=media&token=ae73e2f2-34cd-46a4-9b1d-1aaabd2a7aaf","link":"https://www.delish.com/cooking/recipe-ideas/recipes/a47336/caprese-zoodles-recipe/"]
//        let s1 = ["name":"Roasted Chickpeas","image":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/images%2Fs1.jpg?alt=media&token=bc4cf333-17ac-4857-8c4f-3f9398c0abae","link":"https://www.delish.com/cooking/recipe-ideas/a32292000/roasted-chickpeas-recipe/"]
//        let s2 = ["name":"Honey-Garlic Cauliflower","image":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/images%2Fs2.jpg?alt=media&token=8c32ab73-0b28-4ec0-86cb-612d1aea876d","link":"https://www.delish.com/cooking/recipe-ideas/recipes/a47636/honey-garlic-cauliflower/"]
//        let s3 = ["name":"Bacon Avocado Fries","image":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/images%2Fs3.jpg?alt=media&token=1bbbde10-7257-49bc-9c75-7d9fadbe2527","link":"https://www.delish.com/cooking/recipe-ideas/recipes/a48261/bacon-avocado-fries-recipe/"]
//        let s4 = ["name":"Creamy Garlic Hummus","image":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/images%2Fs4.jpg?alt=media&token=08f1d110-2235-409c-8775-6d1a1d7d0842","link":"https://www.delish.com/cooking/recipe-ideas/a20089167/best-homemade-hummus-recipe/"]
//        let s5 = ["name":"Greek Feta Dip","image":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/images%2Fs5.jpg?alt=media&token=e177fa66-6eb1-47c2-8ee4-7c4941c90ebc","link":"https://www.delish.com/cooking/recipe-ideas/recipes/a50968/greek-feta-dip-recipe/"]
//        let s6 = ["name":"Avocado Chips","image":"https://firebasestorage.googleapis.com/v0/b/winfitness-ec238.appspot.com/o/images%2Fs6.jpg?alt=media&token=eac6028b-477a-4923-948c-86c2d69056ac","link":"https://www.delish.com/cooking/recipe-ideas/a21948089/avocado-chips-recipe/"]
//        let ref = Database.database().reference().child("Nutrition")
//        ref.child("Breakfast").childByAutoId().setValue(b1)
//        ref.child("Breakfast").childByAutoId().setValue(b2)
//        ref.child("Breakfast").childByAutoId().setValue(b3)
//        ref.child("Breakfast").childByAutoId().setValue(b4)
//        ref.child("Breakfast").childByAutoId().setValue(b5)
//        ref.child("Breakfast").childByAutoId().setValue(b6)
//        
//        ref.child("Lunch").childByAutoId().setValue(l1)
//        ref.child("Lunch").childByAutoId().setValue(l2)
//        ref.child("Lunch").childByAutoId().setValue(l3)
//        ref.child("Lunch").childByAutoId().setValue(l4)
//        ref.child("Lunch").childByAutoId().setValue(l5)
//        ref.child("Lunch").childByAutoId().setValue(l6)
//        
//        ref.child("Snack").childByAutoId().setValue(s1)
//        ref.child("Snack").childByAutoId().setValue(s2)
//        ref.child("Snack").childByAutoId().setValue(s3)
//        ref.child("Snack").childByAutoId().setValue(s4)
//        ref.child("Snack").childByAutoId().setValue(s5)
//        ref.child("Snack").childByAutoId().setValue(s6)
//        
//        ref.child("Dinner").childByAutoId().setValue(d1)
//        ref.child("Dinner").childByAutoId().setValue(d2)
//        ref.child("Dinner").childByAutoId().setValue(d3)
//        ref.child("Dinner").childByAutoId().setValue(d4)
//        ref.child("Dinner").childByAutoId().setValue(d5)
//        ref.child("Dinner").childByAutoId().setValue(d6)
//        
    }
}
