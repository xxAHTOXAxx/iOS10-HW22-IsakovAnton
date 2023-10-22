import Foundation
import UIKit
import CoreData

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
    func saveUser(name: String) -> Profile? {
        let profileDescription: NSEntityDescription = NSEntityDescription.entity(forEntityName: "Profile", in: context)!
        let profile = NSManagedObject(entity: profileDescription, insertInto: context) as? Profile
        profile?.setValue(name, forKey: "name")
        do {
            try context.save()
            return profile
        } catch {
            print("Ошибка при сохранении данных: \(error.localizedDescription)")
            return nil
        }
    }
    
    // Удаление пользователя
    func deleteUsers(user: Profile) -> Bool {
        context.delete(user)
        do {
            try context.save() // Сохраняем изменения после удаления пользователя
            return true
        } catch {
            // Обрабатываем ошибку, например, регистрируем ее или показываем предупреждение пользователю
            print("Ошибка при удалении пользователя: \(error)")
            return false
        }
    }
    
    // Сохрание данных о пользователе
    func saveProfile(clousure: (Bool) -> ()) {
        do {
            try context.save()
            clousure(true)
        } catch {
            print("Ошибка при сохранении данных: \(error.localizedDescription)")
            clousure(false)
        }
    }
}
