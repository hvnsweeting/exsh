defmodule Exsh do
  @moduledoc """
  A simple shell in Elixir
  """

  def run_cmd(cmd) do
    [command | args] = cmd |> String.trim() |> String.split()
    stdout = ""

    case command do
      "cd" ->
        case args do
          [] ->
            File.cd(System.get_env("HOME"))
          _ ->
            out = File.cd(args)
            case out do
              {:error, _} ->
                IO.puts("cd: " <> List.first(args) <> ": No such file or directory")
              _ ->
                ""
            end
        end

      _ ->
        {stdout, _} = System.cmd(command, args)
        IO.puts(stdout)
    end

    stdout
  end

  @doc """
  THIS NOT WORK, see README
  """
  def run_via_port(cmd, stdin) do
    port = Port.open({:spawn, cmd}, [:binary])
    send(port, {self(), {:command, stdin}})
    out = receive do
      {_, {_, output}} -> output
    end
    Port.close(port)

    out
  end

  @doc """
  THIS NOT WORK, see README
  """
  def run_cmds([], output) do
    IO.puts("This is finallal output " <> output)
  end
  def run_cmds([h|t], input) do
    IO.puts("Running" <> h <> "with input" <> input)
    out = run_via_port(h, input)
    run_cmds(t, out)
  end


  def start() do
    # TODO smarter split - like Python shutil.split
    # It is not possible to pass stdin to System.cmd
    cmds = IO.gets(System.cwd() <> "$ ") |> String.split("|")
    # Run the first cmd only, for now
    cmds |> List.first() |> run_cmd
    start()
  end
end
