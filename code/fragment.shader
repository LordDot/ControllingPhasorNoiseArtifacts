
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

        float stairCase(vec2 x, vec2 s){
          vec2 p = x - s;
          float circle = atan(p.y,p.x);
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
          //float _o = sqrt(dot(uv,uv));
          //float _o = uv.x*2.0;
          vec2 dir = vec2(cos(_o),sin(_o));
          //float _f = uv.x*20;


          float phi = 0.;
          //phi += _f*dot(uv, dir)*(2.*M_PI);
          //phi += 15.0* evalHirarchNoise(uv);
          vec2 s = vec2(0.25,0.6);
          vec2 t = vec2(0.75,0.4);
          float temp;
          vec2 st = t-s;
          float angle = atan(st.y, st.x);
          float ds = dot(uv-s,uv-s);
          float dt = dot(uv-t,uv-t);
          if(ds < dt){
            temp = (atan(uv.y-s.y,uv.x-s.x)) - angle;
          }else{
            temp = M_PI-(atan(uv.y-t.y,uv.x-t.x)) + angle;
          }
          float gauss;
          if(uv.x < 0.25){
            gauss = gauss2d(uv - vec2(0.25,0.5), 0.2);
          }else if(uv.x < 0.75){
            gauss = gauss1d(uv.y -0.5, 0.2);
          }else{
            gauss = gauss2d(uv - vec2(0.75,0.5), 0.2);
          }
          phi += (mod(temp,2.*M_PI)-M_PI);

          vec3 phasorfield  = true
            ? vec3(sin(phi)*0.5 +0.5)                              //figure3 a
            : hsv2rgb(vec3(phi/(2.*M_PI), .8, .8)); //figure3 b
          //phasorfield  = vec3(mod(phi/(2.0*M_PI)-_f*dot(uv,dir),1.0));//figure3 c
          //phasorfield = vec3(I);

          vec4 fragColor;
          fragColor = vec4(phasorfield,1.0);
          //fragColor = vec4(dir, 0.0, 1.0);
          //fragColor = vec4(vec3(baseThing(uv,vec2(0.25, 0.5),vec2(0.75,0.5)))/(2.*M_PI) +0.5,1.0);
          //gl_FragColor = fragColor;
          gl_FragColor = vec4(hsv2rgb(vec3(phi/(2*M_PI),1.,1.)),1.0);
        }
