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

- [x] Render current movement target (as tile X?)
- [x] Fix map overview world (missing entities for relevant systems)
- [x] Limit battle and map overview world size
- [x] Add terrain both to battle and map overview
- [x] Movement system should avoid collisions
- [ ] Make path-finding smarter
- [ ] Add party world
- [ ] Extract stats (for now: DMG, MAXHP, EPRGN) as independent from character
- [ ] Allow some entities to always stay in the current world (stats, for example)
- [ ] Pause menu :: Save game
- [ ] Main menu :: Load game (Continue)
- [ ] Main menu :: Start new game
- [ ] Taking damage lowers down energy a bit
- [ ] Story :: "Lone Survivor" - tutorial battle, +one party member joins
- [ ] Dialog system - for conversations between characters and enemies, and for tutorial
- [ ] Story :: "Through the Forest" - tutorial map overview + party screen
- [ ] AoE attacks
- [ ] Story :: "Edgar the Goblin" - tutorial/challenging boss battle (shouldn't be possible to finish with 1 character, maybe add goblin healer)
- [ ] Better death/decay systems
- [ ] Custom win and lose conditions
- [ ] Fix flickering when multiple windows are open
- [ ] Options menu and options world
- [ ] Controls as part of CES
- [ ] Configurable controls

## Contributing

1. Fork it ( https://github.com/waterlink/ton/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [waterlink](https://github.com/waterlink) Oleksii Fedorov - creator, maintainer
