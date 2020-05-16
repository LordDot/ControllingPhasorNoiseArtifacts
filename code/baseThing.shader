float baseThing(vec2 x, vec2 s, vec2 t, int mehtod){
  vec2 nearestPoint = vec2(0);
  float dist = 0.;
  vec2 sTangent = vec2(0);
  vec2 tTangent = vec2(0);

  baseThingConfig conf;
  if(mehtod == 0){
    conf = straight(x,s,t);
  }else if(mehtod==1){
    conf = angle(x,s,t);
  }
  nearestPoint = conf.nearestPoint;
  dist = conf.dist;
  sTangent = conf.sTangent;
  tTangent = conf.tTangent;


  if(nearestPoint == s){
    vec2 tang = -sTangent;
    vec2 toX = x - s;
    //return sqrt(dot(toS,toS));
    vec2 toXN = toX / sqrt(dot(toX,toX));
    float adjacent =  dot(toXN, tang);
    vec2 normal = vec2(tang.y,-tang.x);
    float opposite = dot(toXN,normal);

    return atan(opposite, adjacent) * gauss2d(x-s,0.15);
  } else if(nearestPoint == t){
    vec2 tang = -tTangent;
    vec2 toX = x - t;
    //return sqrt(dot(toS,toS));
    vec2 toXN = toX / sqrt(dot(toX,toX));
    float adjacent =  dot(toXN, tang);
    vec2 normal = vec2(-tang.y,tang.x);
    float opposite = dot(toXN,normal);
    return atan(opposite, adjacent) * gauss2d(x-t,0.15);
  } else {
    //return dist < 0. ? 0. : M_PI;


    vec2 ns = s - nearestPoint;
    vec2 nt = t - nearestPoint;
    float dns = sqrt(dot(ns,ns));
    float dnt = sqrt(dot(nt,nt));

    float gauss = gauss1d(dist, 0.15);

    if(dns < dnt){
      return atan(dist,-dns) * gauss;
    }else{
      return atan(dist,-dnt) * gauss;
    }
  }

}
