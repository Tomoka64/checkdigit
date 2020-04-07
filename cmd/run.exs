Runner.start_link()

commands = [
  {Checkdigit.Luhn, "5105105105105100"},
  {Checkdigit.Luhn, "567898765456789"},
  {Checkdigit.Luhn, "7656787654567876"},
  {Checkdigit.Luhn, "345678987654345678"},
  {Checkdigit.Luhn, "6"},
  {Checkdigit.Luhn, ""},
]

Runner.verify(commands)
