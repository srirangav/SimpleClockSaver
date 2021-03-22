/*
    SimpleClock.saver - Settings.swift
 
    History:

    v. 1.0.0 (03/22/2021) - Initial version

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

class Settings
{

    /* get the user's settings */
    
    let defaults = Settings.screenSaverDefaults()
    
    /*
        methods to get and set the variable holding the user's preference
        for whether the date should be display in long format; when the
        variable is set, we synchronize the setting so that it is saved
        for future use
     */
    
    var isLongDate: Bool
    {

        get {
          return defaults.bool(forKey: "isLongDate")
        }
        
        set(value)
        {
          defaults.set(value, forKey: "isLongDate")
          defaults.synchronize()
        }
        
    }
    
    /* register - register our settings */
    
    func register()
    {
      let values: [String: Any] = [
        "isLongDate" : false,
      ]
      defaults.register(defaults: values)
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

    /* screenSaverDefaults - create our defaults */
    
    private static func screenSaverDefaults() -> ScreenSaverDefaults
    {
        guard let bundleId = Bundle(for: Settings.self).bundleIdentifier
        else
        {
            fatalError("Couldn't find a bundle identifier")
        }

        guard let defaults = ScreenSaverDefaults(forModuleWithName: bundleId)
        else
        {
            fatalError("Couldn't create ScreenSaverDefaults instance")
        }

        return defaults
    }
}
