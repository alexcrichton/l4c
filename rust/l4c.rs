fn main() {
  let a = os::args();
  if a.len() == 1 {
    fail(~"need at least one file as an argument");
  }

  let file = copy a[1];
  let {status, out, _} = run::program_output("parse/parser", [file]);
  if status != 0 {
    io::print(out);
    fail(~"Failed to parse the given file");
  }

  match json::from_str(out) {
    result::Ok(_) => io::print("woohoo"),
    result::Err(e) => io::print(fmt!("JSON parse error: %?", e.msg))
  }
}
