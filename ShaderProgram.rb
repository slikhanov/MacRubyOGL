require 'Shader'

class ShaderProgram
    def initialize material_name
        @program = glCreateProgram
        vertex_shader = Shader.new GL_VERTEX_SHADER, File.open("shaders/" + material_name + ".vert", 'rb') { |file| file.read }
        glAttachShader(@program, vertex_shader.shader)
        fragment_shader = Shader.new GL_FRAGMENT_SHADER, File.open("shaders/" + material_name + ".frag", 'rb') { |file| file.read }
        glAttachShader(@program, fragment_shader.shader)
        glLinkProgram(@program)
    end

    def use
        glUseProgram(@program)
    end
end
