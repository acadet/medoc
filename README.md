# Medoc [![Gem Version](https://badge.fury.io/rb/medoc.svg)](http://badge.fury.io/rb/medoc)

Medoc is a tiny Ruby gem for managing your shell aliases. Jump to another directory in a clever way.

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

Medoc lets you use a configuration file to define all your aliases: `~/.medoc.yml`.

When you are using Medoc for the first time, run `medoc --init` to automatically generate this file.

Config file is written in YAML. Here is a sample:

```yaml
my-first-alias: path/to/my/fabulous/directory

another-alias: path/to/another/directory

magic-alias:
	- my-first-alias
	- path/to/random/directory # Relative to previous one
	- another-alias
	- path/to/somewhere
```

As you may have seen, you can define an alias using two ways. First one is the simplest: just specify the path of your directory.

Otherwise, you can use an array. Each element is either a directory or another alias. Medoc will jump to the first one, then moving to following etc.

Whatever the method you use, Medoc will get the job done for you.