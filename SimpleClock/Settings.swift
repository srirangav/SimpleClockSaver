/*
    SimpleClock.saver - Settings.swift
 
    History:

    v. 1.0.0 (03/22/2021) - Initial version
    v. 1.0.1 (04/22/2021) - Add support for stardates
    v. 1.0.2 (04/02/2021) - Add support for timezones
    v. 1.0.3 (05/15/2021) - Add preference for display on main screen only

    Based on: https://github.com/edwardloveall/ColorClockSaver/blob/master/ColorClockSaver/Settings.swift

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

import ScreenSaver

private let gStrIsLongDate    = "isLongDate"
private let gStrIsStarDate    = "isStarDate"
private let gStrIsTimeZone    = "isTimeZone"
private let gStrIsMainScreen  = "isMainScreen"
private let gStrErrNoBundleId = "Couldn't find a bundle identifier"
private let gStrErrNDefaults  =
    "Couldn't create ScreenSaverDefaults instance"

class Settings
{
    /* get the user's settings */
    
    let defaults = Settings.screenSaverDefaults()

    /* register - register the initial values for our settings */
    
    func register()
    {
        let values: [String: Any] = [
            gStrIsLongDate : false,
            gStrIsStarDate : false,
            gStrIsTimeZone : false,
            gStrIsMainScreen : false,
        ]
        defaults.register(defaults: values)
    }

    /* screenSaverDefaults - create our defaults */
    
    private static func screenSaverDefaults() -> ScreenSaverDefaults
    {
        guard let bundleId = Bundle(for: Settings.self).bundleIdentifier
        else
        {
            fatalError(gStrErrNoBundleId)
        }

        guard let defaults = ScreenSaverDefaults(forModuleWithName: bundleId)
        else
        {
            fatalError(gStrErrNDefaults)
        }

        return defaults
    }

    /*
        methods to get and set the variable holding the user's preference
        for whether the date should be display in long format; when the
        variable is set, we synchronize the setting so that it is saved
        for future use
     */
    
    var isLongDate: Bool
    {
        get {
            return defaults.bool(forKey: gStrIsLongDate)
        }
        
        set(value)
        {
            defaults.set(value, forKey: gStrIsLongDate)
            defaults.synchronize()
        }
    }

    /*
        longDateStateForCheckBox - return the state that the checkbox
        holding the user's setting for the long date display should have
     */
    
    func longDateStateForCheckBox() -> NSControl.StateValue
    {
        if isLongDate
        {
            return NSControl.StateValue.on
        }
        return NSControl.StateValue.off
    }

    /*
        methods to get and set the variable holding the user's preference
        for whether the stardate should be displayed; when the variable
        is set, we synchronize the setting so that it is saved for future use
     */
    
    var isStarDate: Bool
    {
        get {
            return defaults.bool(forKey: gStrIsStarDate)
        }
        
        set(value)
        {
            defaults.set(value, forKey: gStrIsStarDate)
            defaults.synchronize()
        }
    }

    /*
        starDateStateForCheckBox - return the state that the checkbox
        holding the user's setting for the stardate display should have
     */
    
    func starDateStateForCheckBox() -> NSControl.StateValue
    {
        if isStarDate
        {
            return NSControl.StateValue.on
        }
        return NSControl.StateValue.off
    }

    /*
        methods to get and set the variable holding the user's preference
        for whether the timezone should be displayed; when the variable
        is set, we synchronize the setting so that it is saved for future use
     */
    
    var isTimeZone: Bool
    {
        get {
            return defaults.bool(forKey: gStrIsTimeZone)
        }
        
        set(value)
        {
            defaults.set(value, forKey: gStrIsTimeZone)
            defaults.synchronize()
        }
    }

    /*
        timeZoneStateForCheckBox - return the state that the checkbox
        holding the user's setting for the timezone display should have
     */
    
    func timeZoneStateForCheckBox() -> NSControl.StateValue
    {
        if isTimeZone
        {
            return NSControl.StateValue.on
        }
        return NSControl.StateValue.off
    }

    /*
        methods to get and set the variable holding the user's preference
        for whether the screen saver should only be displayed on the main
        screen; when the variable is set, we synchronize the setting so
        that it is saved for future use
     */
    
    var isMainScreen: Bool
    {
        get {
            return defaults.bool(forKey: gStrIsMainScreen)
        }
        
        set(value)
        {
            defaults.set(value, forKey: gStrIsMainScreen)
            defaults.synchronize()
        }
    }

    /*
        mainScreenStateForCheckBox - return the state that the checkbox
        holding the user's setting for the timezone display should have
     */
    
    func mainScreenStateForCheckBox() -> NSControl.StateValue
    {
        if isMainScreen
        {
            return NSControl.StateValue.on
        }
        return NSControl.StateValue.off
    }

}

