defmodule Watson.Router do
  def route_message(routes_module, message,slack) do
    result =
      Enum.find routes_module.routes(), fn {regex, _module_function} ->
        Regex.match?(regex, message.text)
      end

    if result do
      {_regex, {module, function}} = result
      reg_matches = Regex.named_captures(_regex,message.text)
      apply(module, function, [message, reg_matches, slack])
    else
      nil
    end
  end
end
