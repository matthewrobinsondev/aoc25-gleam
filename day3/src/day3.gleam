import gleam/int
import gleam/list
import gleam/string
import simplifile

pub fn main() {
  let assert Ok(contents) = simplifile.read("input.txt")
  part_1(contents) |> echo
}

pub fn part_1(contents: String) -> Int {
  string.trim(contents)
  |> string.split("\n")
  |> list.fold(0, fn(acc, row) {
    let digits =
      string.to_graphemes(row)
      |> list.filter_map(int.parse)

    list.index_fold(digits, 0, fn(max_joltage, first_digit, i) {
      list.index_fold(digits, max_joltage, fn(current_max, second_digit, j) {
        case j > i {
          True -> {
            let joltage = first_digit * 10 + second_digit
            case joltage > current_max {
              True -> joltage
              False -> current_max
            }
          }
          False -> current_max
        }
      })
    })
    |> int.add(acc)
  })
}
