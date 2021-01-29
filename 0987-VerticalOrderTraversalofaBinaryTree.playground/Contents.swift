import UIKit
/*
 Given the root of a binary tree, calculate the vertical order traversal of the binary tree.

 For each node at position (x, y), its left and right children will be at positions (x - 1, y - 1) and (x + 1, y - 1) respectively.

 The vertical order traversal of a binary tree is a list of non-empty reports for each unique x-coordinate from left to right. Each report is a list of all nodes at a given x-coordinate. The report should be primarily sorted by y-coordinate from highest y-coordinate to lowest. If any two nodes have the same y-coordinate in the report, the node with the smaller value should appear earlier.

 Return the vertical order traversal of the binary tree.

Example 1:
   3
  / \
 9  20
   /  \
  15   7
 
 Input: root = [3,9,20,null,null,15,7]
 Output: [[9],[3,15],[20],[7]]
 Explanation: Without loss of generality, we can assume the root node is at position (0, 0):
 The node with value 9 occurs at position (-1, -1).
 The nodes with values 3 and 15 occur at positions (0, 0) and (0, -2).
 The node with value 20 occurs at position (1, -1).
 The node with value 7 occurs at position (2, -2).

Example 2:
      1
    /   \
   2     3
  / \   / \
 4   5 6   7
  
 Input: root = [1,2,3,4,5,6,7]
 Output: [[4],[2],[1,5,6],[3],[7]]
 Explanation: The node with value 5 and the node with value 6 have the same position according to the given scheme.
 However, in the report [1,5,6], the node with value 5 comes first since 5 is smaller than 6.

Constraints:
     The number of nodes in the tree is in the range [1, 1000].
     0 <= Node.val <= 1000
 */


public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

 
func verticalTraversal(_ root: TreeNode?) -> [[Int]] {

    var verticalOrder: [[Int]] = []
    
    // the node values for each column
    var resultHash: [Int: [Int]] = [:]
    
    // hold the column for each node
    var nodeQueue: [(node: TreeNode?, column: Int)] = []
    
    nodeQueue.append((root, 0))
    
    while !nodeQueue.isEmpty {
        
        var theCount = nodeQueue.count - 1
        
        var workingHash: [Int: [Int]] = [:]
        
        while theCount >= 0 {
            
            // process this node
            let treeNode = nodeQueue.removeFirst()
            let theNode = treeNode.node
            
            // do we already have a node in this column
            if workingHash[treeNode.column] == nil {
                workingHash[treeNode.column] = [theNode!.val]
            }
            else {
                workingHash[treeNode.column]!.append(theNode!.val)
            }
            
            // queue the children for processing
            if theNode?.left != nil {
                // each left node is - 1 from the parent
                nodeQueue.append((theNode?.left, treeNode.column - 1 ))
            }

            if theNode?.right != nil {
                // each right node is + 1
                nodeQueue.append((theNode?.right, treeNode.column + 1 ))
            }
            
            theCount -= 1
        }

        // add our temp hash table into the result hash
        for (key, value) in workingHash {
            if resultHash[key] != nil {
                resultHash[key]!.append(contentsOf: value.sorted())
            }
            else {
                resultHash[key] = value.sorted()
            }
        }
    }
    
    // create the result
    for key in resultHash.keys.sorted() {
        if let value = resultHash[key] {
            verticalOrder.append(value)
        }
    }
    
    return verticalOrder
}

let tree1: TreeNode = TreeNode.init(3)
tree1.left = TreeNode.init(9)
tree1.right = TreeNode.init(20)
tree1.right?.left = TreeNode.init(15)
tree1.right?.right = TreeNode.init(7)

print(verticalTraversal(tree1))
      
let tree2: TreeNode = TreeNode.init(1)
tree2.left = TreeNode.init(2)
tree2.left?.left = TreeNode.init(4)
tree2.left?.right = TreeNode.init(5)
tree2.right = TreeNode.init(3)
tree2.right?.left = TreeNode.init(6)
tree2.right?.right = TreeNode.init(7)

print(verticalTraversal(tree2))

/*
 Runtime: 12 ms Your runtime beats 78.57 % of swift submissions.
 Memory Usage: 14.8 MB Your memory usage beats 25.71 % of swift submissions.
*/
