// minimal.vert
#version 150 core

in vec2 in_Position;
out vec3 ex_Color;

void main(void)
{
      gl_Position = vec4(in_Position.x, in_Position.y, 0.0, 1.0);
      ex_Color = vec3(0.5f, 0.5f, 0.3f);
}
