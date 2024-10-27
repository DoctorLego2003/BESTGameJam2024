using System;
using System.Security.Cryptography;
using Godot;

[Tool]
public partial class Alien : Enemy
{
	float Direction;
	float Amplitude;

	float offset;
	public override void RandomizePosition()
	{
		float Angle = System.Security.Cryptography.RandomNumberGenerator.GetInt32(2*((int)(MathF.PI*100)))/100;
		int Distance = System.Security.Cryptography.RandomNumberGenerator.GetInt32(800) + 800;
		GlobalPosition = new Vector2(577 + Distance * MathF.Cos(Angle), 323 + Distance * MathF.Sin(Angle));
		SetDirection();
	}

    public override void _Ready()
    {
        SetDirection();
    }

    public void SetDirection(){Direction = MathF.Atan2(
				GlobalPosition.X - new Vector2(577, 323).X,
				GlobalPosition.Y - new Vector2(577, 323).Y);
				this.offset = new Godot.RandomNumberGenerator().RandiRange(0,500);}

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

		if (GlobalPosition.DistanceTo(new Vector2(577, 323)) >= 1700)
		{
			Die();
		}

		GlobalPosition -= new Vector2
		(
			Speed * MathF.Sin(this.Direction) * Delta,
			Speed * MathF.Cos(this.Direction) * Delta
		);
		GlobalPosition -= new Vector2
		(
			Speed * MathF.Cos(this.Direction) * Delta,
			-Speed * MathF.Sin(this.Direction) * Delta
		) * MathF.Sin((Time.GetTicksMsec() + offset)/200);
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
