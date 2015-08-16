# ton

Tactics of Nine. Tactical RPG game.

## Installation

Ensure you have crystal-lang 0.7.5+ installed.

After cloning this repo:

```bash
make
```

## Usage

```bash
bin/ton
```

## Development

Use normal TDD cycle. To run tests: `crystal spec`.

## Roadmap

- [x] Ability to move camera
- [x] Ability to select character
- [x] Show actions menu for selected character
- [x] Cancel selection action
- [x] Move character action
- [x] Ability to have multiple characters and move them around
- [x] Add status bar
- [ ] Add messages bar
- [x] Disallow using any other object as a movement target
- [ ] Fix flickering when multiple windows are open
- [ ] Add energy concept: moving and acting takes energy; energy replenishes over time
- [ ] Add simple enemy melee AI

## Contributing

1. Fork it ( https://github.com/waterlink/ton/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [waterlink](https://github.com/waterlink) Oleksii Fedorov - creator, maintainer
