
The program is based on learning the principles of OOP in the Ruby language.
Railway station system with the ability to create and manage routes and trains of various types.
Work from courses Thinknetica.
---

Exercise:
- Break the program into separate classes (each class in a separate file)
- Divide trains into two types PassengerTrain and CargoTrain, make a parent for classes that will contain common methods and properties
- Determine which methods can be placed in private/protected and put them in such a section. In a comment to the method, justify why it was made private/protected
- Wagons are now divided into freight and passenger (separate classes). Only passenger trains can be attached to a passenger train, and freight trains can be attached to a freight train.
- When adding a wagon to a train, the wagon object must be passed as a method argument and stored in the train's internal array, unlike the previous task, where we only counted the number of wagons. The constructor parameter "number of wagons" can be deleted.
