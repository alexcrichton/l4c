//test return 0
// evaluator (with parser and pretty printer) for the SKI-combinator calculus
// parses a program from STDIN and prints it back out
// concrete syntax for SKI-combinator calculus is
//
// (simple expressions) 
// s ::= S | K | I
//
// (expressions aka programs)
// e ::= s | (e e) | e e
//
// application (i.e. the latter two forms of expression) binds to the left
//
// so, for example, the following are syntactically valid SKI programs:
//
//   S K I
//   (S K) I
//   S (K I)
//
// note that there are multiple was to represent the same (syntactic) program;
// for example, the first two programs above will be parsed the same.
//   
// see http://en.wikipedia.org/wiki/SKI_combinator_calculus

struct exp_rep {
  int class;
  struct exp_rep* e1;
  struct exp_rep* e2;
};

typedef struct exp_rep* exp;

exp s () {
  struct exp_rep* s = alloc(struct exp_rep);
  s->class = 0;
  s->e1 = NULL;
  s->e2 = NULL;
  return s;
}

exp k () {
  struct exp_rep* s = alloc(struct exp_rep);
  s->class = 1;
  s->e1 = NULL;
  s->e2 = NULL;
  return s;
}

exp i () {
  struct exp_rep* s = alloc(struct exp_rep);
  s->class = 2;
  s->e1 = NULL;
  s->e2 = NULL;
  return s;
}

exp app (exp e1, exp e2) {
  struct exp_rep* s = alloc(struct exp_rep);
  s->class = 3;
  s->e1 = e1;
  s->e2 = e2;
  return s;
}

exp app2 (exp e1, exp e2) {
  return app(e1, e2);
}

exp app3 (exp e1, exp e2, exp e3) {
  return app(app(e1, e2), e3);
}

exp app4 (exp e1, exp e2, exp e3, exp e4) {
  return app(app3(e1, e2, e3), e4);
}

bool isS (exp e) {
  return e->class == 0;
}

bool isK (exp e) {
  return e->class == 1;
}

bool isI (exp e) {
  return e->class == 2;
}

bool isApp (exp e) {
  return e->class == 3;
}

exp getE1 (exp e) {
  return e->e1;
}

exp getE2 (exp e) {
  return e->e2;
}

exp eval (exp e) {
  if (isS(e)) {
    return e;
  } else if (isK(e)) {
    return e;
  } else if (isI(e)) {
    return e;
  } else {
    exp v1 = eval(getE1(e));
    exp e2 = getE2(e);
    if (isI(v1)) {
      // I e2
      return eval(e2);
    } else if (isApp(v1)) {
      exp v11 = getE1(v1);
      exp v12 = getE2(v1);
      if (isK(v11)) {
        // K v12 e2
        return v12;
      } else if (isApp(v11)) {
        exp v111 = getE1(v11);
        exp v112 = getE2(v11);
        if (isS(v111)) {
          // S v112 v12 e2
          return eval(app(app(v112, e2), app(v12, e2)));
        } else {
          return e;
        }
      } else {
        return e;
      }
    } else {
      return e;
    }
  }
}

int error () {
  return 0 / 0;
}

int print (exp e) {
  if (isS(e)) {
    printchar(83); // 'S'
  } else if (isK(e)) {
    printchar(75); // 'K'
  } else if (isI(e)) {
    printchar(73); // 'I'
  } else if (isApp(e)) {
    printchar(40); // '('
    print(getE1(e));
    printchar(32); // ' '
    print(getE2(e));
    printchar(41); // ')'
  } else {
    error();
  }
  return 0;
}

int println () {
  printchar(10);
  return 0;
}

int assertTrue (bool b) {
  return b ? 0 : 0 / 0;
}

exp grow (exp e1, exp e2) {
  return e1 == NULL ? e2 : app(e1, e2);
}

exp parseUntil (exp e1, int ch1) {
  exp s_ = s();
  exp k_ = k();
  exp i_ = i();
  while (!eof()) {
    int ch2 = readchar();
    if (ch2 == 10) {
      // end of line
      assertTrue(e1 != NULL); // ensures non empty program
      assertTrue(ch1 == 10); // ensures all parens are closed
      return e1;
    } else if (ch2 == 83) {
      // 'S'
      exp e2 = s_;
      e1 = grow(e1, e2);
      continue;
    } else if (ch2 == 75) {
      // 'K'
      exp e2 = k_;
      e1 = grow(e1, e2);
      continue;
    } else if (ch2 == 73) {
      // 'I'
      exp e2 = i_;
      e1 = grow(e1, e2);
      continue;
    } else if (ch2 == 40) {
      // '('
      exp e2 = parseUntil(NULL, 41); // munch until closing parens
      e1 = grow(e1, e2);
      continue;
    } else if (ch2 == 41) {
      // ')'
      assertTrue(e1 != NULL); // ensures non empty program
      assertTrue(ch1 == 41); // ensures we were expected a closing parens
      return e1;
    }
  }
  assertTrue(e1 != NULL);
  return e1;
}

exp parseLine () {
  return parseUntil(NULL, 10);
}

int main () {
  exp e = parseLine();
  print(e);
  println();
  return 0;
}
