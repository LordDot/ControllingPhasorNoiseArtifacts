baseThingConfig straight(vec2 x, vec2 s, vec2 t){
  vec2 st = t - s;
  vec2 stN = st / sqrt(dot(st,st));
  vec2 sTangent = stN;
  vec2 tTangent = -stN;
  vec2 normal = vec2(-stN.y,stN.x);
  float offset = dot(normal, s);
  float dist = dot(normal, x) - offset;
  vec2 projectedPoint = x - normal * dist;
  float pos = dot(stN,x-s) / sqrt(dot(st,st));
  vec2 nearestPoint;
  if(pos < 0.){
    nearestPoint = s;
  } else if (pos < 1.){
    nearestPoint = projectedPoint;
  } else {
    nearestPoint = t;
  }
  return baseThingConfig(nearestPoint, dist,sTangent, tTangent);
}
