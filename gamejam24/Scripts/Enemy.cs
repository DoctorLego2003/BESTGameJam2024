using Godot;

public abstract partial class Enemy : Node
{
	[Export]
	public int Cost {get;set;}
	[Export]
	public int Health {get;set;}
	[Export]
	public int Damage {get;set;}
	[Export]
	public int Speed {get;set;}
	[Export]
	public GodotObject Sprite {get;set;}

	public void Behavior()
	{
		GD.PrintErr("Unreachable code somehow reached");
	}

	public void TakeDamage(int Damage)
	{
		Health -= Damage;
	}

	public void Die()
	{
		this.QueueFree();
	}
}
