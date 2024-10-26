using System;
using System.Security.Cryptography;
using Godot;

public partial class Asteroid : Enemy
{

	public override void _Ready()
	{
		float Angle = System.Security.Cryptography.RandomNumberGenerator.GetInt32(2*((int)(MathF.PI*100)))/100;
		int Distance = System.Security.Cryptography.RandomNumberGenerator.GetInt32(200) + 800;
		GlobalPosition = new Vector2(577 + Distance * MathF.Cos(Angle), 323 + Distance * MathF.Sin(Angle));
	}

	public override void _Process(double delta)
	{
		Behavior((float)delta);
	}
	public new void Behavior(float Delta)
	{
		if (GlobalPosition.DistanceTo(new Vector2(577, 323)) <= 65)
		{
			Die();
		}
		GlobalPosition -= new Vector2
		(
			Speed * MathF.Sin(MathF.Atan2(
				GlobalPosition.X - new Vector2(577, 323).X,
				GlobalPosition.Y - new Vector2(577, 323).Y 
				)) * Delta,
			Speed * MathF.Cos(MathF.Atan2(
				GlobalPosition.X - new Vector2(577, 323).X,
				GlobalPosition.Y - new Vector2(577, 323).Y
				)) * Delta
		);
	}
}
