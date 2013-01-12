class Shader

    def self.compile_shader
        prog = 1
        shader_source = "test shader"
        shader_length = Pointer.new_with_type :int
        shader_length.assign shader_source.length
        shader_source_ptr = Pointer.new('*')
        shader_source_ptr.assign shader_source.pointer
        shader = glCreateShader GL_VERTEX_SHADER
        glShaderSource shader, 1, shader_source_ptr, shader_length
        glCompileShader shader
        #glAttachShader prog, shader
        #glValidateProgram prog

        #log_len = Pointer.new_with_type :int
    end
end
