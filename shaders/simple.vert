// minimal.vert
#version 150 core

precision highp float;

in vec3 in_Position;
in vec3 in_Color;
out vec3 ex_Color;

uniform mat4 modelMatrix;
uniform mat4 viewMatrix; 
uniform mat4 projMatrix;

void main(void)
{
      gl_Position = projMatrix * viewMatrix * modelMatrix * vec4(in_Position, 1.0);
      ex_Color = in_Color;
}
