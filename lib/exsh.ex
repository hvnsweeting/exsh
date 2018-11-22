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

  def start() do
    # TODO smarter split - like Python shutil.split
    cmds = IO.gets(System.cwd() <> "$ ") |> String.split("|")
    # TODO support pipe |
    # Seems not able to pass stdin to System.cmd
    # probably need Port https://stackoverflow.com/questions/41025736/how-to-write-to-stdin-of-external-process-in-elixir?noredirect=1&lq=1
    # Run the first cmd only, for now
    cmds |> List.first() |> run_cmd
    start()
  end
end
