
          out vec2 textureCoordinates;
          out vec3 color;

        void main()
        { 
          
          textureCoordinates = gl_MultiTexCoord0.xy;
          gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;

          vec2 uv = textureCoordinates;
          float phi = 0;
          phi += 3*abs(atan(gl_Normal.y, gl_Normal.x));
          phi += 1.*(evalHirarchNoise(3*uv)-1);
          {ARTIFACTS}
          
          color = vec3(0.5+0.5*cos(phi));
        }

