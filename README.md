# Exercise-03a-Color-and-Particles

Exercise for MSCH-C220, 21 September 2021

A demonstration of this exercise is available at [https://youtu.be/JWgmbb1RAtc](https://youtu.be/JWgmbb1RAtc)

This exercise is the first opportunity for you to experiment with juicy features to our match-3 game. The exercise will provide you with several features that should move you towards the implementation of Project 03.

Fork this repository. When that process has completed, make sure that the top of the repository reads [your username]/Exercise-03a-Color-and-Particles. Edit the LICENSE and replace BL-MSCH-C220-F21 with your full name. Commit your changes.

Press the green "Code" button and select "Open in GitHub Desktop". Allow the browser to open (or install) GitHub Desktop. Once GitHub Desktop has loaded, you should see a window labeled "Clone a Repository" asking you for a Local Path on your computer where the project should be copied. Choose a location; make sure the Local Path ends with "Exercise-03a-Color-and-Particles" and then press the "Clone" button. GitHub Desktop will now download a copy of the repository to the location you indicated.

Open Godot. In the Project Manager, tap the "Import" button. Tap "Browse" and navigate to the repository folder. Select the project.godot file and tap "Open".

If you run the project, you will see a main menu followed by a simple match-3 game (using Godot icons as tiles). Your task will be to create new tiles for use in the game.

---

In the Assets folder are many animal-themed blocks; we will be usinga few of those in our match-3 game. The first thing we need to do is edit a piece template scene, from which the other scenes will be derived.

Open res://Pieces/Piece.tscn. You should see a (very) simple scene, with a Piece Node2D (with a script attached) and a Sprite.

The first step will be to update the sprite for the piece. Select the Sprite node. In the Inspector, replace the current Texture (the Godot icon) with one of the animal block images (for example, res://Assets/bear.png). The image is a little large for our purposes, so we will want to shrink it: Node2D->Transform->Scale = (0.5, 0.5).

Right-click on the Piece node and Add Child Node. Select Particles2D. Rename the resulting node "Selected". We will set this up momentarily.

Then right-click on the Piece node and Add Child Node. Select a Sprite. Rename the resulting Sprite node to "Select". Make sure it appears in the Scene tree after the "Selected" particle node.

## Select

Highlight "Select" in the Scene panel. In the Inspector panel, make the following changes:
 * CanvasItem->Modulate (255, 255, 0, 255)
 * Material->Material = New CanvasItemMaterial
   * Blend Mode = Add

In the Scene panel, next to the Select node, tap the eye icon to hide the node.

Edit the Piece script (res://Pieces/Piece.gd). Replace the _ready function (line 11–12) with the following:
```
func _ready():
	$Select.texture = $Sprite.texture
	$Select.scale = $Sprite.scale
```

## Particles

Next, highlight the "Selected" particle node. In the Inspector panel, make the following adjustments:

 * Particles2D->Time->Lifetime = 0.75
 * Particles2D->Textures->Texture = res://Assets/star.png
 * Particles2D->Emitting = Off
 * Particles2d->Process Material->Material = new ParticlesMaterial
   * Edit the new ParticlesMaterial:
     * Direction->Direction = (0, 0, 0)
     * Direction->Spread = 180
     * Gravity->Gravity = (0, 0, 0)
     * Initial Velocity->Velocity = 150
     * Initial Velocity->Velocity Random = 0.25
     * Orbit Velocity->Velocity = 1
     * Orvit Velocity->Velocity Random = 1
     * Scale->Scale = 0.2
     * Scale->Scale Curve->New CurveTexture
     * Curve->New Curve
       * Drop left point to 0.0
     * Color->Color Ramp->New GradientTexture
       * Gradient->New Gradient
         * Change the left point to white (255, 255, 255, 255)
         * Add a new point at the half-point of the gradient
         * Change the right point to transparent (255, 255, 255, 0) 
     * Hue Variation->Variation = 1
     * Hue Variation->Variation Random = 1

Edit the Piece script again (res://Pieces/Piece.gd). Add the following to the end of the `_physics_process` function (starting on what is now line 18):
```
	if selected:
		$Select.show()
		$Selected.emitting = true
	else:
		$Select.hide()
		$Selected.emitting = false
```

As the piece is highlighted, it should now cause the particle emitter to start up and show the Select highlighted block.

## Creating pieces

Next, we need to create derivitive scenes to serve as the tiles in our game. Under the Scene menu, select New Inherited Scene. Find and select res://Pieces/Piece.tscn. An unsaved copy of the Piece scene will now open.

In the Sprite node, replace the placeholder Texture with res://Assets/chick.png. Select the Piece node and, in the Inspector, update set the Color field = Chick. Save the scene as res://Pieces/Chick.tscn (pay attention to the capitalization, the spelling, and the file extension). Then repeat that process with the following images (Piece->Color field, and file names):
 * Duck
 * Elephant
 * Parrot
 * Sloth
 * Zebra

We are almost done. We need to tell the game to use these pieces instead of Blue, Green, and Red.
In res://Grid/grid.gd, replace lines 15–19 with the following:
```
var possible_pieces = [
	load("res://Pieces/Chick.tscn"),
	load("res://Pieces/Duck.tscn"),
	load("res://Pieces/Elephant.tscn"),
	load("res://Pieces/Parrot.tscn"),
	load("res://Pieces/Sloth.tscn"),
	load("res://Pieces/Zebra.tscn")
]
```

You can move res://Pieces/Blue.tscn, Green.tscn, and Red.tscn to the Trash, if you would like to.

Finally, go back to to the Game.tscn scene, and select the grid node. In the Inspector, you should see several exported properties. Those should be updated to the following values:
 * Width = 7
 * Height = 10
 * X Start = 82
 * Y Start = 832
 * Offset = 69

---

Test the game and make sure it is working correctly. You should be able to select tiles and see the added effects.

Quit Godot. In GitHub desktop, you should now see the updated files listed in the left panel. In the bottom of that panel, type a Summary message (something like "Completes the exercise") and press the "Commit to master" button. On the right side of the top, black panel, you should see a button labeled "Push origin". Press that now.

If you return to and refresh your GitHub repository page, you should now see your updated files with the time when they were changed.

Now edit the README.md file. When you have finished editing, commit your changes, and then turn in the URL of the main repository page (https://github.com/[username]/Exercise-03a-Color-and-Particles) on Canvas.

The final state of the file should be as follows (replacing my information with yours):
```
# Exercise-03a-Color-and-Particles

Exercise for MSCH-C220, 21 September 2021

The first steps in adding "juicy" features to a simple match-3 game.

## To play

Select and drag tiles using the mouse.


## Implementation

Built using Godot 3.3.3

## References
 * [Juice it or lose it — a talk by Martin Jonasson & Petri Purho](https://www.youtube.com/watch?v=Fy0aCDmgnxg)
 * The match-3 game is derived from code provided by [MisterTaftCreates](https://github.com/mistertaftcreates/Godot_match_3), with an accompanying [YouTube series](https://www.youtube.com/playlist?list=PL4vbr3u7UKWqwQlvwvgNcgDL1p_3hcNn2)
 * [Animal Pack Redux, provided by kenney.nl](https://kenney.nl/assets/animal-pack-redux)
 * [Puzzle Pack 2, provided by kenney.nl](https://kenney.nl/assets/puzzle-pack-2)
 * [Ignotum Typeface](https://fontesk.com/ignotum-font/)
 * [Nepszabadag Typeface](https://fontesk.com/nepszabadsag-font/)
 

## Future Development

Typeface changes, Tweening, Music and Sound, Shaders

## Created by 

Jason Francis
```
