require 'Utils'

# Class that manages Vertex Array Objects
class VertexArrayObject
  def initialize
    vao_objects_array = Pointer.new_with_type("I", 1)
    glGenVertexArrays(1, vao_objects_array)
    @vao = vao_objects_array.value
  end

  def enable
    glBindVertexArray(@vao)
  end

  def disable
    glBindVertexArray(0)
  end
end

# Class for preparing buffer data
class BufferData
  attr_reader :data
  attr_reader :count
  attr_reader :components

  def initialize(buffer_data, components)
    @components = components
    @count = buffer_data.count
    @data = Pointer.new(:float, buffer_data.count)
    (0..buffer_data.count - 1).each do |idx|
      @data[idx] = buffer_data[idx]
    end
  end

  def size
    sizeof(:float) * count
  end
end

# Class that manages Vertex Buffer Objects
class VertexBufferObject
  def initialize(buffer_data, attribute_index)
    vbo_objects_array = Pointer.new_with_type("I", 1)
    glGenBuffers(1, vbo_objects_array)
    @vbo = vbo_objects_array.value
    update(buffer_data, attribute_index)
  end

  def update(buffer_data, attribute_index)
    glBindBuffer(GL_ARRAY_BUFFER, @vbo)
    glBufferData(GL_ARRAY_BUFFER, buffer_data.size, buffer_data.data, GL_STATIC_DRAW)
    glEnableVertexAttribArray(attribute_index)
    glVertexAttribPointer(attribute_index, buffer_data.components, GL_FLOAT, GL_FALSE, 0, Pointer.magic_cookie(0))
  end
end

# Class that manages data to be drawn.
class Mesh
    def initialize(program)
      @vao = VertexArrayObject.new
      @vao.enable

      @data = BufferData.new([
        -0.3, -0.2,
        0.0, 0.0,
        0.1, 0.1,
        0.2, 0.4,
        -0.3, 0.4
      ], 2)
      vbo = VertexBufferObject.new(@data, 0)
      @vao.disable
    end

    def draw
      @vao.enable
      glDrawArrays(GL_TRIANGLE_STRIP, 0, 5)
      @vao.disable
    end
end
