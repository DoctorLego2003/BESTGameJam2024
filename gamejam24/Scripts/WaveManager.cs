using Godot;
using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Reflection.Metadata.Ecma335;

public partial class WaveManager : Node
{
	[Export]
	public Godot.GodotObject[] Enemies = new GodotObject[0];
	[Export]
	public int Tokens;

	[Export]
	public int SpawnRadius;

	private int _Tokens;

	public override void _Ready()
	{
		GD.Print("WaveManager Started");
		// To make it immutable
		_Tokens = Tokens;
	}

	public override void _Process(double delta)
	{

	}
}
