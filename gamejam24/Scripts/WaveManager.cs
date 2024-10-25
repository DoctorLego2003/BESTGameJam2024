using Godot;
using System;
using System.Reflection.Metadata.Ecma335;

public partial class WaveManager : Node
{
	[Export]
	public Godot.GodotObject Asteroid;
	[Export]
	public int Tokens;

	private int _Tokens;

	public override void _Ready()
	{
		// To make it immutable
		_Tokens = Tokens;
		
	}

	public override void _Process(double delta)
	{

	}
}
