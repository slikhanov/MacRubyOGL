# Class that manages data to be drawn.

class Mesh
    def initialize(program)
      fill_vertex_data
      @vao = create_vertex_array_object
      enable_vertex_array_object

      vbo_objects_array = Pointer.new_with_type("I", 1)
      glGenBuffers(1, vbo_objects_array)
      puts glGetError
      @vbo = vbo_objects_array.value
      puts @vbo
      puts glIsBuffer(@vbo)
      glBindBuffer(GL_ARRAY_BUFFER, @vbo)
      puts glIsBuffer(@vbo)
      puts "After IsBuffer"
      puts glGetError
      puts  @vertex_data[5]
      glBufferData(GL_ARRAY_BUFFER, 8 * 4, @vertex_data, GL_STATIC_DRAW)

      glEnableVertexAttribArray(program.position)
      puts glGetError
      glVertexAttribPointer(program.position, 2, GL_FLOAT, GL_FALSE, 0, Pointer.magic_cookie(0))
      puts glGetError

      disable_vertex_array_object
    end

    def create_vertex_array_object
      vao_objects_array = Pointer.new_with_type("I", 1)
      glGenVertexArrays(1, vao_objects_array)
      puts glGetError
      return vao_objects_array.value
    end

    def enable_vertex_array_object
      puts "VAO:"
      puts @vao
      glBindVertexArray(@vao)
    end

    def disable_vertex_array_object
      glBindVertexArray(0)
    end

    def fill_vertex_data
      vertices = [
        -0.3, -0.2,
        0.0, 0.0,
        0.1, 0.1,
        0.2, 0.4
      ];
      @vertex_data = Pointer.new(:float, vertices.count)
      (0..vertices.count - 1).each do |idx|
        @vertex_data[idx] = vertices[idx]
      end
    end

    def draw
      enable_vertex_array_object
      #glBindBuffer(GL_ARRAY_BUFFER, @vbo)
      #puts glGetError
      #glColor4f(1.0, 0.85, 0.35, 1.0)
      glDrawArrays(GL_TRIANGLE_FAN, 0, 4)
      puts glGetError
      disable_vertex_array_object
      puts glGetError
    end
end
