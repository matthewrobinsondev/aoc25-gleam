import day1
import gleeunit
import gleeunit/should
import simplifile

pub fn main() -> Nil {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn part_one_test() {
  let assert Ok(contents) = simplifile.read("example.txt")
  day1.part_1(contents) |> should.equal(3)
}

pub fn part_two_test() {
  let assert Ok(contents) = simplifile.read("example.txt")
  day1.part_2(contents) |> should.equal(6)
}
