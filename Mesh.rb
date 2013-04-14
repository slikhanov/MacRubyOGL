# Class that manages data to be drawn.

class Mesh
    def initialize
      @vertex_data = Pointer.new(:float, 10)
      vbo_objects_array = Pointer.new_with_type("I", 1)
      glGenBuffers(1, vbo_objects_array)
      @vbo = vbo_objects_array.value
      glBindBuffer(GL_ARRAY_BUFFER, @vbo)
      glBufferData(GL_ARRAY_BUFFER, BYTES_IN_BUFFER, @vertex_data, GL_STATIC_DRAW)
    end

    def fill_vertex_data
    end

    def draw
      glBindBuffer(GL_ARRAY_BUFFER, @vbo)
      glEnableClientState(GL_VERTEX_ARRAY)
      glVertexPointer(3, GL_FLOAT, Pointer.magic_cookie(0))
      glColor3f(1.0, 0.0, 0.0)
      glDrawArrays(GL_QUADS, 0, 24)
    end
end
