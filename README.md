# kapat — Fedora Shutdown Command

A small user-level command that shuts down Fedora when you type `kapat` in a terminal.

## Install

1. Extract this folder.
2. Open a terminal in the extracted `kapat-command` folder.
3. Run:

   ```bash
   bash install.sh
   ```

4. Restart the terminal (or reload your shell configuration).
5. Type `kapat` to shut down the computer.

The installer places the command in `~/.local/bin/kapat` and adds that directory to the appropriate shell configuration. It does not require `sudo` or change system-wide files.

## Important

Running `kapat` immediately requests system shutdown. Save your work first. Depending on your session and system policy, Fedora may ask for authorization or refuse the request.

## Uninstall

From this folder, run:

```bash
bash uninstall.sh
```
