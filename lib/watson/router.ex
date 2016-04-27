defmodule Watson.Router do
  def route_message(routes_module, message,slack) do
    result =
      Enum.find routes_module.routes(), fn {regex, _module_function} ->
        Regex.match?(regex, message)
      end

    if result do
      {_regex, {module, function}} = result
      apply(module, function, [message,slack])
    else
      nil
    end
  end
end
