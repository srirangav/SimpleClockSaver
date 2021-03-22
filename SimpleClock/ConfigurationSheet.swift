/*
    SimpleClock.saver - ConfigurationSheet.swift

    History:

    v. 1.0.0 (03/22/2021) - Initial version

    Based on: https://github.com/edwardloveall/ColorClockSaver/blob/master/ColorClockSaver/ConfigureSheet.swift

    Copyright (c) 2021 Sriranga R. Veeraraghavan <ranga@calalum.org>

    Permission is hereby granted, free of charge, to any person obtaining
    a copy of this software and associated documentation files (the "Software"),
    to deal in the Software without restriction, including without limitation
    the rights to use, copy, modify, merge, publish, distribute, sublicense,
    and/or sell copies of the Software, and to permit persons to whom the
    Software is furnished to do so, subject to the following conditions:

    The above copyright notice and this permission notice shall be included
    in all copies or substantial portions of the Software.

    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
    OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
    THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
    DEALINGS IN THE SOFTWARE.
*/

import Cocoa

class ConfigurationSheet
{

    /* create a shared instance of this configuration sheet */
    
    static var sharedInstance = ConfigurationSheet()
    
    /* get the user settings */
    
    let settings = Settings()

    /* the configuration sheet's window */
    
    @IBOutlet var window: NSWindow!
    
    /*
        the checkbox for specifying whether the date should be displayed in
        long format
     */
    
    @IBOutlet weak var longDateCheck: NSButton!

    /* initialization */
    
    init()
    {
        /* get our bundle and load the NIB/XIB for the configuration sheet */
        
        let bundle = Bundle(for: ConfigurationSheet.self)
        bundle.loadNibNamed("ConfigurationSheet",
                            owner: self,
                            topLevelObjects: nil)
        
        /*
            set the state of the long date checkbox based on the user's
            last saved settings
         */
        
        longDateCheck.state = settings.longDateStateForCheckBox()
    }

    /* done - close the sheet */
    
    @IBAction func done(_ sender: NSButton)
    {
        guard let parent = window.sheetParent
        else
        {
            fatalError("Can't get parent window")
        }
        parent.endSheet(window)
    }
    
    /*
        setLongDate - change the user's preferences when the checkbox's
                      state changes
     */
    
    @IBAction func setLongDate(_ sender: NSButton)
    {
        if (sender.state == NSControl.StateValue.on)
        {
            settings.isLongDate = true
        }
        else
        {
            settings.isLongDate = false
        }
    }
    
}
