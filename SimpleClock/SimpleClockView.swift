/*
    SimpleClock.saver - SimpleClockView.swift
 
    History:

    v. 1.0.0 (03/22/2021) - Initial version

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

class SimpleClockView: ScreenSaverView
{
    
    /* private variable to hold our settings */
    
    private let settings = Settings()

    /* private text field for the date */
    
    private var dateLabel: NSTextField!

    /* private date formatter for formatting the date */
    
    private var dateFormatter = DateFormatter()

    /* private text field for the time */
    
    private var timeLabel: NSTextField!
        
    /* private stacked view to hold the date and time text fields */
    
    private let stackedView: NSStackView = {
        let view = NSStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.orientation = .vertical
        return view
    }()
    
    /* private variable to hold the default font size = 120 pt */
    
    private var displayFontSize: CGFloat = 120.0
    
    /* private variable to hold the default refresh time = 5 secs */
    
    private var refreshRate: TimeInterval = 5.0
        
    /* make the background black */
    
    public var backgroundColor = NSColor.black
    
    /* display the date and time in white */
    
    public var textColor = NSColor.white

    /* initialization functions */
    
    convenience init()
    {
        self.init(frame: .zero, isPreview: false)
    }
    
    override init!(frame: NSRect, isPreview: Bool)
    {
        super.init(frame: frame, isPreview: isPreview)
        initialize()
    }
    
    required public init?(coder: NSCoder)
    {
        super.init(coder: coder)
        initialize()
    }
    
    private func initialize()
    {
        /* set the animationTimeInterval equal to our refresh rate */
        
        self.animationTimeInterval = refreshRate
        
        /*
            if the user has specified a long date, then configure the
            date formatter accordingly
         */
        
        if (settings.isLongDate)
        {
            dateFormatter.dateStyle = .full

        }
        else
        {
            dateFormatter.dateStyle = .long
        }
        
        /* disable display of the time */
        
        dateFormatter.timeStyle = .none
        
        /* make the text field that will hold the time */
        
        timeLabel = makeLabel(isPreview,
                              bounds: frame,
                              fontSize: displayFontSize)
        
        /*
            make the text field that will hold the date, at half the font
            size of the time
         */
        
        dateLabel = makeLabel(isPreview,
                              bounds: frame,
                              fontSize: displayFontSize / 2)

        /*
            disable autoresizingmask in the stacked view so we can set
            constraints manually
         */
        
        stackedView.translatesAutoresizingMaskIntoConstraints = false
        
        /* specify that items are stacked vertically in the stacked view */
        
        stackedView.orientation = .vertical
        
        /* stack the time label on top of the date label */
        
        stackedView.addArrangedSubview(timeLabel)
        stackedView.addArrangedSubview(dateLabel)
        
        /*
            center the date and time on the horizontal (x) access and
            position the date and time about 1/6 of the way down from
            the top of the screen; see:
         
            https://stackoverflow.com/questions/26180822/how-to-add-constraints-programmatically-using-swift
         
         */
        
        addConstraints(
            [
                stackedView.centerXAnchor.constraint(equalTo: centerXAnchor),
                stackedView.topAnchor.constraint(equalTo:  topAnchor,
                                                 constant: frame.height/6)
            ]
        )
        
        /* add the stacked view to the parent / main view */
        
        addSubview(stackedView)
    }
     
    override func draw(_ rect: NSRect)
    {

        /* fill the screen with our background color */
        
        backgroundColor.setFill()
        rect.fill()
    }

    /* animateOneFrame - draw one frame of the screensaver */
    
    override func animateOneFrame()
    {
        super.animateOneFrame()

        /* get the current date and time */
        
        let now = Date()
        let calendar = Calendar.current

        /* format the date using the date format specified by the user */
        
        dateLabel.stringValue = dateFormatter.string(from: now)
        
        /* get the hour and minutes from the current calendar */
        
        timeLabel.stringValue = String(format: "%02d:%02d",
                                       calendar.component(.hour, from: now),
                                       calendar.component(.minute, from: now))
        
        /* ask for the display to be updated */
        
        needsDisplay = true
    }
    
    /* makeLabel - formats a text field */
    
    private func makeLabel(_ isPreview: Bool,
                           bounds: CGRect,
                           fontSize: CGFloat) -> NSTextField
    {
        let label = NSTextField(frame: bounds)
        label.autoresizingMask = NSView.AutoresizingMask.width
        label.alignment = .center
        label.textColor = .white
        label.font = NSFont.systemFont(ofSize: fontSize)
        label.backgroundColor = .clear
        label.isEditable = false
        label.isBezeled = false
        return label
    }
    
    /* configuration */
    
    override public var hasConfigureSheet: Bool
    {
        return true
    }
    
    override public var configureSheet: NSWindow?
    {
        let configurationSheet = ConfigurationSheet.sharedInstance
        return configurationSheet.window
    }
}
