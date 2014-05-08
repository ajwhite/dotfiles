# Atticus Dotfiles

To load dotfiles, create .dotfiles directory and add snippet to your .bash_profile
```

if [ -d ".dotfiles" ]; then
        for file in ~/.dotfiles/.{path,profile,aliases,exports,functions}; do
                [ -r "$file" ] && [ -f "$file" ] && source "$file"
        done
fi
```