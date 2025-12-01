import gleam/int
import gleam/list
import gleam/result
import gleam/string
import simplifile

pub fn main() {
  let assert Ok(contents) = simplifile.read("input.txt")
  part_1(contents) |> echo
  part_2(contents) |> echo
}

pub fn part_1(contents: String) -> Int {
  string.trim(contents)
  |> string.split("\n")
  |> list.fold(#(0, 50), fn(acc, row) {
    let #(count, current_value) = acc

    let value = case string.first(row) {
      Ok(value) ->
        case value {
          "R" ->
            string.slice(row, 1, 10)
            |> int.parse()
            |> result.unwrap(or: 0)
            |> fn(x) -> Int {
              let assert Ok(parsed) =
                x
                |> int.to_string()
                |> fn(s) -> String {
                  case string.length(s) {
                    3 -> string.drop_start(s, 1)
                    4 -> string.drop_start(s, 2)
                    _ -> s
                  }
                }
                |> int.parse()

              int.add(current_value, parsed)
            }
          "L" ->
            string.slice(row, 1, 10)
            |> int.parse()
            |> result.unwrap(or: 0)
            |> fn(x) -> Int {
              let assert Ok(parsed) =
                x
                |> int.to_string()
                |> fn(s) -> String {
                  case string.length(s) {
                    3 -> string.drop_start(s, 1)
                    4 -> string.drop_start(s, 2)
                    _ -> s
                  }
                }
                |> int.parse()

              int.subtract(current_value, parsed)
            }
          _ -> todo
        }
      Error(_) -> todo
    }

    let new_value = case value {
      100 -> 0
      _ if value > 100 -> value - 100
      _ if value < 0 -> value + 100
      _ -> value
    }

    let new_count = case new_value {
      0 -> count + 1
      _ -> count
    }

    #(new_count, new_value)
  })
  |> fn(result) {
    let #(final_count, _) = result
    final_count
  }
}

pub fn part_2(contents: String) -> Int {
  string.trim(contents)
  |> string.split("\n")
  |> list.fold(#(0, 50), fn(acc, row) {
    let #(count, current_value) = acc

    let value = case string.first(row) {
      Ok(value) ->
        case value {
          "R" ->
            string.slice(row, 1, 10)
            |> int.parse()
            |> result.unwrap(or: 0)
            |> fn(x) -> Int {
              let assert Ok(parsed) =
                x
                |> int.to_string()
                |> fn(s) -> String {
                  case string.length(s) {
                    3 -> string.drop_start(s, 1)
                    4 -> string.drop_start(s, 2)
                    _ -> s
                  }
                }
                |> int.parse()

              int.add(current_value, parsed)
            }
          "L" ->
            string.slice(row, 1, 10)
            |> int.parse()
            |> result.unwrap(or: 0)
            |> fn(x) -> Int {
              let assert Ok(parsed) =
                x
                |> int.to_string()
                |> fn(s) -> String {
                  case string.length(s) {
                    3 -> string.drop_start(s, 1)
                    4 -> string.drop_start(s, 2)
                    _ -> s
                  }
                }
                |> int.parse()

              int.subtract(current_value, parsed)
            }
          _ -> todo
        }
      Error(_) -> todo
    }

    // hack cos i cba rewriting the last part atm 

    let number = string.slice(row, 1, 10)
    let add = case string.length(number) {
      3 ->
        string.first(number)
        |> result.unwrap(or: "")
        |> int.parse()
        |> result.unwrap(or: 0)
      4 ->
        string.drop_end(number, 2)
        |> int.parse()
        |> result.unwrap(or: 0)
      _ -> 0
    }

    let new_count = case value {
      0 -> count + 1
      100 -> count + 1
      _ if value > 100 && current_value != 0 -> count + 1
      _ if value < 0 && current_value != 0 -> count + 1
      _ -> count
    }

    let new_value = case value {
      100 -> 0
      _ if value > 100 -> value - 100
      _ if value < 0 -> value + 100
      _ -> value
    }

    let new_count = new_count + add

    #(new_count, new_value)
  })
  |> fn(result) {
    let #(final_count, _) = result
    final_count
  }
}
