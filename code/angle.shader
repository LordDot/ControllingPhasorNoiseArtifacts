baseThingConfig angle(vec2 x, vec2 s, vec2 t){
  mat2 rotate45 = mat2(cos(M_PI/4.),sin(M_PI/4.),-sin(M_PI/4.),cos(M_PI/4.));


  vec2 st = t - s;
  vec2 stN = st / sqrt(dot(st,st));
  vec2 sTangent = rotate45*stN;
  vec2 tTangent = transpose(rotate45)*-stN;

  vec2 normal = vec2(-stN.y,stN.x);

  vec2 p = s + st*0.5+normal*0.5*sqrt(dot(st,st));


  vec2 normal1 = rotate45 * normal;

  float offset1 = dot(normal1, s);
  float dist1 = dot(normal1, x) - offset1;
  vec2 projectedPoint1 = x - normal1 * dist1;
  //float dist1 = 0.;

  vec2 normal2 = transpose(rotate45) * normal;

  float offset2 = dot(normal2, t);
  float dist2 = dot(normal2, x) - offset2;
  vec2 projectedPoint2 = x - normal2 * dist2;
  //float dist2 = 0.;

  float dist;
  vec2 nearestPoint;
  if(dist1 > dist2){
    dist = dist1;
    nearestPoint = projectedPoint1;

    float sOffset = dot(sTangent,s);
    if(dot(x,sTangent)-sOffset < 0.){
      nearestPoint = s;
    }

  } else {
    dist = dist2;
    nearestPoint = projectedPoint2;

    float tOffset = dot(tTangent,t);
    if(dot(x,tTangent)-tOffset < 0.){
      nearestPoint = t;
    }
  }
  return baseThingConfig(nearestPoint, dist, sTangent, tTangent);
}
