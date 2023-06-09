#include <stdlib.h>
#include <stdio.h>
#include <readline/readline.h>
#include <readline/history.h>

int main()
{
    // Configure readline to auto-complete paths when the tab key is hit.
    rl_bind_key('\t', rl_complete);

    // Enable history
    using_history();

    while (1)
    {
        // Display prompt and read input
        char *input = readline("prompt> ");

        // Check for EOF.
        if (!input)
            break;

        // Add input to readline history.
        add_history(input);

        // Do stuff...

        // Free buffer that was allocated by readline
        free(input);
    }
    return 0;
}