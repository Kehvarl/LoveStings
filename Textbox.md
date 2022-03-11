##Textboxes

Example Usage
```ruby
def tick args
  long_string = "Lorem ipsum dolor sit amet, consectetur adipiscing elitteger dolor velit, ultricies vitae libero vel, aliquam imperdiet enim."
  args.state.textbox ||= TextBox.new(text: long_string + long_string, speaker: "Player")
  
  if args.inputs.keyboard.key_down.space
    args.state.textbox.speaker = ['Player', 'Jelly', 'Space Pirate Captain'].sample
    args.state.textbox.text = [long_string, "The quick brown fox jumped over the lazy dog", "...", "And that's that!"].sample
  end
  
  args.outputs.primitives << args.state.textbox.render(args)
end
```

![Textbox Example](metadata/Text1.png?raw=true "Sample Text")

![Textbox Example 2](metadata/Text2.png?raw=true "Sample Text")
