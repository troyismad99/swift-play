/*
 Given a string path, which is an absolute path (starting with a slash '/') to a file or directory in a Unix-style file system, convert it to the simplified canonical path.

 In a Unix-style file system, a period '.' refers to the current directory, a double period '..' refers to the directory up a level, and any multiple consecutive slashes (i.e. '//') are treated as a single slash '/'. For this problem, any other format of periods such as '...' are treated as file/directory names.

 The canonical path should have the following format:

     The path starts with a single slash '/'.
     Any two directories are separated by a single slash '/'.
     The path does not end with a trailing '/'.
     The path only contains the directories on the path from the root directory to the target file or directory (i.e., no period '.' or double period '..')

 Return the simplified canonical path.

Example 1:
 Input: path = "/home/"
 Output: "/home"
 Explanation: Note that there is no trailing slash after the last directory name.

Example 2:
 Input: path = "/../"
 Output: "/"
 Explanation: Going one level up from the root directory is a no-op, as the root level is the highest level you can go.

Example 3:
 Input: path = "/home//foo/"
 Output: "/home/foo"
 Explanation: In the canonical path, multiple consecutive slashes are replaced by a single one.

Example 4:
 Input: path = "/a/./b/../../c/"
 Output: "/c"

Constraints:
     1 <= path.length <= 3000
     path consists of English letters, digits, period '.', slash '/' or '_'.
     path is a valid absolute Unix path.
 */
//import Foundation

func simplifyPath(_ path: String) -> String {

    // a classic stack problem, you can go deep and come back up ...
    // ... when you come back up you don't care about the elements left behind
    var pathStack = [String]()
    
    for directory in path.split(separator: "/") {

        // we ignore these
        if directory == "." || directory == "" { continue }
        
        // go up if we can
        if (directory == "..") && (!pathStack.isEmpty) {
            pathStack.removeLast()
        }
        else {
            // guard against a path that starts with ..
            if directory != ".." {
                pathStack.append(String(directory))
            }
        }
    }
    
    // build the return
    return "/" + pathStack.joined(separator: "/")
}

print(simplifyPath("/home/"))
print(simplifyPath("/../"))
print(simplifyPath("/home//foo/"))
print(simplifyPath("/a/./b/../../c/"))

print(simplifyPath("/Users/troy/Development/xcode/swift-play"))
print(simplifyPath("/Users/troy/Development/SQL/../JavaScript/../xcode/swift-play"))

/*
 Runtime: 20 ms Your runtime beats 96.77 % of swift submissions.
 Memory Usage: 14.8 MB Your memory usage beats 51.61 % of swift submissions.
 */
