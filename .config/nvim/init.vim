"" Include user's local vim config
if filereadable(expand("~/.nvimrc"))
  source ~/.nvimrc
endif
