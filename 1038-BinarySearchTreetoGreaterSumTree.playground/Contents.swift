/*
 Given the root of a Binary Search Tree (BST), convert it to a Greater Tree such that every key of the original BST is changed to the original key plus sum of all keys greater than the original key in BST.

 As a reminder, a binary search tree is a tree that satisfies these constraints:
     The left subtree of a node contains only nodes with keys less than the node's key.
     The right subtree of a node contains only nodes with keys greater than the node's key.
     Both the left and right subtrees must also be binary search trees.

 Note: This question is the same as 538: https://leetcode.com/problems/convert-bst-to-greater-tree/

Example 1:
 Input: root = [4,1,6,0,2,5,7,null,null,null,3,null,null,null,8]
 Output: [30,36,21,36,35,26,15,null,null,null,33,null,null,null,8]

Example 2:
 Input: root = [0,null,1]
 Output: [1,null,1]

Example 3:
 Input: root = [1,0,2]
 Output: [3,3,2]

Example 4:
 Input: root = [3,2,4,1]
 Output: [7,9,4,10]

 Constraints:
     The number of nodes in the tree is in the range [1, 100].
     0 <= Node.val <= 100
     All the values in the tree are unique.
     root is guaranteed to be a valid binary search tree.

 */

 // Definition for a binary tree node.
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

func convertBST(_ root: TreeNode?) -> TreeNode? {

    /*
      We will travel all the way to the right and ...
      recurse our way back to the left 'summing' as we go
    */
    var currentSum = 0
    dfsRNLSum(root, &currentSum)
    
    return root
}

// a RNL implememntation
// 1. Go right
// 2. Process the node
// 3. Go left
func dfsRNLSum (_ node: TreeNode?, _ currentSum: inout Int){
    
    guard let node = node else { return }
    
    // go right
    dfsRNLSum(node.right, &currentSum)
    
    // process
    currentSum += node.val
    node.val = currentSum
    
    // go left
    dfsRNLSum(node.left, &currentSum)
}

/*
 Runtime: 76 ms Your runtime beats 81.82 % of swift submissions.
 Memory Usage: 15.7 MB Your memory usage beats 68.18 % of swift submissions.
 */


/*
Example 1:
 Input: root = [4,1,6,0,2,5,7,null,null,null,3,null,null,null,8]
 Output: [30,36,21,36,35,26,15,null,null,null,33,null,null,null,8]
*/
let tree1: TreeNode = TreeNode.init(4)
tree1.left = TreeNode.init(1)
tree1.right = TreeNode.init(6)

tree1.left?.left = TreeNode.init(0)
tree1.left?.right = TreeNode.init(2)
tree1.right?.left = TreeNode.init(5)
tree1.right?.right = TreeNode.init(7)

tree1.left?.right?.right = TreeNode.init(3)
tree1.right?.right?.right = TreeNode.init(8)
print("\nOne:")
print(tree1.asString)
print(convertBST(tree1)!.asString)

/*
Example 2:
 Input: root = [0,null,1]
 Output: [1,null,1]
*/
let t2: TreeNode = TreeNode.init(0)
t2.right = TreeNode.init(1)
print("\nTwo:")
print(t2.asString)
print(convertBST(t2)!.asString)

/*
Example 3:
 Input: root = [1,0,2]
 Output: [3,3,2]
*/
let t3: TreeNode = TreeNode.init(1)
t3.left  = TreeNode.init(0)
t3.right = TreeNode.init(2)
print("\nThree:")
print(t3.asString)
print(convertBST(t3)!.asString)

/*
Example 4:
 Input: root = [3,2,4,1]
 Output: [7,9,4,10]
*/
let t4: TreeNode = TreeNode.init(3)
t4.left  = TreeNode.init(2)
t4.right = TreeNode.init(4)
t4.left?.left  = TreeNode.init(1)
print("\nFour:")
print(t4.asString)
print(convertBST(t4)!.asString)





// boiler plate below

import Foundation

// Found on stackOverflow
// https://stackoverflow.com/questions/43898440/how-to-draw-a-binary-tree-in-console/43903427
// From Alain T (https://stackoverflow.com/users/5237560/alain-t)
public func treeString<T>(_ node:T, reversed:Bool=false, isTop:Bool=true, using nodeInfo:(T)->(String,T?,T?)) -> String
{
   // node value string and sub nodes
   let (stringValue, leftNode, rightNode) = nodeInfo(node)

   let stringValueWidth  = stringValue.count

   // recurse to sub nodes to obtain line blocks on left and right
   let leftTextBlock     = leftNode  == nil ? []
                         : treeString(leftNode!,reversed:reversed,isTop:false,using:nodeInfo)
                           .components(separatedBy:"\n")
    
   let rightTextBlock    = rightNode == nil ? []
                         : treeString(rightNode!,reversed:reversed,isTop:false,using:nodeInfo)
                           .components(separatedBy:"\n")

   // count common and maximum number of sub node lines
   let commonLines       = min(leftTextBlock.count,rightTextBlock.count)
   let subLevelLines     = max(rightTextBlock.count,leftTextBlock.count)

   // extend lines on shallower side to get same number of lines on both sides
   let leftSubLines      = leftTextBlock
                         + Array(repeating:"", count: subLevelLines-leftTextBlock.count)
   let rightSubLines     = rightTextBlock
                         + Array(repeating:"", count: subLevelLines-rightTextBlock.count)

   // compute location of value or link bar for all left and right sub nodes
   //   * left node's value ends at line's width
   //   * right node's value starts after initial spaces
   let leftLineWidths    = leftSubLines.map{$0.count}
   let rightLineIndents  = rightSubLines.map{$0.prefix{$0==" "}.count  }

   // top line value locations, will be used to determine position of current node & link bars
   let firstLeftWidth    = leftLineWidths.first   ?? 0
   let firstRightIndent  = rightLineIndents.first ?? 0


   // width of sub node link under node value (i.e. with slashes if any)
   // aims to center link bars under the value if value is wide enough
   //
   // ValueLine:    v     vv    vvvvvv   vvvvv
   // LinkLine:    / \   /  \    /  \     / \
   //
   let linkSpacing       = min(stringValueWidth, 2 - stringValueWidth % 2)
   let leftLinkBar       = leftNode  == nil ? 0 : 1
   let rightLinkBar      = rightNode == nil ? 0 : 1
   let minLinkWidth      = leftLinkBar + linkSpacing + rightLinkBar
   let valueOffset       = (stringValueWidth - linkSpacing) / 2

   // find optimal position for right side top node
   //   * must allow room for link bars above and between left and right top nodes
   //   * must not overlap lower level nodes on any given line (allow gap of minSpacing)
   //   * can be offset to the left if lower subNodes of right node
   //     have no overlap with subNodes of left node
   let minSpacing        = 2
   let rightNodePosition = zip(leftLineWidths,rightLineIndents[0..<commonLines])
                           .reduce(firstLeftWidth + minLinkWidth)
                           { max($0, $1.0 + minSpacing + firstRightIndent - $1.1) }


   // extend basic link bars (slashes) with underlines to reach left and right
   // top nodes.
   //
   //        vvvvv
   //       __/ \__
   //      L       R
   //
   let linkExtraWidth    = max(0, rightNodePosition - firstLeftWidth - minLinkWidth )
   let rightLinkExtra    = linkExtraWidth / 2
   let leftLinkExtra     = linkExtraWidth - rightLinkExtra

   // build value line taking into account left indent and link bar extension (on left side)
   let valueIndent       = max(0, firstLeftWidth + leftLinkExtra + leftLinkBar - valueOffset)
   let valueLine         = String(repeating:" ", count:max(0,valueIndent))
                         + stringValue
   let slash             = reversed ? "\\" : "/"
   let backSlash         = reversed ? "/"  : "\\"
   let uLine             = reversed ? "¯"  : "_"
   // build left side of link line
   let leftLink          = leftNode == nil ? ""
                         : String(repeating: " ", count:firstLeftWidth)
                         + String(repeating: uLine, count:leftLinkExtra)
                         + slash

   // build right side of link line (includes blank spaces under top node value)
   let rightLinkOffset   = linkSpacing + valueOffset * (1 - leftLinkBar)
   let rightLink         = rightNode == nil ? ""
                         : String(repeating:  " ", count:rightLinkOffset)
                         + backSlash
                         + String(repeating:  uLine, count:rightLinkExtra)

   // full link line (will be empty if there are no sub nodes)
   let linkLine          = leftLink + rightLink

   // will need to offset left side lines if right side sub nodes extend beyond left margin
   // can happen if left subtree is shorter (in height) than right side subtree
   let leftIndentWidth   = max(0,firstRightIndent - rightNodePosition)
   let leftIndent        = String(repeating:" ", count:leftIndentWidth)
   let indentedLeftLines = leftSubLines.map{ $0.isEmpty ? $0 : (leftIndent + $0) }

   // compute distance between left and right sublines based on their value position
   // can be negative if leading spaces need to be removed from right side
   let mergeOffsets      = indentedLeftLines
                           .map{$0.count}
                           .map{leftIndentWidth + rightNodePosition - firstRightIndent - $0 }
                           .enumerated()
                           .map{ rightSubLines[$0].isEmpty ? 0  : $1 }


   // combine left and right lines using computed offsets
   //   * indented left sub lines
   //   * spaces between left and right lines
   //   * right sub line with extra leading blanks removed.
   let mergedSubLines    = zip(mergeOffsets.enumerated(),indentedLeftLines)
                           .map{ ( $0.0, $0.1, $1 + String(repeating:" ", count:max(0,$0.1)) ) }
                           .map{ $2 + String(rightSubLines[$0].dropFirst(max(0,-$1))) }

   // Assemble final result combining
   //  * node value string
   //  * link line (if any)
   //  * merged lines from left and right sub trees (if any)
   let treeLines = [leftIndent + valueLine]
                 + (linkLine.isEmpty ? [] : [leftIndent + linkLine])
                 + mergedSubLines

   return (reversed && isTop ? treeLines.reversed(): treeLines)
          .joined(separator:"\n")
}

// required for the treestring
extension TreeNode
{
   var asString:String { return treeString(self){("\($0.val)",$0.left,$0.right)}  }
}


