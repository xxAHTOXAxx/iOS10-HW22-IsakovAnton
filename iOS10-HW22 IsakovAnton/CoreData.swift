import Foundation
import UIKit
import CoreData

// Протокол для взаимодействия с вторым экраном
protocol SecondScreenView: class {
    func displayProfileData(name: String, birthDate: Date, gender: Gender)
}

class CoreDataManager {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // Загрузка данных
        func getUsers() -> [Profile] {
            do {
                let fetchRequest = NSFetchRequest<Profile>(entityName: "Profile")
                let objects = try context.fetch(fetchRequest)
                return objects
            } catch {
                print("Ошибка при загрузке данных: \(error.localizedDescription)")
                return []
            }
        }
        
        // Сохранение данных
        func saveUsers() {
            do {
                try context.save()
            } catch {
                print("Ошибка при сохранении данных: \(error.localizedDescription)")
            }
        }
        
        // Добавление нового пользователя
    func addUsers(name: String, gender: Int16, birthDate: Date) {
            let newUser = Profile(context: context)
            newUser.name = name
            newUser.gender = gender
            newUser.birthDate = birthDate
            saveUsers()
        }
        
        // Удаление пользователя
        func deleteUsers(user: Profile) {
            context.delete(user)
            saveUsers()
        }
    }
