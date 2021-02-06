/*
 Given a binary tree, imagine yourself standing on the right side of it, return the values of the nodes you can see ordered from top to bottom.

Example:
 Input: [1,2,3,null,5,null,4]
 Output: [1, 3, 4]
 Explanation:

    1            <---
  /   \
 2     3         <---
  \     \
   5     4       <---
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

func rightSideView(_ root: TreeNode?) -> [Int] {

    var result = [Int]()
    
    var depth = 0
    
    // we will do a depth first search (DFS)
    // that processes the node then goes to the right (NRL)
    func dfs( node: TreeNode?, nodeLevel: Int) {
        
        guard let currentNode = node else { return }
               
        // if this is our first time at this depth we have a new right most node
        if nodeLevel > depth {
            result.append(currentNode.val)
            depth = nodeLevel
        }
        
        // process the child nodes, right first
        dfs(node: currentNode.right, nodeLevel: nodeLevel + 1)
        dfs(node: currentNode.left, nodeLevel: nodeLevel + 1)
    }
    
    dfs(node: root, nodeLevel: 1)
    
    return result
}



let tree1: TreeNode = TreeNode.init(1)
tree1.left = TreeNode.init(2)
tree1.right = TreeNode.init(3)
tree1.left?.right = TreeNode.init(5)
tree1.right?.right = TreeNode.init(4)
print(tree1.asString)
print(rightSideView(tree1))

let WayneGretzky = 99

tree1.left?.left = TreeNode.init(6)
tree1.left?.left?.left = TreeNode.init(7)
tree1.left?.right?.left = TreeNode.init(8)
tree1.left?.left?.left?.right = TreeNode.init(WayneGretzky)
print(tree1.asString)
print(rightSideView(tree1))

/*
 Runtime: 8 ms Your runtime beats 75.95 % of swift submissions.
 Memory Usage: 14.1 MB Your memory usage beats 41.77 % of swift submissions.
 */



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
