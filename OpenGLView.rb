#
#  OpenGLView.rb
#  OpenGL
#
#  Created by Serhiy Likhanov on 12/16/12.
#  Copyright 2012 Serhiy Likhanov. All rights reserved.
#

require 'ShaderProgram'
require 'Mesh'
require 'MatrixBuffer'

class OpenGLView < NSOpenGLView

    def prepareOpenGL
        puts glGetString GL_VERSION
        puts glGetString GL_SHADING_LANGUAGE_VERSION
        @program = ShaderProgram.new "simple"
        @mesh = Mesh.new(@program)
        @color = 0.2
        @rotation_angle = 0.0

        # Starting the timer :
        @timer = NSTimer.timerWithTimeInterval(1.0/30.0, target:self, selector:"animation_timer:", userInfo:nil, repeats:true)
        NSRunLoop.currentRunLoop.addTimer(@timer, forMode:NSDefaultRunLoopMode)
        NSRunLoop.currentRunLoop.addTimer(@timer, forMode:NSEventTrackingRunLoopMode)
    end

    def aspect_ratio
      rect = bounds
      NSWidth(rect) / NSHeight(rect)
    end

    def reshape
        rect = bounds
        glViewport(0, 0, NSWidth(rect), NSHeight(rect))
    end

    def drawRect(rect)
        openGLContext.makeCurrentContext
        @rotation_angle += 0.01
        glClearColor(0, @color, 0, 1)
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
       
        recalc_matrices 
        drawAnObject
        
        openGLContext.flushBuffer
    end
    
    def drawAnObject
        @program.use
        glUniformMatrix4fv(@program.get_uniform_location("modelMatrix"), 1, GL_FALSE, @model_matrix.data);
        glUniformMatrix4fv(@program.get_uniform_location("viewMatrix"), 1, GL_FALSE, @view_matrix.data);
        glUniformMatrix4fv(@program.get_uniform_location("projMatrix"), 1, GL_FALSE, @projection_matrix.data);
        @mesh.draw
    end

    def animation_timer(timer)
      setNeedsDisplay(true)
    end

    def recalc_matrices
        @model_matrix = MatrixBuffer.new(Matrix.rotate(1.0, 0.0, 0.0, @rotation_angle))
        @view_matrix = MatrixBuffer.new(Matrix.translate(0.0, 0.0, -10.0))
        @projection_matrix = MatrixBuffer.new(Matrix.perspective(
            90.0, aspect_ratio, 0.1, 100.0))
    end

end
