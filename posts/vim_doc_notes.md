 For example "50%" moves you to halfway the file.  "90%" goes to near the end.

 Fortunately CTRL-F is Forward and CTRL-B is Backward, that's easy to remember.

A common issue is that after moving down many lines with "j" your cursor is at
the bottom of the screen.  You would like to see the context of the line with
the cursor.  That's done with the "zz" command.The "zt" command puts the cursor line at the top, "zb" at the bottom.

searches :set noignorecase   查看搜索history(With the previous example, you can type "/o<Up>" and Vim will put "/one" on the command line.),
:set hlsearch 显示高亮, If you only want to remove the highlighting, use this command :nohlsearch, This doesn't reset the option.  Instead, it disables the highlighting.  As soon as you execute a search command,
:set incsearch ,This makes Vim display the match for the string while you are still typing it.

The commands starting with ":" also have a history.

mark: 跳到的位置叫mark，注意，用jk we命令的不算mark(现在知道为什么有时候c-o不能跳到上一个位置的原因了吧)。To go back
where you came from, use \`\`

The \`\` command jumps back and forth, between two points.  The CTRL-O command
jumps to older positions (Hint: O for older).  CTRL-I then jumps back to newer
positions (Hint: I is just next to O on the keyboard).
The ":jumps" command gives a list of positions you jumped to.  The entry which
you used last is marked with a ">".

The command "ma" marks
the place under the cursor as mark a.  You can place 26 marks (a through z) in
your text. To go to a mark, use the command `{mark}
You can use this command to get a list of marks:
:marks

The "." command works for all changes you make, except for the "u" (undo),
CTRL-R (redo) and commands that start with a colon (:).(仅仅是 change command)

in visual mode use the "o" command (Hint: o for other end) to go to the other end,
When using blockwise selection, you have four corners.  "o" only takes you to
one of the other corners, diagonally.  Use "O" to move to the other corner in
the same line.

You can switch between Insert mode and Replace mode with the <Insert> key.

"cis" 类似 "ci(", "is" stands for "Inner Sentence", "as" stands for "a sentence", "ca("同理 (以前以为是 all, 其实是 a)

~: change case of the character
* set your settings

The ":map" command (with no arguments) lists your current mappings.

**autocmd FileType text setlocal textwidth=78**

 "autocmd FileType text" is an autocommand.  This
defines that when the file type is set to "text" the following command is
automatically executed.
* Using the GUI

visual模式选中的文本会自动放在"*(star)寄存器里