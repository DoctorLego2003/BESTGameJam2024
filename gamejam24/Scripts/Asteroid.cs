using System;
using System.Security.Cryptography;
using Godot;

[Tool]
public partial class Asteroid : Enemy
{

	float SpinSpeed;
	public override void RandomizePosition()
	{
		this.Texture = Sprite[System.Security.Cryptography.RandomNumberGenerator.GetInt32(Sprite.Length)];
		float Angle = System.Security.Cryptography.RandomNumberGenerator.GetInt32(2*((int)(MathF.PI*100)))/100;
		int Distance = System.Security.Cryptography.RandomNumberGenerator.GetInt32(800) + 800;
		GlobalPosition = new Vector2(577 + Distance * MathF.Cos(Angle), 323 + Distance * MathF.Sin(Angle));
		SpinSpeed = MathF.Pow(-1, System.Security.Cryptography.RandomNumberGenerator.GetInt32(2))*System.Security.Cryptography.RandomNumberGenerator.GetInt32(2*((int)(MathF.PI*100)))/400 + 1;
	}

	public override void _Process(double delta)
	{
		if (Engine.IsEditorHint()){return;}
		Behavior((float)delta);
	}
	public new void Behavior(float Delta)
	{
		if (GlobalPosition.DistanceTo(new Vector2(577, 323)) <= 65)
		{
			DealDamage();
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
		GlobalRotation += SpinSpeed/30;
	}

	public override void DealDamage()
	{
		GetTree().Root.GetNode("Level/ModManager").Set("HealthMod", (int)GetTree().Root.GetNode("Level/ModManager").Get("HealthMod") - 1);
	}

    public override void Die()
    {
        this.QueueFree();
    }
}
