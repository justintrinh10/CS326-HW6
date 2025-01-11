chat :-
    read_line_to_string(user_input, Input),
    chatResponse(Input).

chatResponse("Goodbye") :-
    write('"Talk to you later!"').

chatResponse(Input) :-
    promts(Input, Output),
    write(Output), nl,
    chat.

promts("Hello", "Hi!").
promts("How are you?", "I\'m fine, thank you").
promts("Do you chew ice?", "I love chewing ice, theres nothing wrong with it!").
promts("I\'m tired right now", "Aren\'t we all tired").
promts(_, "I like pickles...").