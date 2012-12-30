pub const arg_regs : uint = 6;
pub const ptrsize : uint = 8;
pub const intsize : uint = 4;

pub fn arg_reg(i : uint) -> assem::Register {
  match i {
    0 => assem::EDI,
    1 => assem::ESI,
    2 => assem::EDX,
    3 => assem::ECX,
    4 => assem::R8D,
    5 => assem::R9D,
    _ => fail(~"not that many argument registers")
  }
}
