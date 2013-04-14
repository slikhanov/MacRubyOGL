#
#  OpenGLView.rb
#  OpenGL
#
#  Created by Serhiy Likhanov on 12/16/12.
#  Copyright 2012 Serhiy Likhanov. All rights reserved.
#

require 'ShaderProgram'
require 'Mesh'

class OpenGLView < NSOpenGLView

    @@color = 0.001
   
    def prepareOpenGL
        puts glGetString GL_VERSION
        puts glGetString GL_SHADING_LANGUAGE_VERSION
        program = ShaderProgram.new "simple"
        program.use
    end

    def reshape
        rect = bounds
        glViewport(0, 0, NSWidth(rect), NSHeight(rect))
    end

    def drawRect(rect)
        @@color += 0.001
        glClearColor(0, @@color, 0, 1)
        glClear(GL_COLOR_BUFFER_BIT)
        
        drawAnObject
        
        openGLContext.flushBuffer
    end
    
    def drawAnObject
        mesh = Mesh.new

        glColor3f(1.0, 0.85, 0.35)
        glBegin(GL_TRIANGLES)

        glVertex3f(  0.0,  0.6, 0.0)
        glVertex3f( -0.2, -0.3, 0.0)
        glVertex3f(  0.2, -0.3 ,0.0)
        glEnd()
    end
end
