/*
    SimpleClock.saver - ConfigurationSheet.swift

    History:

    v. 1.0.0 (03/22/2021) - Initial version
    v. 1.0.1 (04/22/2021) - Add support for stardates
    v. 1.0.2 (04/02/2021) - Add support for timezones
    v. 1.0.3 (05/16/2021) - Add preference for display on main screen only
    v. 1.0.4 (05/20/2021) - Add support for TOS style stardates

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
    
    /* checkboxes for our settings */

    @IBOutlet weak var longDateCheck: NSButton!
    @IBOutlet weak var starDateCheck: NSButton!
    @IBOutlet weak var TOSStarDateCheck: NSButton!
    @IBOutlet weak var timeZoneCheck: NSButton!
    @IBOutlet weak var mainScreenCheck: NSButton!
    
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
        starDateCheck.state = settings.starDateStateForCheckBox()
        TOSStarDateCheck.state = settings.starDateStateForCheckBox()
        timeZoneCheck.state = settings.timeZoneStateForCheckBox()
        mainScreenCheck.state = settings.mainScreenStateForCheckBox()
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
                      state changes for long date display
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
    
    /*
        setStarDate - change the user's preferences when the checkbox's
                      state changes for stardate display
     */
    
    @IBAction func setStarDate(_ sender: NSButton)
    {
        if (sender.state == NSControl.StateValue.on)
        {
            settings.isStarDate = true
            TOSStarDateCheck.isEnabled = true;
        }
        else
        {
            settings.isStarDate = false
            TOSStarDateCheck.isEnabled = false;
        }
    }

    /*
        setTOSStarDate - change the user's preferences when the checkbox's
                         state changes for TOS stardate display
     */
    
    @IBAction func setTOSStarDate(_ sender: NSButton)
    {
        if (sender.state == NSControl.StateValue.on)
        {
            settings.isTOSStarDate = true
        }
        else
        {
            settings.isTOSStarDate = false
        }
    }

    /*
        setTimeZone - change the user's preferences when the checkbox's
                      state changes for timezone display
     */
    
    @IBAction func setTimeZone(_ sender: NSButton)
    {
        if (sender.state == NSControl.StateValue.on)
        {
            settings.isTimeZone = true
        }
        else
        {
            settings.isTimeZone = false
        }
    }

    /*
        setAllScreens - change the user's preferences when the checkbox's
                        state changes for all screens
     */
    
    @IBAction func setMainScreen(_ sender: NSButton)
    {
        if (sender.state == NSControl.StateValue.on)
        {
            settings.isMainScreen = true
        }
        else
        {
            settings.isMainScreen = false
        }
    }
    
}
