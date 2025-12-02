import day2
import gleeunit
import gleeunit/should
import simplifile

pub fn main() -> Nil {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn part_one_test() {
  let assert Ok(contents) = simplifile.read("example.txt")
  day2.part_1(contents) |> should.equal(1_227_775_554)
}

pub fn part_two_test() {
  let assert Ok(contents) = simplifile.read("example.txt")
  day2.part_2(contents) |> should.equal(4_174_379_265)
}
