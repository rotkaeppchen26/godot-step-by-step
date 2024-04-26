# Concepts

Godot is heavily tailored towards an Object-Oriented approach.

Nodes are the engine's basic structure and will contain the game's logic.

Scenes are Trees of Nodes.

Signals, essentially an implementation of the Observer pattern, facilitate communication between Nodes (without requiring too tight coupling?).

The Game, in the end, will be composed of a tree of Scenes.

https://docs.godotengine.org/en/stable/getting_started/step_by_step/instancing.html#scene-instances-as-a-design-language

https://docs.godotengine.org/en/stable/getting_started/step_by_step/signals.html#custom-signals
