defmodule ForumWeb.ThreadView do
  use ForumWeb, :view

  def custom_error_tag(form, field) do
    Enum.map(Keyword.get_values(form.errors, field), fn error ->
      content_tag(:span, translate_error(error),
        class:
          "bg-red-100 rounded-md text-red-800 border-2 border-red-300 mt-2 w-1/2 text-center p-1",
        phx_feedback_for: input_name(form, field)
      )
    end)
  end
end
