class Shader

    def self.compile_shader
        program = glCreateProgram
        shader_source = "test shadereudheufheufhrufhi"
        shader_length = Pointer.new_with_type :int
        shader_length.assign shader_source.length
        shader_source_ptr = Pointer.new('*')
        shader_source_ptr.assign shader_source.pointer
        shader = glCreateShader GL_VERTEX_SHADER
        glShaderSource shader, 1, shader_source_ptr, shader_length
        glCompileShader shader
        get_compile_status shader
        glAttachShader program, shader
        #glValidateProgram prog

        glLinkProgram program
        #log_len = Pointer.new_with_type :int
    end

    def self.get_compile_status shader
        length_ptr = Pointer.new_with_type :int
        glGetShaderiv shader, GL_INFO_LOG_LENGTH, length_ptr
        puts length_ptr, length_ptr.value
        if (length_ptr.value > 0)
            log = Pointer.new_with_type('c', length_ptr.value)
            glGetShaderInfoLog(shader, length_ptr.value, length_ptr, log)
            puts "Error"
            puts NSString.stringWithCString log, encoding: NSASCIIStringEncoding
        else
            puts "No error"
        end

    end
end
