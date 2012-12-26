use syntax::*;

fn main() {
  let a = os::args();
  if a.len() == 1 {
    fail(~"need at least one file as an argument");
  }

  let file = copy a[1];
  let {status, out, _} = prof(~"JSON",
                              || run::program_output("parse/parser", [file]));
  if status != 0 {
    io::print(out);
    fail(~"Failed to parse the given file");
  }

  let ast = prof(~"AST", || parse::from_str(out));
  ast.elaborate();
  io::print(ast.pp() + ~"\n");
}
