import gleam/int
import gleam/list
import gleam/order
import gleam/result
import gleam/string
import simplifile

pub fn main() {
  let assert Ok(contents) = simplifile.read("input.txt")
  part_1(contents) |> echo
}

pub fn part_1(contents: String) -> Int {
  string.drop_end(contents, 2)
  |> string.split(",")
  |> list.fold(0, fn(acc, row) {
    let ids = string.split(row, "-")
    echo loop_over_ids(
      list.first(ids)
        |> result.unwrap(or: "0")
        |> int.parse()
        |> result.unwrap(or: 0),
      list.last(ids)
        |> result.unwrap(or: "0")
        |> int.parse()
        |> result.unwrap(or: 0),
      acc,
    )
  })
}

fn loop_over_ids(needle: Int, end: Int, acc: Int) -> Int {
  case int.compare(needle, end) {
    order.Gt -> acc
    _ -> {
      let acc = acc + check_for_invalid_ids(int.to_string(needle))

      case int.compare(needle, end) {
        order.Gt -> acc
        _ -> loop_over_ids(needle + 1, end, acc)
      }
    }
  }
}

fn check_for_invalid_ids(id: String) -> Int {
  let length = string.length(id)
  case int.is_odd(length) {
    True -> 0
    False -> {
      let end = string.drop_start(id, length / 2)
      case string.starts_with(id, end) {
        True -> int.parse(id) |> result.unwrap(or: 0) |> echo
        _ -> 0
      }
    }
  }
}
