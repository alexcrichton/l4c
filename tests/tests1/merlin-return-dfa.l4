//test return 1
//dfa which accepts string of 1's,0's
//with an even number of 0,1 pairs

struct state{
  int name;
  int[] transitions;
};

typedef struct state state;

state* init(int index)
{
  state* new = alloc(state);
  new->name = index;
  new->transitions = alloc_array(int,2);
  return new;
}

int main()
{
  state*[] states = alloc_array(state*,4);
  for(int i = 0; i < 4; i++)
    states[i] = init(i);

  states[0]->transitions[0] = 1;
  states[0]->transitions[1] = 0;

  states[1]->transitions[0] = 1;
  states[1]->transitions[1] = 2;

  states[2]->transitions[0] = 3;
  states[2]->transitions[1] = 2;

  states[3]->transitions[0] = 3;
  states[3]->transitions[1] = 0;

  int current = 0;
  while(!eof())
  {
    int input = readint();
    current = states[current]->transitions[input]; 
  }

  if(current == 0 || current == 1)
    return 1;
  else
    return 0;
}

