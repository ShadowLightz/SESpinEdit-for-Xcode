# SESpinEdit

```A NSTextField``` and a ```NSStepper```in one control, which are always in sync. Known from many other frameworks as SpinEdit.

![equation](https://github.com/ShadowLightz/SESpinEdit-Demo/blob/Documentation/SESpinEdit_DemoApp.tiff?raw=true)

## Installation

Simply drag and drop the .h and .m file from the ```SESpinEdit``` into your project.

## Usage

Drag a custom view from the InterfaceBuilder into your window and set its class to ```SESpinEdit```. Resize the view to the height of 22 and a width greater than 43.

Make sure that Autolayout is active in your .xib file.

## Configure

InterfaceBuilder does not support any configuration in the sidebar for custom views. So you have to do it programmatically. Create first an outlet:

```objective-c
@property (weak) IBOutlet SESpinEdit* spinEdit
```

then you can customize it:

```objective-c
// Set a value:
self.spinEdit.value = @20;
// Set a maximum:
self.spinEdit.max = @3000;
// Set a minimum:
self.spinEdit.min = @-3000;
// Set the increment: 
self.spinEdit.increment = @2;
// Allow decimal numbers:
self.spinEdit.allowsFloats = YES;
```

There are two way to get notified about changed values. You can implement ```SESpinEditDelegate protocol``` and set the delegate or you use Key-Value-Observing.

## Contributing

* Create something awesome, make the code better or add some functionality,
  whatever (this is the hardest part).
* [Fork it](http://help.github.com/forking/)
* Create new branch to make your changes
* Commit all your changes to your branch
* Submit a [pull request](http://help.github.com/pull-requests/)

## Licence

Copyright (C) 2014 Jonathan Rahn

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

