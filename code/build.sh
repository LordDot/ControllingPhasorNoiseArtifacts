#!/bin/bash
if [ ! -d "build" ]; then
  mkdir build
fi

../ShaderBundler/build/install/ShaderBundler/bin/ShaderBundler config.json
cp build/bundeledShader.shader ../unity/hljhk/Assets/asfdf.shader
