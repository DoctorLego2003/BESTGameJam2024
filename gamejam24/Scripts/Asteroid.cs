using System;
using System.Security.Cryptography;
using Godot;

public partial class Asteroid : Enemy
{

	public override void _Ready()
	{
		int Angle = System.Security.Cryptography.RandomNumberGenerator.GetInt32(360);
		int Distance = System.Security.Cryptography.RandomNumberGenerator.GetInt32(200) + 800;
	}

	public override void _Process(double delta)
	{
		Behavior((float)delta);
	}
	public new void Behavior(float Delta)
	{
		GlobalPosition = new Vector2
		(
			GlobalPosition.X + (Speed * MathF.Cos(MathF.Atan2(323, 577)) * Delta),
			GlobalPosition.Y + (Speed * MathF.Sin(MathF.Atan2(323, 577)) * Delta)
		);
	}
}
