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

# Identifying pixel format
attributes_source = [
    #NSOpenGLPFAOpenGLProfile, NSOpenGLProfileVersion3_2Core, 
    NSOpenGLPFAColorSize, 24,
    NSOpenGLPFAAlphaSize, 8,
    NSOpenGLPFAAccelerated,
    NSOpenGLPFADoubleBuffer,
    0 ]

attributes = Pointer.new_with_type(:uint, attributes_source.size)
(0..attributes_source.size - 1).each do |i|
    attributes[i] = attributes_source[i]
end

pixel_format = NSOpenGLPixelFormat.alloc.initWithAttributes attributes

gl_view = OpenGLView.alloc.initWithFrame window_frame, pixelFormat: pixel_format
content_view.addSubview gl_view

main_window.display
main_window.makeKeyAndOrderFront nil
main_window.orderFrontRegardless
app.run

