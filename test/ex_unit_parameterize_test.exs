Code.require_file "../test_helper.exs", __FILE__

defmodule ParameteriseTest do
  use ExUnit.Case
  use ExUnit.Parameterize

  with_named_params fn(a,b,answer) -> assert a+b == answer end do
    [
      first:  {   1,   2,      3},
      second: {  -2,  20,     18},
      third:  {   0,   0,      0},
      fourth: { 3.8, -29,  -25.2},
    ]
  end

  with_params :hello, fn(a, b, answer) -> assert a<>b == answer end do
    [
      { "Hello, ",    "world!",          "Hello, world!"         },
      { "Cool",       "",                "Cool"                   },
      { "http://",    "elixir-lang.org", "http://elixir-lang.org" },
    ]
  end

  with_params fn(a, b, answer) -> assert a<>b == answer end do
    [
      { "Hello, ",    "world!",          "Hello, world!"         },
      { "Cool",       "",                "Cool"                   },
      { "http://",    "elixir-lang.org", "http://elixir-lang.org" },
    ]
  end
end
