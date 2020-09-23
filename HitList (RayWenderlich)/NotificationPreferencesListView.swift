//
//  ContentView.swift
//  HitList (RayWenderlich)
//
//  Created by Jake Moskowitz on 9/23/20.
//  Copyright © 2020 Workday, Inc. All rights reserved.
//

import SwiftUI
import CoreData
import UIKit

struct NotificationPreferencesListView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    
    @FetchRequest(
      entity: NotificationPreferences.entity(),
      sortDescriptors: [
        NSSortDescriptor(keyPath: \NotificationPreferences.tenantID, ascending: true)
      ]
    ) var notificationPreferencesList: FetchedResults<NotificationPreferences>
    
    init() {
        fetchPreferencesOnLoad()
    }
    
    func getPreferences(for id: String) -> NotificationPreferences? {
        let managedContext = AppDelegate().persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NotificationPreferences>(entityName: "NotificationsPreferences")
        let predicate = NSPredicate(format: "tenantID = \(id)")
        fetchRequest.predicate = predicate
        
        do {
            let preferences = try managedContext.fetch(fetchRequest)
            return preferences.first
        } catch {
            return nil
        }
    }
    
    func addPreference(for id: String, isEnabled: Bool) {
        let managedContext = AppDelegate().persistentContainer.viewContext

        // NSEntityDescription links your new NSManagedObject with the entity definition in your Data Model at runtime
        let entity = NSEntityDescription.entity(forEntityName: "NoticicationPreferences",
                                                in: managedContext)!

        let preferences = NSManagedObject(entity: entity,
                                     insertInto: managedContext) as? NotificationPreferences

        
        preferences?.setValue(isEnabled, forKey: "notificationsEnabled")
        preferences?.setValue(id, forKey: "tenantID")
        
        do {
            try managedContext.save()
        } catch {}
    }
    
    // Highlights disk persistence of CoreData
    func fetchPreferencesOnLoad() {
        let managedContext = AppDelegate().persistentContainer.viewContext
        
        // Retrieves all NotificationPreferences entities, think of it like a query
        let fetchRequest = NSFetchRequest<NotificationPreferences>(entityName: "NotificationPreferences")
        
        do {
            notificationPreferencesList = try managedContext.fetch(fetchRequest)
        } catch {}
    }
    
    // pass people into here, people.map { Text(...) }
    var body: some View {
        VStack {
            notificationPreferencesList.map { $0
                HStack {
                    Text($0.tenantId)
                    Text($0.notificationsEnabled)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationPreferencesListView()
    }
}











//    let rTarget = Double.random(in: 0..<1)
//    let gTarget = Double.random(in: 0..<1)
//    let bTarget = Double.random(in: 0..<1)
//    // UI that uses these will update whenever these @State variable update
//    @State var rGuess: Double
//    @State var gGuess: Double
//    @State var bGuess: Double
//
//    // $ = read-write binding, use when you need to propagate value changes, and not just take in what value you get
//
//    var body: some View {
//        VStack {
//            HStack {
//                // Target color block
//                VStack {
//                  Rectangle()
//                    .foregroundColor(Color(red: rTarget, green: gTarget, blue: bTarget))
//                  Text("Match this color")
//                }
//                // Guess color block
//                VStack {
//                  Rectangle()
//                    .foregroundColor(Color(red: rGuess, green: gGuess, blue: bGuess))
//                  HStack {
//                    Text("R: \(Int(rGuess * 255.0))")
//                    Text("G: \(Int(gGuess * 255.0))")
//                    Text("B: \(Int(bGuess * 255.0))")
//                  }
//                }
//            }
//
//            Text("Button")
//
//            VStack {
//                ColorSlider(value: $rGuess, textColor: .red)
//                ColorSlider(value: $gGuess, textColor: .green)
//                ColorSlider(value: $bGuess, textColor: .blue)
//            }
//        }
//    }
//}
//
//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(rGuess: 0.5, gGuess: 0.5, bGuess: 0.5)
//    }
//}
//
//struct ColorSlider: View {
//    // Binds the value to State?
//    @Binding var value: Double
//    var textColor: Color
//    var body: some View {
//        HStack {
//            Text("0")
//                .foregroundColor(textColor)
//            // $ binds value to @State rGuess
//            Slider(value: $value)
//            Text("255")
//                .foregroundColor(textColor)
//        }
//        .padding()
//    }
//}
