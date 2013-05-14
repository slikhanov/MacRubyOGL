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

        viewMatrix = MatrixBuffer.new(Matrix.scale_comp(1.0, 1.0, 1.0))
    end

    def reshape
        rect = bounds
        glViewport(0, 0, NSWidth(rect), NSHeight(rect))
    end

    def drawRect(rect)
        openGLContext.makeCurrentContext
        @color += 0.001
        glClearColor(0, @color, 0, 1)
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)
        
        drawAnObject
        
        openGLContext.flushBuffer
    end
    
    def drawAnObject
        @program.use
        @mesh.draw
    end
end
