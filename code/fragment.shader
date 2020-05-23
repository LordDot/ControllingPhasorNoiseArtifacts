in vec2 textureCoordinates;
//in float shade;
uniform sampler2D _MainTex;

void main(){
  vec2 uv = textureCoordinates;
  float phi = noise(uv);

  vec4 n = vec4(vec3(PWM(phi,0.1)),1.);
  vec4 tex = texture(_MainTex,uv);
  gl_FragColor = tex*(0.3+0.7*n);
  //gl_FragColor = vec4(1.,0.,0.,1.);
  //gl_FragColor = vec4(vec3(0.95*max(0,shade)+0.05),1.0);
}
