#!/usr/bin/macruby

framework 'Cocoa'

require 'OpenGLView'

app = NSApplication.sharedApplication

window_frame = [0.0, 0.0, 800.0, 600.0]
mask = NSTitledWindowMask | NSClosableWindowMask

main_window = NSWindow.alloc.initWithContentRect window_frame,
        styleMask: mask,
        backing: NSBackingStoreBuffered,
        defer: false

content_view = NSView.alloc.initWithFrame window_frame
main_window.contentView = content_view

gl_view = OpenGLView.alloc.initWithFrame window_frame
content_view.addSubview gl_view

main_window.display
main_window.makeKeyAndOrderFront nil
main_window.orderFrontRegardless
app.run

