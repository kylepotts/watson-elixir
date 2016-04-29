defmodule Watson do
  use Application

  def start(_type, _args) do
    Watson.Supervisor.start_link(WatsonRoutes)
  end

end


defmodule WatsonRoutes do
  @moduledoc """
  Help
  """
  def routes do
    [
      {~r/watson status/, {Watson.Commands.Hello, :status}},
      {~r/watson (who am I|what('s| is) my name)/, {Watson.Commands.Hello, :who_am_i}},
      {~r/watson help/, {WatsonRoutes, :watson_help}},
      {~r/watson youtube (?<query>.*)/, {Watson.Commands.Youtube, :search_for_youtube_video}}
    ]
  end

  @doc """
  Matches on ~r/watson help/
  Print out the list of commands Watson can perform
  """
  def watson_help(message, reg_match, slack) do
    modules = Enum.map(WatsonRoutes.routes(), fn({regex, {module,_}}) ->
      module
    end)
    |> Enum.uniq

    docs = Enum.reduce(modules,[], &grab_docs_from_module/2)
    strings = Enum.map(docs,&create_slack_doc_string/1)
    ">>>" <> Enum.join(strings,"\n")
  end

  defp grab_docs_from_module(module,acc) do
    doc_items = Code.get_docs(module,:docs)
    func_docs = Enum.reduce(doc_items, [], fn(doc_item, acc2) ->
      {{func_name,_}, _, _, _, doc_string} = doc_item
      if doc_string do
        acc2 ++ [[Atom.to_string(func_name),doc_string]]
      else
        acc2
      end
    end)

    {_, mod_doc_string} = Code.get_docs(module, :moduledoc)
    case func_docs do
      [] -> acc
      _ -> acc ++ [%{:mod_doc => mod_doc_string, :func_doc => func_docs}]
    end
  end

  defp create_slack_doc_string(doc) do
    mod_doc = String.replace(doc.mod_doc,"\n","")
    func_docs = doc.func_doc
    s = ~s(_#{mod_doc}_\n)
    Enum.reduce(func_docs, s, fn(func,acc) ->
      [name,f_doc] = func
      f_doc = String.replace(f_doc,"\n", "\n\t\t")
      acc <> ~s(\n command: *#{String.replace(name,"_", " ")}*\n\t\t #{f_doc})
    end)
  end


end
