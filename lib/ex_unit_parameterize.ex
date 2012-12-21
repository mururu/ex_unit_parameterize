defmodule ExUnit.Parameterize do
  defmacro __using__(_) do
    quote do
      import unquote(__MODULE__)
    end
  end

  defmacro with_named_params(fun, params_clause) do
    {_, _, [params]} = Keyword.get(params_clause, :do, nil)

    Enum.map params, fn({name, {_, _, args}})->
      quote do
        test unquote(name) do
          unquote(fun).(unquote_splicing(args))
        end
      end
    end
  end

  defmacro with_params(name, fun, params_clause) do
    {_, _, [params]} = Keyword.get(params_clause, :do, nil)
    Enum.map with_index(params), fn({{_, _, args}, i})->
      quote do
        test unquote("#{name}_#{i}") do
          unquote(fun).(unquote_splicing(args))
        end
      end
    end
  end

  defmacro with_params(fun, params_clause) do
    {_, _, [params]} = Keyword.get(params_clause, :do, nil)
    Enum.map with_index(params), fn({{_, _, args}, i})->
      quote do
        test unquote("#{i}") do
          unquote(fun).(unquote_splicing(args))
        end
      end
    end
  end

  defp with_index(list) do
    Enum.zip(list, 0..Enum.count(list))
  end
end
