import Cocoa
/*
 Given a non-empty binary tree, return the average value of the nodes on each level in the form of an array.
 Example 1:

 Input:
     3
    / \
   9  20
     /  \
    15   7
 
 Output: [3, 14.5, 11]
 Explanation:
 The average value of nodes on level 0 is 3,  on level 1 is 14.5, and on level 2 is 11. Hence return [3, 14.5, 11].
 Note:

 The range of node's value is in the range of 32-bit signed integer.
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

func averageOfLevels(_ root: TreeNode?) -> [Double] {

    var result = [Double]()
    
    // convert our tree into an array of TreeNode (this is an array of 1 item (the root) at this point)
    var nodes = [root].compactMap { $0 }
    
    // each array of nodes represents a level in the tree
    while nodes.count > 0 {
        
        // map allows us to provide the same operation to each array element
        // reduce will combine all items into a single new value.
        
        // getting the numerator and denominator for our average calculation
        let valueSum = Double(nodes.map { $0.val }.reduce(0, +))
        let nodeCount = Double(nodes.count)
        
        result.append( valueSum / nodeCount )
        
        // Create anew array by taking the left and right from each node in 'nodes'
        nodes = nodes.flatMap { [$0.left, $0.right].compactMap { $0 } }
    }
    
    return result
}


/*
 * Runtime: 80 ms ms, faster than 25.00% of Swift online submissions for Symmetric Tree.
 * Memory Usage: 15.2 MB, less than 80.00% of Swift online submissions for Symmetric Tree.
*/

let tree1: TreeNode = TreeNode.init(3)
tree1.left = TreeNode.init(9)
tree1.right = TreeNode.init(20)
tree1.right?.left = TreeNode.init(15)
tree1.right?.right = TreeNode.init(7)
print("\nOne:")
print(tree1.asString) // print to be sure i match the example
print(averageOfLevels(tree1))

let t2: TreeNode = TreeNode.init(1)
t2.left = TreeNode.init(2)
t2.right = TreeNode.init(2)
t2.right?.left = TreeNode.init(12)
t2.right?.left?.right = TreeNode.init(6)
t2.left?.right = TreeNode.init(3)
t2.right?.right = TreeNode.init(3)
print("\nTwo:")
print(t2.asString)
print(averageOfLevels(t2))

let t3: TreeNode? = nil // = TreeNode.init()
print("\nThree:")
print(averageOfLevels(t3))



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



