#!/usr/bin/macruby

framework 'Cocoa'

app = NSApplication.sharedApplication

window_frame = [0.0, 0.0, 800.0, 600.0]
mask = NSTitledWindowMask | NSClosableWindowMask

main_window = NSWindow.alloc.initWithContentRect window_frame,
        styleMask: mask,
        backing: NSBackingStoreBuffered,
        defer: false

main_window.display
main_window.makeKeyAndOrderFront nil
main_window.orderFrontRegardless
puts "Before run"
app.run

