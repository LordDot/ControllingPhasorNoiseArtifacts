
        float interpolate(float y1, float y2, float alpha){
          alpha = (1.-cos(alpha*M_PI))/2.;
          return (1.-alpha)*y1 + alpha*y2;
        }

        ivec2 determineCell(vec2 uv, float cellSize){
          return ivec2(floor(uv/cellSize));
        }

        vec2 determinePosInCell(vec2 uv, float cellSize){
          return uv/cellSize - vec2(determineCell(uv, cellSize));
        }

        float evalSmoothNoiseInCell(ivec2 cell, vec2 restUv){
          int s = 0;
          s= morton(cell.x,cell.y) + 333;
          s = s==0? 1: s +_seed;
          seed(s);
          //first y, second x
          float val00 = uni_0_1();

          s= morton(cell.x + 1,cell.y) + 333;
          s = s==0? 1: s +_seed;
          seed(s);
          float val01 = uni_0_1();

          s= morton(cell.x,cell.y + 1) + 333;
          s = s==0? 1: s +_seed;
          seed(s);
          float val10 = uni_0_1();

          s= morton(cell.x + 1,cell.y + 1) + 333;
          s = s==0? 1: s +_seed;
          seed(s);
          float val11 = uni_0_1();

          float top = interpolate(val00,val01,restUv.x);
          float bottom = interpolate(val10,val11,restUv.x);

          return interpolate(top, bottom, restUv.y);
        }

        float evalSmoothNoise(vec2 uv, float cellSize){
          ivec2 cell = determineCell(uv, cellSize);
          return evalSmoothNoiseInCell(cell, determinePosInCell(uv,cellSize));
        }

        float evalHirarchNoise(vec2 uv){
          float sum = 0.;
          float amplitude = 1.5;
          float cellSize = 0.35;
          for(int i = 0; i < 3; i++){

            sum += amplitude  * evalSmoothNoise(uv, cellSize);

            cellSize = cellSize / 1.5;
            amplitude = amplitude/2.;
          }
          return sum;
        }
