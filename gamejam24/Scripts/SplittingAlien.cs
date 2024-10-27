using System;
using System.Security.Cryptography;
using Godot;

[Tool]
public partial class SplittingAlien : Enemy
{
	float Direction;
	float Amplitude;

	[Export]
	public PackedScene Children;

	public override void RandomizePosition()
	{
		float Angle = System.Security.Cryptography.RandomNumberGenerator.GetInt32(2*((int)(MathF.PI*100)))/100;
		int Distance = System.Security.Cryptography.RandomNumberGenerator.GetInt32(800) + 800;
		GlobalPosition = new Vector2(577 + Distance * MathF.Cos(Angle), 323 + Distance * MathF.Sin(Angle));
		Direction = MathF.Atan2(
				GlobalPosition.X - new Vector2(577, 323).X,
				GlobalPosition.Y - new Vector2(577, 323).Y);
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
	}

	public override void DealDamage()
	{
		GetTree().Root.GetNode("Level/ModManager").Set("HealthMod", (int)GetTree().Root.GetNode("Level/ModManager").Get("HealthMod") - 1);
	}
	
	public override void Die()
	{
		// Spawn 2 enemies
		PackedScene _Packed = GD.Load<PackedScene>(Children.ResourcePath);
		Node2D Child1 = _Packed.Instantiate<Node2D>();
		Node2D Child2 = _Packed.Instantiate<Node2D>();
		Child1.Name = "Enemy"+System.Security.Cryptography.RandomNumberGenerator.GetInt32(9999999);
		Child2.Name = "Enemy"+System.Security.Cryptography.RandomNumberGenerator.GetInt32(9999999);
		AddChild(Child1);
		AddChild(Child2);
		Child1.Reparent(GetTree().Root.GetNode("Level/Enemy"));
		Child2.Reparent(GetTree().Root.GetNode("Level/Enemy"));
		Child1.Visible = true;
		Child2.Visible = true;
		Child1.GlobalPosition = GlobalPosition - new Vector2(20, 20);
		Child2.GlobalPosition = GlobalPosition + new Vector2(20, 20);
		this.QueueFree();
	}
}
