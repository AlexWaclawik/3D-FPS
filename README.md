## 3D First Person Shooter

This game is a 3D first person shooter in which you control a character and shoot red enemies that chase you. It has been made using the Godot Game Engine.

<p align="right"></p>

### Installation

1. [Download the latest release](https://github.com/AlexWaclawik/3D-FPS/releases).
2. Unzip the contents and run the executable
3. Enjoy

<p align="right"></p>

### Design

**Player**
- The player consists of a capsule for collosion detection, with the head being on top. Attached to
the head is a camera and a raycast extending outward. The raycast is used for hitscan aiming. Lastly, a
gun model is attached, and is centered.
- The player controller is built off a script that emulates Quake-style movement (fast, air control, bunnyhopping, etc).
I also added functionality for a bit of weapon sway that corresponds to mouse movements. 

**Enemy**
- The enemy is a basic capsule entity. It spawns along the upper part of the arena and then travels
toward the player. A maxiumum of eight enemies can be spawned at once, and they spawn at a rate of once
every five seconds.

<p align="right"></p>

### Credits

* [Quake 3 Movement by Raymond Hulha](https://github.com/rhulha/quake3-movement-godot)
* [Cel Shader by DaveTheDev](https://github.com/EXPWorlds/Godot-Cel-Shader)

Credit to my friend Andrew Lyons for providing the various voice lines heard in the game.

All assets listed below are obtained from https://opengameart.org, and are under a Creative Commons
or GNU General Public License that provides permission for their use in this game.

Individual Credits:
1. [Cyberpunk Moonlight Sonata](https://opengameart.org/content/cyberpunk-moonlight-sonata)
2. [Muzzle Flash Texture & Model](https://opengameart.org/content/muzzle-flash-with-model)
3. [Weapon Sounds](https://opengameart.org/content/chaingun-pistol-rifle-shotgun-shots)
4. [Floor Tile Texture](https://opengameart.org/content/dirty-quake-ish-floor-tiles)
5. [Crate & Door Textures](https://opengameart.org/content/doors-crates-low-res)
6. [Weapon Models](https://opengameart.org/content/oldschool-afps-weapons)
7. [Crosshairs & Reticles](https://opengameart.org/content/crosshairs-and-reticles)
8. [FPS Weapon Sprites](https://opengameart.org/content/fps-weapon-sprites)


