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
add `pod 'IMOStyledTableViewController', '~> 0.0.2'` to your Podfile
##Usage

####A - Style sheet

1 - Add a file named `style.imo` to your project, containing all the properties you want to customize (see the ~~wiki or~~ the demo for details on syntax and which properties are available).

2 - Make your table view controller, a subclass of IMOStyledTableViewController
```objective-c
#import "IMOStyledTableViewController.h"

@interface MyStyledTableViewController : IMOStyledTableViewController
```
3 - In your `- tableView:cellForRowAtIndexPath:` method, instead of using the regular boilerplate code to fire a UITableViewCell, use this:

```objective-c
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    IMOStyledCell *cell;
    cell = [IMOStyledCell cellForTableViewController:self 
    									 atIndexPath:indexPath 
    									       style:IMOStyledCellStyleValue1];
    /*
   		Do whatever you have to do with your cell   
	*/
    return cell;
}
```
*Notice that you don't have to handle dequeuing cells and declaring cell identifiers, IMOStyledTableViewController takes care of that for you.*

####B - Dictionary  

Although it's a good idea to use the style sheet strategy when all your Table View Controllers should use the same style, you might use the dictionary approach to customize that very single Table View Controller that may differ from the rest.  
Use the `-initWithStyle:styleSheet:`method and pass a dictionary of key/value 's to it:
```objective-c
NSDictionary *plainStyleSheet = 
@{
IMOStyledCellBackgroundImageKey: [UIImage imageNamed:@"clouds.png"],
IMOStyledCellNavBarTintColorKey:[UIColor colorWithRed:0.145 green:0.185 blue:0.359 alpha:1.000],
IMOStyledCellTopGradientColorKey:[UIColor colorWithWhite:0.945 alpha:0.220],
IMOStyledCellBottomGradientColorKey:[UIColor colorWithRed:0.628 green:0.632 blue:0.684 alpha:0.570],
IMOStyledCellTextLabelFontKey:[UIFont fontWithName:@"HelveticaNeue" size:18.0],
IMOStyledCellTextLabelTextColorKey:[UIColor whiteColor],
IMOStyledCellTopSeparatorColorKey:[UIColor colorWithRed:0.771 green:0.793 blue:0.820 alpha:1.000],
IMOStyledCellBottomSeparatorColorKey:[UIColor lightGrayColor]
};

 MyCustomStylePlainViewController *mcspvc = [[MyCustomStylePlainViewController alloc]
                                                 initWithStyle:UITableViewStylePlain
                                                    styleSheet:plainStyleSheet];

```  
##Keys and style properties

A style property name consists of a key name as declared in `IMOStyledCellKeys.h` minus the prefix *"IMOStyledCell"*  and the suffix *"key"*.  
Thus **"IMOStyledCellTopGradientColorKey"** gives **"CellTopGradientColor"**.

##style.imo parameters and syntax

You can enter colors in several ways
- RGBA Colors  between 0 and 1.0
- Hex Color 6 Digits 
- Hex Color 3 Digits 

For font, pass the font name and the size in float

For images, pass the name, no quote, no extension

Valid Boolean are :YES, yes, y, TRUE, true, t, NO, no, n, FALSE , F, f and of course 0 or 1,2,3,4,5,6,7,8,9.  
( see `NSString boolValue` for details)

#####Examples:
```
NavBarTintColor                 0.600   0.492   0.331   1.000 	//RGBA
BackgroundColor                 0xCDC3B9    					// Hex, 6 digits only
BackgroundImage                 clouds							// Image Name - Doesn't need extension
TextLabelFont                   HelveticaNeue-Bold       17.0	// Font name and size
TextLabelTextColor              #3F3B35							// Hex, 3 or 6 digits
``` 

 
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






##LICENSE
Copyright (C) 2013 Frederic Cormier

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
