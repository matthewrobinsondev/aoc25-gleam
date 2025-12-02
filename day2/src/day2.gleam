import gleam/int
import gleam/list
import gleam/order
import gleam/result
import gleam/string
import simplifile

pub fn main() {
  let assert Ok(contents) = simplifile.read("input.txt")
  part_1(contents) |> echo
  part_2(contents) |> echo
}

pub fn part_1(contents: String) -> Int {
  string.trim_end(contents)
  |> string.split(",")
  |> list.fold(0, fn(acc, row) {
    let ids = string.split(row, "-")
    loop_over_ids(
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

pub fn part_2(contents: String) -> Int {
  string.trim_end(contents)
  |> string.split(",")
  |> list.fold(0, fn(acc, row) {
    let ids = string.split(row, "-")
    loop_over_ids_2(
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

fn loop_over_ids_2(needle: Int, end: Int, acc: Int) -> Int {
  case int.compare(needle, end) {
    order.Gt -> acc
    _ -> {
      let acc = acc + check_for_invalid_ids_2(int.to_string(needle))

      case int.compare(needle, end) {
        order.Gt -> acc
        _ -> loop_over_ids_2(needle + 1, end, acc)
      }
    }
  }
}

fn check_for_invalid_ids_2(id: String) -> Int {
  let length = string.length(id)

  case length > 10 || length < 2 {
    True -> 0
    False -> {
      let is_invalid =
        list.range(1, length / 2)
        |> list.any(fn(pattern_length) {
          case length % pattern_length == 0 {
            False -> False
            True -> {
              let pattern = string.slice(id, 0, pattern_length)
              let repeat_count = length / pattern_length
              case repeat_count >= 2 {
                False -> False
                True -> {
                  let repeated = string.repeat(pattern, repeat_count)
                  repeated == id
                }
              }
            }
          }
        })

      case is_invalid {
        True -> int.parse(id) |> result.unwrap(or: 0)
        False -> 0
      }
    }
  }
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
        True -> int.parse(id) |> result.unwrap(or: 0)
        _ -> 0
      }
    }
  }
}
