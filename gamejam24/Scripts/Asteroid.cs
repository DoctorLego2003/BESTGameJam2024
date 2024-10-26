using System;
using System.Security.Cryptography;
using Godot;

public partial class Asteroid : Enemy
{

	public override void _Ready()
	{
		float Angle = System.Security.Cryptography.RandomNumberGenerator.GetInt32(2*((int)(MathF.PI*100)))/100;
		int Distance = System.Security.Cryptography.RandomNumberGenerator.GetInt32(1) + 200;
		GlobalPosition = new Vector2(Distance * MathF.Cos(Angle), Distance * MathF.Sin(Angle));
	}

	public override void _Process(double delta)
	{
		Behavior((float)delta);
	}
	public new void Behavior(float Delta)
	{
		GlobalPosition += new Vector2
		(
			Speed * MathF.Cos(MathF.Atan2(
				new Vector2(323, 577).X - GlobalPosition.X,
				new Vector2(323, 577).Y - GlobalPosition.Y
				)) * Delta,
			Speed * MathF.Sin(MathF.Atan2(
				new Vector2(323, 577).X - GlobalPosition.X,
				new Vector2(323, 577).Y - GlobalPosition.Y
				)) * Delta
		);
		GD.Print(GlobalPosition);
	}
}
