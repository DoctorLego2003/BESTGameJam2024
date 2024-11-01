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
	public PackedScene[] Enemies;
	[Export]
	public int[] Tokens;

	private List<Enemy> ScriptEnemies = new List<Enemy>();

	[Signal]
	public delegate void WaveEndedEventHandler();

	public int CurrentWave = 0;

	public int GetCurrentWave()
	{
		return CurrentWave +1;
	}

	public override void _Ready()
	{
		this.Tokens = new int[10000];
		for (int Index =0 ; Index<10000; Index++)
		{
			Tokens[Index] = (int)MathF.Pow((Index + 1), 2);
		}
		// Unpack all of the Enemies under me and pause them
		foreach (PackedScene PackedEnemy in Enemies)
		{
			PackedScene _Packed = GD.Load<PackedScene>(PackedEnemy.ResourcePath);
			GD.Print("Found Packed Enemy: " + PackedEnemy.ResourcePath);
			Node2D ExtractedEnemy = _Packed.Instantiate<Node2D>();
			AddChild(ExtractedEnemy);
			GD.Print("	-> Instantiated to " + ExtractedEnemy.GetPath());
			ExtractedEnemy.Reparent(this);
			GD.Print("	-> Moved to me");
			ExtractedEnemy.Name+="_Unpack";
			GD.Print("	-> Renamed to "+ExtractedEnemy.Name);
			ExtractedEnemy.Visible = false;
			GD.Print("	-> Made Invisible");
			ExtractedEnemy.ProcessMode = ProcessModeEnum.Disabled;
			GD.Print("	-> Stopped Enemy");
		}
		GD.Print("Done Extracting");

		// Remap the Extracted Enemies to Enemies
		foreach (Node2D ExtractedEnemy in this.GetChildren())
		{
			GD.Print("Scripts on " + ExtractedEnemy.GetPath()+ ": " + (Enemy)ExtractedEnemy);
			ScriptEnemies.Add((Enemy)ExtractedEnemy);
			GD.Print("Added to ScriptEnemiesArray: " + this.ScriptEnemies.ToString());
		}
		GD.Print("Length: " + ScriptEnemies.Count);

		if (Tokens.Length < CurrentWave){GD.Print("No Waves Left!");GetTree().Quit();}
		GD.Print("Available tokens: " + Tokens[CurrentWave]);
		SpawnNextWave(Tokens[CurrentWave], this.ScriptEnemies.ToArray());

	}

	public void ContinuePressedInCardGenerator()
	{
		GD.Print("Starting Next Wave");
		SpawnNextWave(Tokens[CurrentWave], this.ScriptEnemies.ToArray());
	}

	private async void SpawnNextWave(int Credits, Enemy[] Enemies)
	{
		int RemainingTokens = Credits;
		// Filter out Enemies we can't use
		Enemy[] EnabledEnemies = Array.Empty<Enemy>();
		for (int Index = 0; Index < Enemies.Length; Index++)
		{
			if (Enemies[Index].MinimalWave <= CurrentWave)
			{
				GD.Print("Enabled " + Enemies[Index]);
				EnabledEnemies = EnabledEnemies.Append(Enemies[Index]).ToArray();
			}
		}
		GD.Print("Enabled "+ EnabledEnemies.Length +" enemies");

		// Sort the enemies by cost to prevent the expensive ones from hogging all of the tokens
		EnabledEnemies.OrderByDescending(s => s.Cost);
		GD.Print("Sorted Enemies by Cost");

		// Add Enemies as long as we have tokens
		for (int Limiter = 100; RemainingTokens > 0 && Limiter > 0; Limiter--)
		{
			GD.Print("Remaining Tokens: " + RemainingTokens);
			foreach (Enemy _Enemy in EnabledEnemies)
			// Iterate over all of the enemies to decide what to spawn
			{
				GD.Print(_Enemy.Name);
				// Randomly decide how many credits to spend on this enemy
				int TokensToSpend = new Godot.RandomNumberGenerator().RandiRange(0, RemainingTokens);
				GD.Print("	Willing to spend "+TokensToSpend+" Tokens");
				GD.Print("	Fits: " + Fits(_Enemy, TokensToSpend));
				// Spawn as many of the enemies as we can with how many credits we're willing to spend on them
				if (Fits(_Enemy, TokensToSpend))
				{
					int NumberToSpawn = TokensToSpend / _Enemy.Cost;
					GD.Print("	Going to add "+NumberToSpawn+" Enemies");
					for (int Index = 0; Index < NumberToSpawn; Index++)
					{
						Enemy TMPENEMY = (Enemy)_Enemy.Duplicate();
						GD.Print("	"+  TMPENEMY.Name);
						AddChild(TMPENEMY);
						TMPENEMY.Reparent(GetTree().Root.GetNode("Level").GetNode("Enemy"));
						// Prevent Overlap
						TMPENEMY.Name = "_Enemy_"+Index + "_" + System.Security.Cryptography.RandomNumberGenerator.GetInt32(99999999);
						TMPENEMY.RandomizePosition();
						TMPENEMY.Visible=true;
						TMPENEMY.ProcessMode=ProcessModeEnum.Inherit;
						GD.Print("	Added Enemy at " + TMPENEMY.GetPath() + " with coords " + TMPENEMY.GlobalPosition);
						GetParent().GetNode("Enemy").GetTree().Paused = true;
						RemainingTokens -= _Enemy.Cost;
					}
				}
			}
		}
		// Wait for all of the enemies to die :)
		while (GetTree().Root.GetNode("Level").GetNode("Enemy").GetChildren().Count != 0)
		{
			await ToSignal(GetTree().CreateTimer(0.1), "timeout");
		}
		// Emit the WaveEnded signal
		GD.Print("Emitting WaveEndedSignal");
		EmitSignal(SignalName.WaveEnded);
		this.CurrentWave++;
	}

	private Boolean Fits(Enemy _Enemy, int RemainingTokens)
	{
		return _Enemy.Cost <= RemainingTokens;
	}
}

/***
[
	{
		"name": "RefCounted",
		"class_name": &"",
		"type": 0, "hint": 0,
		"hint_string": "RefCounted",
		"usage": 128
	},
	{
		"name": "Resource",
		"class_name": &"",
		"type": 0,
		"hint": 0,
		"hint_string": "Resource",
		"usage": 128
	},
	{
		"name": "Resource",
		"class_name": &"",
		"type": 0,
		"hint": 0,
		"hint_string": "resource_",
		"usage": 64
		},
		{
			"name": "resource_local_to_scene",
			"class_name": &"",
			"type": 1,
			"hint": 0,
			"hint_string": "",
			"usage": 6\
		},
		{
			"name": "resource_path",
			"class_name": &"",
			"type": 4,
			"hint": 0,
			"hint_string": "",
			"usage": 4
		},
		{
			"name": "resource_name",
			"class_name": &"",
			"type": 4,
			"hint": 0,
			"hint_string": "",
			"usage": 6
		},
		{
			"name": "resource_scene_unique_id",
			"class_name": &"",
			"type": 4,
			"hint": 0,
			"hint_string": "",
			"usage": 0
		},
		{
			"name": "PackedScene",
			"class_name": &"",
			"type": 0,
			"hint": 0,
			"hint_string": "PackedScene", "usage": 128 }, { "name": "_bundled", "class_name": &"", "type": 27, "hint": 0, "hint_string": "", "usage": 6 }, { "name": "script", "class_name": &"Script", "type": 24, "hint": 17, "hint_string": "Script", "usage": 1048582 }]
***/
