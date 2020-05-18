
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

        float stairCase(vec2 x, vec2 s){
          vec2 p = x - s;
          float circle = atan(p.y,p.x);
          return  circle;
        }

        float dualSingularity(vec2 x, vec2 u, vec2 v){
          return baseThing(x, u, v, 0);
        }


        float noise(vec2 uv){

          vec2 dir = vec2(cos(_o),sin(_o));

          float phi = 0.;
          phi += 50*dot(uv, dir)*(2.*M_PI);
          //phi += 200*dot(uv-0.5, uv-0.5);
          phi +=20.*evalHirarchNoise(uv*3.5);
          {ARTIFACTS}


          return phi;
          
        }
