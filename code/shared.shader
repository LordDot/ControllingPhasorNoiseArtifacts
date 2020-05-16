# define M_PI 3.14159265358979323846

float _f = 15.0;
float _b = 10.0;
float _o = 1.0;

///////////////////////////////////////////////
//prng
///////////////////////////////////////////////
int _seed = 1;
int N = 15487469;
int x_;
void seed(int s){x_ = s;}
int next() { x_ *= 3039177861; x_ = x_ % N;return x_; }
float uni_0_1() {return  float(next()) / float(N);}
float uni(float min, float max){ return min + (uni_0_1() * (max - min));}


int morton(int x, int y)
{
  int z = 0;
  for (int i = 0 ; i < 32* 4 ; i++) {
    z |= ((x & (1 << i)) << i) | ((y & (1 << i)) << (i + 1));
  }
  return z;
}

struct baseThingConfig{
  vec2 nearestPoint;
  float dist;
  vec2 sTangent;
  vec2 tTangent;
};

        float gauss1d(float x, float sigma){
          return exp(-x*x/(sigma*sigma));
        }

        float gauss2d(vec2 x, float sigma){
          return exp(-dot(x,x)/(sigma*sigma));
        }

