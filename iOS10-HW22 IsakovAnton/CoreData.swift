import Foundation
import CoreData

// Протокол для взаимодействия с вторым экраном
protocol SecondScreenView: class {
    func displayProfileData(name: String, birthDate: Date, gender: Gender)
}

class CoreDataManager {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "YourDataModelName")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error {
                fatalError("Unresolved error \(error), \(error.localizedDescription)")
            }
        })
        return container
    }()
    
    func addData(_ text: String) {
        let context = persistentContainer.viewContext
        let data = CoreDataModel(context: context)
        data.text = text
        
        do {
            try context.save()
        } catch {
            print("Error saving data: \(error)")
        }
    }
    
    func deleteData(at index: Int) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<CoreDataModel> = CoreDataModel.fetchRequest()
        
        do {
            let objects = try context.fetch(fetchRequest)
            context.delete(objects[index])
            try context.save()
        } catch {
            print("Error deleting data: \(error)")
        }
    }
    
    func loadProfileData() -> Profile? {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Profile> = Profile.fetchRequest()

        do {
            let profiles = try context.fetch(fetchRequest)
            if let profile = profiles.first {
                return profile
            }
        } catch {
            print("Error loading profile data: \(error)")
        }

        return nil
    }
    
    func saveProfileData(_ updatedProfileData: Profile) {
        let context = persistentContainer.viewContext
        
        // Сохраните контекст, чтобы сохранить изменения
        do {
            try context.save()
        } catch {
            print("Error saving profile data: \(error)")
        }
    }
}












