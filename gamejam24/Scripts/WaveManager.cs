using Godot;
using System;
using System.Collections;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection.Metadata.Ecma335;
using System.Security.Cryptography;

public partial class WaveManager : Node
{
	[Export]
	public Godot.GodotObject[] Enemies ;
	[Export]
	public int[] Tokens;

	private int[] _Tokens;

	private int CurrentWave = 0;

	public override void _Ready()
	{
		Enemy[] MappedEnemies = this.Enemies.ToList().Select(_Object => _Object.GetScript().As<Enemy>()).ToArray();
		GD.Print(MappedEnemies.Length, MappedEnemies[0]);
		_Tokens = Tokens;
		GD.Print("Available tokens: " + _Tokens[0]);
		SpawnNextWave(_Tokens[0], MappedEnemies);
	}

	public override void _Process(double delta)
	{

	}

	private void SpawnNextWave(int Credits, Enemy[] Enemies)
	{
		int RemainingTokens = Credits;
		// Filter out Enemies we can't use
		Enemy[] EnabledEnemies = Array.Empty<Enemy>();
		for (int Index = 0; Index < Enemies.Length; Index++)
		{
			GD.Print(Enemies[Index]);
			if (Enemies[Index].MinimalWave >= CurrentWave)
			{
				GD.Print("Enabled " + Enemies[Index].GetScript().AsStringName());
				EnabledEnemies.Append(Enemies[Index]);
			}
		}

		EnabledEnemies.OrderByDescending(s => s.Cost);
		foreach (Enemy _Enemy in Enemies)
		{
			int TokensToSpend = System.Security.Cryptography.RandomNumberGenerator.GetInt32(RemainingTokens);
			if (Fits(_Enemy, TokensToSpend))
			{
				int NumberToSpawn = TokensToSpend % _Enemy.Cost;
				for (int Index = 0; Index < NumberToSpawn; Index++)
				{
					AddChild(_Enemy);
					_Enemy.Name = "_Enemy_"+Index;
					_Enemy.Reparent(GetTree().Root.GetNode("Enemy"));
				}
			}
		}
	}

	private Boolean Fits(Enemy _Enemy, int RemainingTokens)
	{
		return _Enemy.Cost <= RemainingTokens;
	}
}
