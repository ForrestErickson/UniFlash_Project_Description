/* ListingFiles
 *
 * From: https://processing.org/examples/directorylist.html
 *
 */
 
 
 import java.util.Date;

void setup() {

  // Using just the path of this sketch to demonstrate,
  // but you can list any directory you like.

  //String path = sketchPath();
  String path = "C:\\Users\\Lee\\.SLImageCreator\\projects";

  println("Listing all filenames in a directory: ");
  String[] filenames = listFileNames(path);
  printArray(filenames);

  println("\nListing info about all files in a directory: ");
  File[] files = listFiles(path);
  for (int i = 0; i < files.length; i++) {
    File f = files[i];    
    println("Name: " + f.getName());
    println("Is directory: " + f.isDirectory());
    println("Size: " + f.length());
    String lastModified = new Date(f.lastModified()).toString();
    println("Last Modified: " + lastModified);
    println("-----------------------");
  }

  println("\nListing info about all files in a directory and all subdirectories: ");
  ArrayList<File> allFiles = listFilesRecursive(path);
  int fileNum = 0;
  int jsonNum = 0;

  for (File f : allFiles) {    
    String[] m1 = match(f.getName(), ".json");
    if (m1 != null ) { 
    println("Name: " + f.getName());
    println("Full path: " + f.getAbsolutePath());
    println("Is directory: " + f.isDirectory());
    println("Size: " + f.length());
    String lastModified = new Date(f.lastModified()).toString();
    println("Last Modified: " + lastModified);
    println("-----------------------");
    jsonNum++;
    }// match for json.
    
    
    fileNum++;
  }
//  println("Total Files: " + allFiles );
  println("Total JSON Files: " + jsonNum);
  println("Total Files: " + fileNum);

  noLoop();
}

// Nothing is drawn in this program and the draw() doesn't loop because
// of the noLoop() in setup()
void draw() {
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
