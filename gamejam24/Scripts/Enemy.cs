using Godot;

[Tool]
public abstract partial class Enemy : Sprite2D
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
	public Texture2D[] Sprite {get;set;}
	[Export]
	public int MinimalWave {get;set;}
	[Export]
	public int ScrapReward {get;set;}

	public void Behavior(float Delta)
	{
		GD.PrintErr("Unreachable code somehow reached");
	}

	public void TakeDamage(int Damage)
	{
		Health -= Damage;
		if (Health <= 0){
			GetTree().Root.GetNode("Level/ModManager").Set("Money", (int)GetTree().Root.GetNode("Level/ModManager").Get("Money") + ScrapReward);
			Die();
			}
	}

	public abstract void DealDamage();

	public abstract void Die();

	public abstract void RandomizePosition();
}
