#IMOStyledTableViewController
#An easy-to-customize style sheet based like Table View Controller.


### When this:
```
//style.imo
NavBarTintColor                 0.600   0.492   0.331   1.000
BackgroundColor                 #CDC3B9
TextLabelFont                   HelveticaNeue-Bold       17.0

TextLabelTextColor              #3F3B35

TopGradientColor                1.000   0.995   0.995   1.000
BottomGradientColor             0.825   0.780   0.724   1.000

SelectedTopGradientColor        #8A6F48
SelectedBottomGradientColor     #725C3C
```
###Generates this:
<center>
![screenshot]  
(http://www.i-mo.eu/zings/imostvc_small.png)
</center>
##Installation

###Manually  
Copy  the IMOStyledTableViewController directory to your project  

###Using cocoapods
~~add `pod 'IMOStyledTableViewController'` to your Podfile~~----  **Coming vey soon**
##Usage

1 - Add a file named `style.imo` to your project, containing all the properties you want to customize (see the wiki or the demo for details on syntax and which properties are available).

2 - Make your table view controller, a subclass of IMOStyledTableViewController
```objective-c
#import "IMOStyledTableViewController.h"

@interface MyStyledTableViewController : IMOStyledTableViewController
```
3 - In your `- tableView:cellForRowAtIndexPath:` method, instead of using the regular boilerplate code to fire a UITableViewCell, use this:

```objective-c
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    IMOStyledCell *cell;
    cell = [IMOStyledCell cellForTableViewController:self atIndexPath:indexPath style:IMOStyledCellStyleValue1];
    /*
   		Do whatever you have to do with your cell   
	*/
    return cell;
}
```
*Notice that you don't have to handle dequeuing cells and declaring cell identifiers, IMOStyledTableViewController takes care of that for you.*

  
  
##IMOStyledTableViewController comes with several predefined cell subclasses:
* IMOStyledCell
* IMOStyledEditCell
* IMOStyledNoteViewCell
* IMOStyledImageCell

Check the demo  for examples on using these subclasses

##Properties at your disposal
property					| Comments
----------------------------|-------------------------
NavBarTintColor				|Color of the navigation bar and of the IMOStyledNoteViewCell's accessory view
BackgroundImage   			|Table View Controller background image name
BackgroundColor				|Table View Controller background color
TopGradientColor 			|Cell's top gradient color
BottomGradientColor 		|Cell's bottom gradient color
SelectedTopGradientColor	|Selected cell's top gradient color
SelectedBottomGradientCo	|Selected cell's bottom gradient color
TopSeparatorColor			|Cell's top line separator color 
BottomSeparatorColor		|Cell's bottom line separator color
TextLabelTextColor 			|same as in UITableViewCells
DetailTextLabelTextColor	|same as in UITableViewCells
TextLabelFont 				|same as in UITableViewCells
DetailTextLabelFont 		|same as in UITableViewCells
UseCustomHeader 			|the property name says it all
HeaderFont 					|if UseCustomHeader is YES
HeaderTextColor 			|if UseCustomHeader is YES
UseCustomFooter 			|Guess what ?
FooterFont 					|Again
FooterTextColor 			|No comment
TextFieldFont 				|This is the textfield of an IMOStyledEditCell
TextFieldTextColor 			|This is the textfield of an IMOStyledEditCell
TextCaptionFont 			|The TextCaption is the label on the left of the textfield in an IMOStyledEditCell
TextCaptionTextColor 		|same
NoteViewFont 				|Note views cell with multiple editing lines
NoteViewTextColor 			|guess
NoteViewLineColor 			|guess
PlaceHolderFont				|Change to your taste
PlaceHolderTextColor		|Depending on your cell color… you may want to change this

##Syntax of an .imo file

soon


##LICENSE
Copyright (C) 2013 Frederic Cormier

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
