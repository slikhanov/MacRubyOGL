# Class that manages data to be drawn.

class Mesh
    def initialize
      fill_vertex_data
      vbo_objects_array = Pointer.new_with_type("I", 1)
      glGenBuffers(1, vbo_objects_array)
      @vbo = vbo_objects_array.value
      glBindBuffer(GL_ARRAY_BUFFER, @vbo)
      glBufferData(GL_ARRAY_BUFFER, 9 * 4, @vertex_data, GL_STATIC_DRAW)
    end

    def fill_vertex_data
      vertices = [
        0.0, 0.6, 0.0,
        -0.2, -0.3, 0.0,
        0.2, -0.3 ,0.0
      ];
      @vertex_data = Pointer.new(:float, vertices.count)
      (0..vertices.count - 1).each do |idx|
        @vertex_data[idx] = vertices[idx]
      end
    end

    def draw
      glBindBuffer(GL_ARRAY_BUFFER, @vbo)
      glEnableClientState(GL_VERTEX_ARRAY)
      glVertexPointer(3, GL_FLOAT, 3 * 4, Pointer.magic_cookie(0))
      glColor3f(1.0, 0.85, 0.35)
      glDrawArrays(GL_TRIANGLE_STRIP, 0, 1)
    end
end
