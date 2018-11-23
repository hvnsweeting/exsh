# Exsh

Build Your Own Shell using Elixir

Inspired by Rust - https://www.joshmcguigan.com/blog/build-your-own-shell-rust/

## Run

```
$ mix run -e Exsh.start
```

To stop, type `exit` then Enter.

## TODO
### Support pipe operator `|`

This actually harder than it should for Erlang/Elixir.
The [Port](https://hexdocs.pm/elixir/Port.html)
example of Elixir uses `cat` nicely to send it text and get back
result. But there is a deep reason for using `cat`.
If you send `cat` 1 message, it outputs that RIGHT AWAY. But if you send `sort`
a line, it would wait for more, and run sort algorithm on whole inputs, because
sort is waiting for `EOF` (when the process creates the input stop - EOF
is not a character) - and many other UNIX utils (but not alL) do the same.
Erlang/Elixir stuck there, it cannot tell "EOF" to a Port. The only way it can
at 2018 is Port.close(), which shutdowns the program - or close both stdin
(EOF) and stdout, you can say `sort`: hey, that is all input, but also shutdown
`sort` at the time. The solution for this is using lib:
[porcelain](https://github.com/alco/porcelain).

See more:
- https://www.theerlangelist.com/article/outside_elixir
- http://erlang.org/pipermail/erlang-questions/2013-July/074905.html

## Installation - TODO

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `exsh` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:exsh, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/exsh](https://hexdocs.pm/exsh).
