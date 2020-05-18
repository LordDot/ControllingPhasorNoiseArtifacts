layout (triangles) in;
layout (triangle_strip, max_vertices = 3) out;

in vec2 textureCoordinates[];

out vec2 texCoordinates;
out float shade;

void main(){
  vec3 lightDir = vec3(1.,0,0.);
  lightDir = lightDir / sqrt(dot(lightDir,lightDir));

  vec4 p0 = gl_in[0].gl_Position + vec4(0., sin(noise(textureCoordinates[0]+vec2(0.001,0.001))), 0.0, 0.0);
  vec4 p1 = gl_in[1].gl_Position + vec4(0., sin(noise(textureCoordinates[1]+vec2(0.001,0.001))), 0.0, 0.0);
  vec4 p2 = gl_in[2].gl_Position + vec4(0., sin(noise(textureCoordinates[2]+vec2(0.001,0.001))), 0.0, 0.0);
  vec3 v1 = (p0 - p1).xyz;
  vec3 v2 = (p2 - p1).xyz;
  vec3 normal = cross(v1,v2);
  normal = normal / sqrt(dot(normal,normal));
  float s = dot(normal, lightDir);
  

  for(int i = 0; i < 3; i++){
    gl_Position = gl_in[i].gl_Position + vec4(0., sin(noise(textureCoordinates[i]+vec2(0.001,0.001))), 0.0, 0.0);
    texCoordinates = textureCoordinates[i];
    shade = s;
    EmitVertex();
  }
  EndPrimitive();
}
