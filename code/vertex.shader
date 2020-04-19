
          out vec2 textureCoordinates;

        void main()
        { 
          textureCoordinates = gl_MultiTexCoord0.xy;
          gl_Position = gl_ModelViewProjectionMatrix * gl_Vertex;
        }

