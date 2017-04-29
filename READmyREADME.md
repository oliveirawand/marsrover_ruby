#Description

This is a summarized documentation of this project.

#Structure

I decided to separatethe files in different directories:

root
root/classes
root/io

The "root" is obviously the main directory (marsrover) of the project, which contains the READMs files, the "launcher" file for the application and a file with the automated tests.

The "classes" directory holds the files responsable for making the application works. Inside these files contain the logic and business rules of the application.

The "io" directory is where the files for reading of the inputs for the rovers MUST be. The output files with the rovers' last positions will also be placed here.

#Classes

I divided the projects in four classes:

marsrover => responsable for the launch of the application. It calls the Jarvis class, which will run the application.

Jarvis => this is the most important class. Jarvis holds about 95% of the logic and business rules of this project. It's responsable for read the input file, validate it, process its information and then output the final positionsof the rovers.

Rover => It's an entity. Rover class holds all the attributes locations that a rover must have.

Plateau => It's also an entity. Plateau class holds the information of its max extension.

#Rover methods

The methods of the rover class are reponsabel for execute the rover actions. They know how to do, but not when, and that's where Jarvis comes.

initialize => its a contructor for the Rover class. It can be empty or receive parameters.

moveForward => it's responsable for analyze the current rover's orientation and then calculate its next "step".

turn => here a parameter MUST be given. turn method analyzes its given parameter and the current rover's orientation and then sets the new rover's orientation.

move => a parameter MUST be given. This method manage what move the rover will do based on the given parameter. It analyzes and decide whether the rover will move forward or turn to some direction.

#Jarvis methods

readInput => a parameter with the file path must be given. This method analyzes if the given input file exists and, if it's true, read the file and calls the isAValidFileInput? method to validate it. If the file exists and is valid, all of its lines will be imported and then inputted inside an array.

executeCommands => this method processes the imported input lines and interprets the rovers instructions to decide if it will move or not and then determines the rovers final positions.

writeOutput => a parameter with the file path must be given. This method prints on the console screen and generate a file (based on the given path) with all the rovers final positions.

run => a parameter with the file path must be given. Jarvis can read, process and output the information separately, but he can also do it all at once. This methos provides it for him.

canMoveForward? => a rover object must be passed as a parameter. Based on the previously created Plateau and the current rover locations on it, this method says whether a rover can move forward or not.

isAValidFileInput? => after a file has been imported through the redInput method, this method will analyze every each line of the file and, if it find any invalid line during the process, an warning with the number of the invalid line and the cause of the error will be returned.

printExample => when called, this method prints on console screen a message saying that the imported file is invalid and shows a valid input file format.

#Tests

For automated tests, I created the class TestJarvis in the root directory. This class use the Test::Unit framework for unit testing in Ruby. It tests if the inputted lines from file reading and the output after the processing are working properly.

The file inputTest.txt inside io directory is used for the test, please don't delete it.

#Curiosities about some lines in the code

Inside the isAValidFileInput? method I use an unorthodox way to check if a string value contains a valid number. I decided to use it because when the value is setted it's read as a string, but I need it to be a number, so, if a call a method like is_a? for exemple, it won't pass through my test and, furthermore, if I try to convert the number and the variable contais an invalid value, it will crush. So i had to option: use a RegEx or did the way I did. The RegEx doesn't have a good performance and it's a little ugly to read, so i decided to do it my way. You can check the code on the line 190 of the method.