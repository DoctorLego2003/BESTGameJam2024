using System;
using Godot;

public partial class Asteroid : Enemy
{

	public override void _Ready()
	{
	}

	public override void _Process(double delta) {Behavior((float)delta);}
	public new void Behavior(float Delta)
	{
		GD.Print(new Vector2
		(
			GlobalPosition.X + (Speed * MathF.Atan2(577, 323) * Delta),
			GlobalPosition.Y
		));
	}
}
