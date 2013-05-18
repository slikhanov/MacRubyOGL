require 'Shader'

class ShaderProgram
    def initialize material_name
        @program = glCreateProgram
        vertex_shader = Shader.new GL_VERTEX_SHADER, File.open("shaders/" + material_name + ".vert", 'rb') { |file| file.read }
        glAttachShader(@program, vertex_shader.shader)
        fragment_shader = Shader.new GL_FRAGMENT_SHADER, File.open("shaders/" + material_name + ".frag", 'rb') { |file| file.read }
        glAttachShader(@program, fragment_shader.shader)

        glBindAttribLocation(@program, 0, "in_Position")
        puts glGetError
        glLinkProgram(@program)
        @position_attribute_location = 0 
    end

    def use
        glUseProgram(@program)
    end

    def position
        @position_attribute_location
    end

    def get_uniform_location(uniform_name)
      glGetUniformLocation(@program, uniform_name)
    end
end
