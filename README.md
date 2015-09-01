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

- [x] Add battle world
- [x] Add full-fledged world concept
- [x] Enable world-switching
- [x] Even faster character switching with numbers (1-9)
- [x] Faster enemy targetting (target closest in range with SPACE when in attack mode?)
- [x] Faster menu actions by capital letter
- [x] Main menu world
- [x] Make numeric character switch auto-select character too
- [x] Move character selection menu and act submenu to other part of the screen to be less obtrusive
- [x] Operate only on the world's entities/components
- [x] Pause menu world
- [x] Put system list in the world
- [ ] Win screen when all enemies are dead
- [ ] Lose screen when all party is dead
- [ ] Add messages bar
- [ ] Log all actions to message bar log
- [ ] Add map overview world
- [ ] Add party world
- [ ] Allow some entities to always stay in the current world
- [ ] AoE attacks
- [ ] Better death/decay systems
- [ ] Configurable controls
- [ ] Controls as part of CES
- [ ] Custom win and lose conditions
- [ ] Fix flickering when multiple windows are open
- [ ] Main menu :: Load game
- [ ] Main menu :: Start new game
- [ ] Movement system should avoid collisions
- [ ] Options menu and options world
- [ ] Pause menu :: Save game
- [ ] Story :: "Lone Survivor" - tutorial battle
- [ ] Taking damage lowers down energy a bit

## Contributing

1. Fork it ( https://github.com/waterlink/ton/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [waterlink](https://github.com/waterlink) Oleksii Fedorov - creator, maintainer
