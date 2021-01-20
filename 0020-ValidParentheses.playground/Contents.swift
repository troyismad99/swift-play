/*
Given a string s containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is valid.

An input string is valid if:
     Open brackets must be closed by the same type of brackets.
     Open brackets must be closed in the correct order.

Example 1:
 Input: s = "()"
 Output: true

Example 2:
 Input: s = "()[]{}"
 Output: true

Example 3:
 Input: s = "(]"
 Output: false

Example 4:
 Input: s = "([)]"
 Output: false

Example 5:
 Input: s = "{[]}"
 Output: true

Constraints:
     1 <= s.length <= 104
     s consists of parentheses only '()[]{}'.

Hint 1:
 An interesting property about a valid parenthesis expression is that a sub-expression of a valid expression should also be a valid expression. (Not every sub-expression) e.g.

 { { } [ ] [ [ [ ] ] ] } is VALID expression
           [ [ [ ] ] ]    is VALID sub-expression
   { } [ ]                is VALID sub-expression

 Can we exploit this recursive structure somehow?

Hint 2:
 What if whenever we encounter a matching pair of parenthesis in the expression, we simply remove it from the expression? This would keep on shortening the expression. e.g.

 { { ( { } ) } }
       |_|

 { { (      ) } }
     |______|

 { {          } }
   |__________|

 {                }
 |________________|

 VALID EXPRESSION!

Hint 3:
 The stack data structure can come in handy here in representing this recursive structure of the problem. We can't really process this from the inside out because we don't have an idea about the overall structure. But, the stack can help us process this recursively i.e. from outside to inwards.
 */

func isValid(_ s: String) -> Bool {

    // assumption is at least one character, but we must have an even length string
    guard (s.count % 2) == 0 else { return false }
    
    let validBracketSets: [Character:Character] = [ "(":")", "{":"}", "[":"]" ]
    
    let openBrackets = Set<Character>(validBracketSets.keys)
    // let closeBrackets = Set<Character>(validBracketSets.values)
    
    var stack = [Character]();
    
    for bracket in s {
        
        // toss any open brackets onto the stack
        if openBrackets.contains(bracket) {
            stack.append(bracket)
        }
        else {
            // for a close bracket

            // guard against an empty stack and remove the last entry
            guard let last = stack.popLast() else { return false }
            
            // check if the previous value was the corresponding open
            if validBracketSets[last] != bracket {
                return false
            }
        }
    }
    
    // must be empty if everything matches
    return stack.isEmpty
}

print(isValid("()"))
print(isValid("()[]{}"))
print(isValid("(]"))
print(isValid("([)]"))
print(isValid("{[]}"))

print(isValid("("))
print(isValid("([)"))
print(isValid("]"))

print(isValid("{{}[][[[]]]}"))
print(isValid("{{({})}}"))

/*
 Runtime: 4 ms Your runtime beats 90.13 % of swift submissions.
 Memory Usage: 14.9 MB
 */
