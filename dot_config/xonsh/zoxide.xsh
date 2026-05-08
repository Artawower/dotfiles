import shutil

if shutil.which('zoxide'):
    execx($(zoxide init xonsh), 'exec', __xonsh__.ctx, filename='zoxide')
    aliases['pp'] = aliases['zi']  # interactive zoxide picker (fzf)
