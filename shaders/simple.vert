// minimal.vert
#version 150 core

in vec3 in_Position;
out vec3 ex_Color;

uniform mat4 modelMatrix;
uniform mat4 viewMatrix; 
uniform mat4 projMatrix;

void main(void)
{
      gl_Position = projMatrix * viewMatrix * modelMatrix * vec4(in_Position, 1.0);
      ex_Color = vec3(0.5f, 0.5f, 0.3f);
}
