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

- [x] Even faster character switching with numbers (1-9)
- [x] Faster menu actions by capital letter
- [ ] Make numeric character switch auto-select character too
- [ ] Faster enemy targetting (target closest in range with tab when in attack mode?)
- [ ] Move character selection menu and act submenu to other part of the screen to be less obtrusive
- [ ] Lose screen when all party is dead
- [ ] Win screen when all enemies are dead
- [ ] Add messages bar
- [ ] Log all actions to message bar log
- [ ] Add full-fledged world concept
- [ ] Put system list in the world
- [ ] Operate only on the world's entities/components
- [ ] Add map overview world
- [ ] Add battle world
- [ ] Enable world-switching
- [ ] Add party world
- [ ] Allow some entities to always stay in the current world
- [ ] Main menu world
- [ ] Main menu :: Start new game
- [ ] Pause menu world
- [ ] Pause menu :: Save game
- [ ] Main menu :: Load game
- [ ] AoE attacks
- [ ] Better death/decay systems
- [ ] Custom win and lose conditions
- [ ] Fix flickering when multiple windows are open
- [ ] Movement system should avoid collisions
- [ ] Story :: "Lone Survivor" - tutorial battle
- [ ] Controls as part of CES
- [ ] Options menu and options world
- [ ] Configurable controls

## Contributing

1. Fork it ( https://github.com/waterlink/ton/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [waterlink](https://github.com/waterlink) Oleksii Fedorov - creator, maintainer
