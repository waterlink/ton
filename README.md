# ton

Tactics of Nine. Fast-paced top-down tactical RPG game.

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

- [x] Show total energy cost for a given action or movement
- [x] Show actions menu for selected character
- [x] Move character action
- [x] Disallow using any other object as a movement target
- [x] Cancel selection action
- [x] Add status bar
- [x] Add selected character status (energy, health, name, etc)
- [x] Add energy concept: moving and acting takes energy; energy replenishes over time
- [x] Ability to select character
- [x] Ability to move camera
- [x] Ability to have multiple characters and move them around
- [x] Allow to jump between characters (with tab?)
- [x] Allow for faster camera movement (with shift?)
- [x] Add ability to attack an enemy
- [x] Add target status bar
- [ ] Add simple enemy melee AI
- [ ] Fix flickering when multiple windows are open
- [ ] Add messages bar
- [ ] Add full-fledged world concept
- [ ] Put system list in the world
- [ ] Operate only on the world's entities/components
- [ ] Add map overview world
- [ ] Add battle world
- [ ] Add party world
- [ ] Enable world-switching
- [ ] Allow some entities to always stay in the current world
- [ ] Main menu world
- [ ] Main menu :: Start new game
- [ ] Pause menu world
- [ ] Pause menu :: Save game
- [ ] Main menu :: Load game
- [ ] Fast character unselect (ESC keypress?)
- [ ] Fast action cancel (ESC keypress?)
- [ ] AoE attacks
- [ ] Log all actions to message log
- [ ] Better death/decay systems
- [ ] Even faster character switching with numbers (1-9)
- [ ] Faster menu actions by capital letter

## Contributing

1. Fork it ( https://github.com/waterlink/ton/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [waterlink](https://github.com/waterlink) Oleksii Fedorov - creator, maintainer
