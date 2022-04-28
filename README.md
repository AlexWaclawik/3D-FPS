## 3D First Person Shooter

This game is a 3D first person shooter in which you control a character and shoot enemies that chase you. It has been made using the Godot Game Engine.

<p align="right"></p>

### Installation

1. [Download the latest release](https://github.com/AlexWaclawik/3D-FPS/releases).
2. Unzip the contents and run the executable
3. Enjoy

<p align="right"></p>

### Design

**Player**
The Player object is used a basic capsule mesh for physics collision, with a head being on top. Attached to the head is a camera and a raycast extending outward. The raycast is used for hitscan aiming. Lastly, a gun model is attached, and is positioned in the bottom center of the viewport.
- The player controller is a slightly modified version of a script which emulates Quake-style movement (continuous acceleration, air control, bunnyhopping, etc). In general, it works by seperating movement into two states: on the ground and in the air. During the physics pass, it will first check if a jump is queued by seeing if the jump key is being pressed, and then setting a boolean to True or False. It then checks if the player is on the ground or in the air, and call the respective function for each state, and regardless of the state it will also perform a move and slide. This part is important as it allows for the player's velocity to be maintained in the air and on the ground, which is what gives it the fast "Quake-style" feel.
	* While on the ground, the function first checks if a jump is queued. If yes then zero friction is applied, otherwise a friction of *1.0* is applied. It then calculates the desired movement direction as a combination of the forward and back along with left and right inputs. These are calculated as components called *wishdir* and *wishspeed*, and are passed into an acceleration function along with the player's constant run acceleration. Then the player's y-axis velocity is reset to zero, and a final check for a queued jump is made. If yes, then the player's y-axis velocity is set to the constant jump speed. Otherwise the function ends.
	* The in the air function operates in much the same way, except there is no check for a queued jump. Instead the function checks if the input direction is less than zero. If yes it deaccelerates the player and if no, it accelerates the player. This creates the ability for slight mid air movement, as well as the ability to increase your speed by "strafing" forward and left/right. This is because two positive directional inputs will result in a higher calculated acceleration.
- Health is kept as a variable and initialized to "500." An area node and cylinder mesh are used as the hitbox of the player. Upon an enemy entering the area node, a signal is called to a function in "Player.gd" where 100 health is subtracted from the total pool. Everytime damage is taken, a sound effect is played. Each level of health has a corresponding sound effect (500, 400, etc), concluding at 0 when the player dies.
- A basic user interface is present that displays the Player's current health and score. The score is just simply the number of succesful hits the player gets.

**Enemy**
The Enemy object is the obstacle of the game, as it continously spawns and chased you down. It consists of a simple capsule mesh with small black eyes, which gives it an either disturbing or cute appearence depending on the individual. The object spawns in one of the corners every half a second, and a maximum of eight can be present at one time.
- Upon spawning, the Enemy moves itself to the included start position and looks at the player. It then calculates it's own velocity which is based on a random speed between 12 and 18. During every physics pass, the Enemy will get the player's position, look at the player, get the direction to the player, then move towards them.
- The Enemy has 200 health, which means the Player's 100 damage kills it in two succesful hits. Every process pass, the Enemy checks if it's health is at or below zero. If it is, then the Enemy decrements from the total enemy counter, then removes itself.

**Depreciated Assets**
Two assets are included but are not functional, as I could not resolve issues in their implementation.
- I constructed a large arena with multiple floors and platforms, but could not figure out how to get the Enemies to navigate it properly. They kept getting stuck on the sloped areas, as well as had difficulty handling the elevation changes. I ultimately decided to use a simpler plane, but I still kept this in as I spent a fair amount of time working on the model.
- The second asset is a muzzle flash for the weapon. I constructed a basic mesh and used a flash texture listed below. While the model and animation worked fine, the actual spawning and playing of the animation did not. Upon firing, the player script calls a function to play the animation at a specific location, after which it disappears. However even though I lined up the muzzle flash in the editor with the viewport perspective, in-game it is completely wrong and does not display correctly. Like the large arena, time limitations caused me to complete the project without the asset.

<p align="right"></p>

### Credits

* The arena and weapon meshes were made by me in Blender and are included in the *../Models* folder. The other simpler meshes were constructed in Godot. 
* [Quake 3 Movement by Raymond Hulha](https://github.com/rhulha/quake3-movement-godot)
* Credit to my friend Andrew Lyons for providing the various voice lines heard in the game.

All resources listed below are obtained from https://opengameart.org, and are under a Creative Commons
or GNU General Public License that provides permission for their use in this game.

Individual Credits:
1. [Muzzle Flash Texture & Model](https://opengameart.org/content/muzzle-flash-with-model)
2. [Weapon Sounds](https://opengameart.org/content/chaingun-pistol-rifle-shotgun-shots)
3. [Floor Tile Texture](https://opengameart.org/content/dirty-quake-ish-floor-tiles)
4. [Crate & Door Textures](https://opengameart.org/content/doors-crates-low-res)
5. [Crosshairs & Reticles](https://opengameart.org/content/crosshairs-and-reticles)

