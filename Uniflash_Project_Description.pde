/* UniFlash_Project_Description
 *
 * Mutated from: https://processing.org/examples/directorylist.html
 * Author: (Forrest) Lee Erickson
 * Date: 20190924
 * This reads the UniFlash project JSON files and reports the project description.
 * The path is hard coded to my install. Change the path to your .SLImageCreator location.
 */
  
 import java.util.Date;
 color myBackground = color(0,255,0);

void setup() {
  size(200, 200);
  background(myBackground);
  stroke(255,0,0);
  fill(0);
    
  // Using just the path of this sketch to demonstrate,
  //String path = sketchPath();
  
  // but you can list any directory you like.
  String path = "C:\\Users\\Lee\\.SLImageCreator\\projects";

  //println("Listing all filenames in a directory: ");
  //String[] filenames = listFileNames(path);
  //printArray(filenames);

  //println("\nListing info about all files in a directory: ");
  //File[] files = listFiles(path);
  //for (int i = 0; i < files.length; i++) {
  //  File f = files[i];    
  //  println("Name: " + f.getName());
  //  println("Is directory: " + f.isDirectory());
  //  println("Size: " + f.length());
  //  String lastModified = new Date(f.lastModified()).toString();
  //  println("Last Modified: " + lastModified);
  //  println("-----------------------");
  //}

//  println("\nListing info about all '.json' files in a directory and all subdirectories in path: "+ path+"\n\r");
  println("### UniFlash project and Project Descriptions in path: "+ path+" ###\n\r");
  ArrayList<File> allFiles = listFilesRecursive(path);
  int fileNum = 0;
  int jsonNum = 0;

  for (File f : allFiles) {    
    String[] m1 = match(f.getName(), ".json");
    if (m1 != null ) { 
//      println("Name: " + f.getName());
//      println("Full path: " + f.getAbsolutePath());
      //println("Is directory: " + f.isDirectory());
      //println("Size: " + f.length());
//      String lastModified = new Date(f.lastModified()).toString();
//      println("Last Modified: " + lastModified);
      printDescription (f.getAbsolutePath(), f.getName());
      println("-----------------------\n\r");          
      jsonNum++;
    }// match for json.
    fileNum++;
  }
//  println("Total Files: " + allFiles );
  println("Total Files: " + fileNum);
  println("Total JSON Files: " + jsonNum);
}

// Simple GUI with mouse event handler
void draw() {  
  background(myBackground);
  text("UniFlash Projects and Descriptions",10,10);  
  text("Press Middle Mouse to Exit",10,175);
  //rect(100,100,25,25);
}

// This function returns all the files in a directory as an array of Strings  
String[] listFileNames(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    String names[] = file.list();
    return names;
  } else {
    // If it's not a directory
    return null;
  }
}

// This function returns all the files in a directory as an array of File objects
// This is useful if you want more info about the file
File[] listFiles(String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    File[] files = file.listFiles();
    return files;
  } else {
    // If it's not a directory
    return null;
  }
}

// Function to get a list of all files in a directory and all subdirectories
ArrayList<File> listFilesRecursive(String dir) {
  ArrayList<File> fileList = new ArrayList<File>(); 
  recurseDir(fileList, dir);
  return fileList;
}

// Recursive function to traverse subdirectories
void recurseDir(ArrayList<File> a, String dir) {
  File file = new File(dir);
  if (file.isDirectory()) {
    // If you want to include directories in the list
    a.add(file);  
    File[] subfiles = file.listFiles();
    for (int i = 0; i < subfiles.length; i++) {
      // Call this function on all files in this directory
      recurseDir(a, subfiles[i].getAbsolutePath());
    }
  } else {
    a.add(file);
  }
}

/*Print UniFlash project description from JSON file.*/
void printDescription (String path, String andfilename){
//  println("Filename: " + andfilename);
  String[] m = match(andfilename, "recents.json");
  if ( m == null) {
      //  String myFile = path+andfilename;
    String myFile = path;
   /* Get list of project from recent file */
  //  println("MyFile is: " + myFile);
    JSONObject json = loadJSONObject(myFile);
  //  println("File contains: " + json);
  
    /*Lets print just the project Header */
    JSONObject myHeader = json.getJSONObject("header");
  //  println("Header contains: " + myHeader);
  
    /*Lets print just the project Description */
    String myDescription = myHeader.getString("Description");
    println("Project: "+ andfilename + "\n\rDescription contains: " + myDescription);    
    }
   else {
     println("Got the project list. Not a proper JSON file."); 
   }      
}//Function printDescription


/*Event handlers */
void mousePressed() {
  if (mouseButton == LEFT) {
    myBackground = 255;
    /*Give user feedback */
    println("Left was pressed.");
 
} else if (mouseButton == RIGHT) {
    myBackground = 128;
   /*Give user feedback */
    println("Right was pressed.");
 
} else {  //Middle button exits.
    myBackground = 255;
    println("Exiting now.");
    delay(1000);
    exit();
  }
}
