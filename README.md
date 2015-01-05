# Medoc

Medoc is a tiny Ruby gem for managing you shell aliases. Jump to another directory in a clever way.

## Get started

To install Medoc, run this command:

```
gem install medoc
```

Once done, open your `.bash_profile` file, or another `profile` you are using with your shell. Then, append this code:

```bash
# Medoc config
medoc_exec() {
    cd "`/usr/bin/medoc $@`"
}

alias medoc=medoc_exec
```

Here you go! Run `medoc your-alias` to leap to a directory.

## Configuration file

Medoc lets user using a configuration file to define all his/her aliases: `~/.medoc.yml`.

When you are using Medoc for the first time, run `medoc --init` to automatically generate this file.

Config file is a simple YAML file. Here is a sample:

```yaml
my-first-alias: path/to/my/fabulous/directory

another-alias: path/to/another/directory

magic-alias:
	- my-first-alias
	- path/to/random/directory # Relative to previous one
	- another-alias
	- path/to/somewhere
```

As you may have seen, you can define an alias using two ways. First one is the simplest: just specify the path to your directory.

Other way is an array mixing aliases and directories. Use here existing aliases and normal directories. Medoc will get the job done for you.