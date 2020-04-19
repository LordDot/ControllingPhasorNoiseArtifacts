
        float PWM(float x, float r)
        {
          return mod(x,2.0*M_PI)> 2.0*M_PI *r ? 1.0 : 0.0; 
        }

        float square(float x)
        {
          return PWM(x,0.5);   
        }

        float sawTooth(float x)
        {
          return mod(x,2.0*M_PI)/(2.0*M_PI);
        }

        vec3 hsv2rgb(vec3 c)
        {
          vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
          vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
          return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
        }

        float gauss1d(float x, float sigma){
          return exp(-x*x/(sigma*sigma));
        }

        float gauss2d(vec2 x, float sigma){
          return exp(-dot(x,x)/(sigma*sigma));
        }

        float stairCase(vec2 x){
          float circle = atan(x.y,x.x);
          float gauss = exp(-dot(x,x)*20.);
          return  circle;
        }

        float dualSingularity(vec2 x, vec2 u, vec2 v){
          return baseThing(x, u, v, 0);
        }

        in vec2 textureCoordinates;

        void main(){
          vec2 uv = textureCoordinates;

          //vec2 M = iMouse.xy/iResolution.y;
          //M.y = 1.0-M.y;
          vec2 dir = vec2(cos(_o),sin(_o));


          float phi = 0.;
          phi += _f*dot(uv, dir)*(2.*M_PI);
          phi += evalHirarchNoise(uv) * 2.*M_PI * 3. + 0.35;
          //phi += stairCase(uv-M);
          phi += 0.2*baseThing(uv,vec2(0.25,0.5),vec2(0.75,0.5), 0);
          phi += 0.5*baseThing(uv,vec2(0.3,0.25),vec2(0.5,0.75), 1);

          vec3 phasorfield  = true 
            ? vec3(sin(phi)*0.3 +0.5)                              //figure3 a
            : hsv2rgb(vec3(phi/(2.*M_PI), .8, .8)); //figure3 b
          //phasorfield  = vec3(mod(phi/(2.0*M_PI)-_f*dot(uv,dir),1.0));//figure3 c
          //phasorfield = vec3(I);

          vec4 fragColor;
          fragColor = vec4(phasorfield,1.0);
          //fragColor = vec4(vec3(baseThing(uv,vec2(0.25, 0.5),vec2(0.75,0.5)))/(2.*M_PI) +0.5,1.0);
          gl_FragColor = fragColor;
        }
