/*
 Given two sorted integer arrays nums1 and nums2, merge nums2 into nums1 as one sorted array.

 The number of elements initialized in nums1 and nums2 are m and n respectively. You may assume that nums1 has a size equal to m + n such that it has enough space to hold additional elements from nums2.

Example 1:
 Input: nums1 = [1,2,3,0,0,0], m = 3, nums2 = [2,5,6], n = 3
 Output: [1,2,2,3,5,6]

Example 2:
 Input: nums1 = [1], m = 1, nums2 = [], n = 0
 Output: [1]

Constraints:
     nums1.length == m + n
     nums2.length == n
     0 <= m, n <= 200
     1 <= m + n <= 200
     -10^9 <= nums1[i], nums2[i] <= 10^9
 
 */
func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {

    // create two pointers at the end of each array
    var iNum1 = m - 1
    var iNum2 = n - 1
    
    // keep track of where we are in the first array
    var i = m + n - 1
    
    while (iNum1 >= 0) && (iNum2 >= 0) {
        
        // we will move the larger value
        if nums1[iNum1] > nums2[iNum2] {
            nums1[i] =  nums1[iNum1]
            iNum1 -= 1
        }
        else {
            nums1[i] = nums2[iNum2]
            iNum2 -= 1
        }
        
        i -= 1
    }
    
    // any left over nums2 need to be copied over
    // Note that any left over nums1 are already in place
    while iNum2 >= 0 {
        nums1[i] = nums2[iNum2]
        i -= 1
        iNum2 -= 1
    }
   
}

/*
 Runtime: 12 ms Your runtime beats 29.00 % of swift submissions.
 Memory Usage: 14 MB Your memory usage beats 67.14 % of swift submissions.
 */

var e1 = [1,2,3,0,0,0]
merge(&e1, 3, [2,5,6], 3)
print(e1)

var e2 = [1]
merge(&e2, 1, [], 0)
print(e2)

var teamCanada1987 = [2,4,5,6,7,8,9,10,11,12,14,16,21,22,26,27,28,30,31,32,66,77,99]
var teamCanada2010 = [1,2,6,7,8,10,11,12,15,16,18,18,20,21,22,24,27,29,30,37,51,61,87]

// 23 player rosters
teamCanada1987.append(contentsOf: Array(repeating: 0, count: 23))

merge(&teamCanada1987, 23, teamCanada2010, 23)
print(teamCanada1987)

/*
 
1987 Canada Cup
 2   Doug Crossman
 4   Craig Hartsburg
 5   Normand Rochefort
 6   James Patrick
 7   Ray Bourque
 8   Larry Murphy
 9   Glenn Anderson
 10  Dale Hawerchuk
 11  Mark Messier
 12  Mike Gartner
 14  Kevin Dineen
 16  Michel Goulet
 21  Brent Sutter
 22  Rick Tocchet
 26  Brian Propp
 27  Ron Hextall
 28  Doug Gilmour
 30  Kelly Hrudey
 31  Grant Fuhr
 32  Claude Lemieux
 66  Mario Lemieux
 77  Paul Coffey
 99  Wayne Gretzky

2010 Olympics
 1      ROBERTO LUONGO
 2      DUNCAN KEITH
 6      SHEA WEBER
 7      BRENT SEABROOK
 8      DREW DOUGHTY
 10     BRENDEN MORROW
 11     PATRICK MARLEAU
 12     JAROME IGINLA
 15     DANY HEATLEY
 16     JONATHAN TOEWS
 18     MIKE RICHARDS
 18     JOE THORNTON
 20     CHRIS PRONGER
 21     ERIC STAAL
 22     DAN BOYLE
 24     COREY PERRY
 27     SCOTT NIEDERMAYER
 29     MARC-ANDRÉ FLEURY
 30     MARTIN BRODEUR
 37     PATRICE BERGERON
 51     RYAN GETZLAF
 61     RICK NASH
 87     SIDNEY CROSBY
*/
