defmodule SimpleForm.FormInput do
  @moduledoc ~S"""

  Configuration struct that defines the entrypoint for a SimpleForm invokation

  <%= input f, :user_id, collection: @form_collections.users %>

  The following options are supported

  - `label` - Overwrite the default labelname with is the name of the field humanized.
  - `collection` - Define a list of values for a select input
  - `hint` - Define a hint text
  - `label_attrs`- Overwrite the attributes of the label
  - `wrapper_attrs` - Overwrite the attributes of the wrapper
  - `input_attrs` - Overwrite the attributes of the input

  """
  defstruct form: nil,
            field: nil,
            field_str: nil,
            input_attrs: [],
            wrapper_attrs: [],
            label_attrs: [],
            clean_opts: [],
            opts: [],
            collection: nil,
            required: nil,
            hint: nil,
            label: nil,
            label_human: nil,
            label_translated: nil,
            errors: nil,
            errors_translated: nil,
            style_module: nil

  @doc """

  Takes a form and generates input opts

  iex> build(%Phoenix.HTML.Form{impl: Phoenix.HTML.FormData.Ecto.Changeset, source: %{types: %{name: :string}, required: [], validations: []}}, :name, [], fn x -> x end, SimpleForm.Styles.Bootstrap4)
  %SimpleForm.FormInput{
              clean_opts: [],
              collection: nil,
              errors: [],
              errors_translated: [],
              field: :name,
              field_str: "name",
              form: %Phoenix.HTML.Form{
                action: nil,
                data: nil,
                errors: [],
                hidden: [],
                id: nil,
                impl: Phoenix.HTML.FormData.Ecto.Changeset,
                index: nil,
                name: nil,
                options: [],
                params: %{},
                source: %{
                  required: [],
                  types: %{name: :string},
                  validations: []
                }
              },
              hint: nil,
              input_attrs: [],
              label: "Name",
              label_attrs: [],
              label_human: "Name",
              label_translated: nil,
              opts: [],
              required: false,
              style_module: SimpleForm.Styles.Bootstrap4,
              wrapper_attrs: []
            }


  Detect required state from ecto schema.

  iex> build(%Phoenix.HTML.Form{impl: Phoenix.HTML.FormData.Ecto.Changeset, source: %{types: %{name: :string}, required: [:name], validations: []}}, :name, [], fn x -> x end, SimpleForm.Styles.Bootstrap4)
  %SimpleForm.FormInput{
              clean_opts: [],
              collection: nil,
              errors: [],
              errors_translated: [],
              field: :name,
              field_str: "name",
              form: %Phoenix.HTML.Form{
                action: nil,
                data: nil,
                errors: [],
                hidden: [],
                id: nil,
                impl: Phoenix.HTML.FormData.Ecto.Changeset,
                index: nil,
                name: nil,
                options: [],
                params: %{},
                source: %{
                  required: [:name],
                  types: %{name: :string},
                  validations: []
                }
              },
              hint: nil,
              input_attrs: [],
              label: "Name",
              label_attrs: [],
              label_human: "Name",
              label_translated: nil,
              opts: [],
              required: true,
              style_module: SimpleForm.Styles.Bootstrap4,
              wrapper_attrs: []
            }

  """
  def build(%Phoenix.HTML.Form{} = form, field, opts, translate_fn, style_module) do
    label_human = Phoenix.HTML.Form.humanize(field)

    {collection, clean_opts} = Keyword.pop(opts, :collection)
    {hint, clean_opts} = Keyword.pop(clean_opts, :hint)
    {label_attrs, clean_opts} = Keyword.pop(clean_opts, :label_attrs, [])
    {wrapper_attrs, clean_opts} = Keyword.pop(clean_opts, :wrapper_attrs, [])
    {input_attrs, clean_opts} = Keyword.pop(clean_opts, :input_attrs, [])
    {label, clean_opts} = Keyword.pop(clean_opts, :label, label_human)

    errors = Keyword.get_values(form.errors, field)
    errors_translated = Enum.map(errors, fn error -> translate_fn.(error) end)

    required = form |> Phoenix.HTML.Form.input_validations(field) |> Keyword.get(:required, false)

    %__MODULE__{
      form: form,
      field: field,
      field_str: Atom.to_string(field),
      opts: opts,
      clean_opts: clean_opts,
      label_attrs: label_attrs,
      wrapper_attrs: wrapper_attrs,
      input_attrs: Keyword.merge(clean_opts, input_attrs),
      collection: collection,
      required: !!required,
      label_human: label_human,
      label: label,
      hint: hint,
      style_module: style_module,
      errors: errors,
      errors_translated: errors_translated
    }
  end
end
