## 3D First Person Shooter

This game is a 3D first person shooter in which you control a character and shoot enemies that chase you. It has been made using the Godot Game Engine.

<p align="right"></p>

### Installation

1. [Download the latest release](https://github.com/AlexWaclawik/3D-FPS/releases).
2. Unzip the contents and run the executable
3. Enjoy!

<p align="right"></p>

### Design

**Player**
- The Player object uses a basic capsule mesh for physics collision. A head is mounted to the top, and attached is a camera, 
a raycast used for hitscan aiming, and a gun model positioned in the bottom center of the viewport.
	1. The player controller is a slightly modified version of a script which emulates Quake-style movement 
	(continuous acceleration, air control, strafing, bunnyhopping, etc). In general it works by seperating movement into two key 
	states: on the ground and in the air. During the physics pass, it will first check if a jump is queued by seeing if the jump key 
	is being pressed, and then setting a corresponding boolean to True or False. Then it checks if the player is on the ground or in the air, 
	and calls the respective function for the given state. Lastly it will perform a move and slide with the player velocity.
		* "On the Ground" Function: First checks if a jump is queued. If yes then a friction of *0.0* is applied, otherwise a friction of *1.0* is applied. Then it calculates the desired movement direction as a combination of the forward and back along with left and right inputs. These are calculated as components called *wishdir* and *wishspeed*, and are passed into an acceleration function along with the player's constant run acceleration. Then the player's y-axis velocity is reset to zero, and a final check for a queued jump is made. If yes, then the player's y-axis velocity is set to the constant jump speed. Otherwise the function ends.
		* "In the Air" Function: Operates similarly, except there is no check for a queued jump. Instead the function checks if the desired input direction is less than zero. If yes it deaccelerates the player and if no, it accelerates the player. Not only does this allow for air control, but also the ability to increase your speed by strafing "forward+left" and "forward+right."
	2. Health is kept as a variable and initialized to *500*. An area node and cylinder mesh are used to represent the hitbox of the player. 
	When an enemy enters the area node, a signal is called to a function in where *100* health is subtracted from the 
	total. Everytime damage is taken a sound effect is played, and each level of health has a corresponding sound effect 
	(500, 400, 300, 200, 100, 0).
	3. A basic user interface is present that displays the Player's current health and score. The score is just the number of succesful hits the player gets.

**Enemy**
- The Enemy object is the obstacle of the game, as it continously spawns and chased the player down. It consists of a simple capsule mesh with small black eyes, which gives it an either disturbing or cute appearence depending on who you ask. The object spawns in one of the corners every half a second, and a maximum of eight can be present at one time.
	1. Upon spawning, the Enemy moves itself to the start position and looks at the player. It then calculates it's own velocity which is based on a random speed between 12 and 18. During every physics pass, the Enemy will get the player's position, look at the player, get the direction to the player, then move towards them.
	2. The Enemy has *200* health, which means the Player's *100* damage kills it in two succesful hits. Every process pass, the Enemy checks if it's health is at or below zero. If it is, then the Enemy decrements from the total enemy counter, then frees itself.

**Depreciated Assets**
- Two assets are included but are not functional, as I could not resolve issues in their implementation.
	1. Firstly, I constructed a large arena with multiple floors and platforms, but could not figure out how to get the enemies to navigate it properly. They kept getting stuck on the sloped areas and had difficulty handling the elevation changes. I ended up using a simpler flat area, but I still kept this in as I spent a fair amount of time working on the model.
	2. The second asset is a muzzle flash for the weapon. I constructed a basic mesh and used the flash texture listed below. While the model and animation worked fine, the actual spawning and playing of the animation did not. Upon firing, the player script calls a function to play the animation at a specific location, after which it disappears. Even though I lined up the muzzle flash in the editor with the viewport perspective, it is completely wrong in-game and does not display correctly. Like the large arena, time limitations caused me to complete the project without the asset.

<p align="right"></p>

### Credits

1. The arena and weapon meshes were made by me in Blender and are included in the *../Models* folder. The other simpler meshes were constructed in Godot. 
2. [Quake 3 Movement by Raymond Hulha](https://github.com/rhulha/quake3-movement-godot)
3. Credit to my friend Andrew Lyons for providing the various voice lines heard in the game.

All resources listed below are obtained from https://opengameart.org, and are under a Creative Commons
or GNU General Public License that provides permission for their use.

1. [Muzzle Flash Texture & Model](https://opengameart.org/content/muzzle-flash-with-model)
2. [Weapon Sounds](https://opengameart.org/content/chaingun-pistol-rifle-shotgun-shots)
3. [Floor Tile Texture](https://opengameart.org/content/dirty-quake-ish-floor-tiles)
4. [Crate & Door Textures](https://opengameart.org/content/doors-crates-low-res)
5. [Crosshairs & Reticles](https://opengameart.org/content/crosshairs-and-reticles)

