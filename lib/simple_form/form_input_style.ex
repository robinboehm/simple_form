defmodule SimpleForm.FormInputStyle do
  @callback checkbox(SimpleForm.FormInput.t()) :: tuple
  @callback date_select(SimpleForm.FormInput.t()) :: tuple
  @callback datetime_select(SimpleForm.FormInput.t()) :: tuple
  @callback number_input(SimpleForm.FormInput.t()) :: tuple
  # @callback radio_buttons(SimpleForm.FormInput.t) :: tuple
  @callback select(SimpleForm.FormInput.t()) :: tuple
  @callback text_input(SimpleForm.FormInput.t()) :: tuple
  # @callback time_select(SimpleForm.FormInput.t) :: tuple
end
