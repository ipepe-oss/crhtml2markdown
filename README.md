# crhtml2markdown

`crhtml2markdown` is both a Crystal library and command line interface for
converting HTML documents into Markdown format. The project aims to offer a
simple API that can be embedded in other Crystal applications while also
providing an easy to use binary for quick conversions on the command line.
At this early stage the conversion only extracts the textual content from the
HTML input. Future releases will add proper Markdown rendering of elements.

The library is currently in its early planning stage. The documentation lays out
the goals and how to contribute before any implementation begins.

## Installation

Add this shard to your project's `shard.yml`:

```yaml
dependencies:
  crhtml2markdown:
    github: ipepe-oss/crhtml2markdown
```

Then run `shards install` to fetch the dependency. Once the project publishes
releases, you will be able to use a version constraint instead of pointing to
the GitHub repository.

## Usage

When installed as a shard you can use `crhtml2markdown` as a library:

```crystal
require "crhtml2markdown"

markdown = Crhtml2markdown.convert("<p>Hello</p>")
```

The project will also expose a command line interface:

```bash
$ crhtml2markdown input.html > output.md
```

The binary is not yet implemented but these examples illustrate the intended
workflow.

## Development

After cloning the repository run the specs to ensure the environment is set up
correctly:

```bash
crystal spec
```

Code style follows Crystal's formatter. Run `crystal tool format` before
submitting patches.

Architecture Decision Records are kept in `docs/adr`. Please consult existing
records and create a new one if your change introduces new decisions.

## Contributing

1. Fork it (<https://github.com/ipepe-oss/crhtml2markdown/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Patryk Ptasiński](https://github.com/ipepe-oss) - creator and maintainer
