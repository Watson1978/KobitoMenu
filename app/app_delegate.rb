class ContentView < NSView
  attr_reader :save, :text

  def initWithFrame(frame)
    super

    scroll = NSScrollView.alloc.initWithFrame([[10, 52], [460, 258]])
    scroll.setAutoresizingMask(NSViewWidthSizable|NSViewHeightSizable)
    scroll.setHasVerticalScroller(true)
    scroll.setHasHorizontalScroller(false)
    scroll.setBorderType(NSBezelBorder)

    @text = NSTextView.alloc.initWithFrame([[10, 52], [460, 258]])
    @text.setFont(NSFont.fontWithName("Osaka-Mono", size:14))
    scroll.setDocumentView(@text)
    addSubview(scroll)

    @save = NSButton.alloc.initWithFrame([[375, 10], [100, 32]])
    @save.setTitle("Save")
    @save.setBezelStyle(NSRoundedBezelStyle)
    addSubview(@save)

    self
  end
end

class ContentViewController < NSViewController
  attr_accessor :statusItemPopup

  def initWithNibName(nibNameOrNil, bundle:nibBundleOrNil)
    super

    self.view = ContentView.alloc.initWithFrame([[0, 0], [480, 320]])
    self.view.save.action = "save"
    self.view.save.target = self

    self
  end

  def save
    path = "/tmp/kobito#{Time.now.to_i}.md"
    data = self.view.text.string
    File.open(path, "w") { |io| io.print data }
    system "open -a Kobito '#{path}'"

    self.view.text.string = ""
    statusItemPopup.hidePopover
  end
end

class NSWindow
  def canBecomeKeyWindow
    # NSPopover 上の NSTextField/NSTextView でテキスト編集するために必要なコード 
    # http://stackoverflow.com/questions/7214273/nstextfield-on-nspopover
    true
  end
end

class AppDelegate
  def applicationDidFinishLaunching(notification)
    image = NSImage.imageNamed("icon")
    image.size = [16, 16]
    @controller = ContentViewController.alloc.initWithNibName(nil, bundle:nil)
    @controller.statusItemPopup = AXStatusItemPopup.alloc.initWithViewController(@controller, image:image)
  end
end
