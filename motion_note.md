# Vim Motion Notes

### Basic Motions
1. **Delete without adding to paste registry**: Use `<leader>p`.
2. **Select current word**: `viw` (without surrounding spaces).
3. **Select current WORD**: `viW` (includes everything until the next whitespace).
4. **Jump to a specific character**: `f<char>` (moves cursor to the first occurrence of `<char>`).
5. **Select everything inside `{}`**: `vi{` (excluding `{}`).
6. **Select everything inside `{}` including `{}`**: `va{` (if not inside `{}`, jumps to the next `{}`).
7. **Yank everything inside `{}` including `{}`**: `ya{` (if not inside `{}`, jumps to the next `{}`).
8. **Jump to next occurrence of `f<char>`**: `;` (move forward), `,` (move backward).
9. **Delete inside `{}`**: `di{`.
10. **Delete inside `{}` including `{}`**: `da{`.

### Advanced Motions
11. **Move before a specific character**: `t<char>` (stops before `<char>`).
12. **Move before the next occurrence of `f`**: `tf`.
13. **Delete until but not including `,`**: `dt,`.
14. **Change until but not including `)`**: `ct)`.
15. **Yank until but not including `;`**: `yt;`.
16. **Wrap selected text with `()`**: Use `S(` after visual selection.
17. **Select inside quotes**: `vi"` (selects text inside double quotes).
18. **Select inside single quotes**: `vi'`.
19. **Select inside brackets `[]`**: `vi[`.
20. **Select inside angle brackets `<>`**: `vi<`.
21. **Delete everything inside quotes**: `di"` (same applies to `di'`, `di[`, `di<`).
22. **Replace everything inside `{}`**: `ci{` (change inside `{}`, enter insert mode).
23. **Delete everything inside `{}` and stay in normal mode**: `di{`.
24. **Delete entire line**: `dd`.
25. **Delete from cursor to end of line**: `D`.
26. **Delete from cursor to beginning of line**: `d0`.
27. **Delete until but not including `)`**: `dt)`.
28. **Delete until and include `)`**: `df)`.
29. **Change until `,` but keep `,`**: `ct,`.
30. **Yank until `.` but keep `.`**: `yt.`.
31. **Move to matching pair**: `%` (jumps between `()`, `{}`, `[]`, `<>`).
32. **Move to next paragraph**: `}`.
33. **Move to previous paragraph**: `{`.
34. **Move to the beginning of a function**: `[[`.
35. **Move to the end of a function**: `]]`.

### Increment and List Transformation
36. **Auto-increment numbers in visual mode**: Select lines, press `g` then `Ctrl+A`.
37. **Transform a list of words into assignments**:
    - Given:
      ```
      Foo
      Bar
      Baz
      Buzz
      ```
    - Use:
      ```
      :s/\(\w.*\)/data[0] = "\1";/
      ```
    - Result:
      ```
      data[0] = "Foo";
      data[0] = "Bar";
      data[0] = "Baz";
      data[0] = "Buzz";
      ```

### Additional Notes
- Use `gv` to reselect the last visual selection.
- Use `gU` to convert the selected text to uppercase.
- Use `gu` to convert the selected text to lowercase.
- Use `g~` to toggle the case of the selected text.
- Use `*` to search forward for the word under the cursor.
- Use `#` to search backward for the word under the cursor.
- Use `/` followed by a search term to find text in the file.
- Use `n` to move to the next search result.
- Use `N` to move to the previous search result.

These motions will help you navigate and edit efficiently in Vim!

