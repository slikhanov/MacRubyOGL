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
        @color += 0.001
        @rotation_angle += 0.1
        glClearColor(0, @color, 0, 1)
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
       
        recalc_matrices 
        drawAnObject
        
        openGLContext.flushBuffer
    end
    
    def drawAnObject
        @program.use
        glUniformMatrix4fv(@program.get_uniform_location("mvpMatrix"), 1, GL_FALSE, @mvp_matrix_buffer.data);
        @mesh.draw
    end

    def animation_timer(timer)
      setNeedsDisplay(true)
    end

    def recalc_matrices
        @model_matrix = Matrix.rotate(0.0, 1.0, 0.0, @rotation_angle) * Matrix.scale(0.2, 0.2, 0.2)
        @view_matrix = Matrix.translate(0.0, 0.0, -500.0)
        @projection_matrix = Matrix.perspective(
            90.0, aspect_ratio, 0.001, 100.0)
        @mvp_matrix_buffer = MatrixBuffer.new(
              @projection_matrix * @view_matrix * @model_matrix)
    end

end
