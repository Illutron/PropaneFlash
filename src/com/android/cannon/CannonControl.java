package com.android.cannon;

import java.io.IOException;

import com.android.server.Server;

import android.app.Activity;
import android.util.Log;

public class CannonControl extends Activity
{
	/**
	 * Called when the activity is first created.
	 */	
	Server server = null;
	
	public void connection()
	{	
		server = new Server(4567);
		
		try
		{
			server.start();
		} catch (IOException e)
		{
			Log.e("microbridge", "Unable to start TCP server", e);
			System.exit(-1);
		}

	}
	public void shoot()
	{
		try
		{
			server.send(new byte[] { (byte)1 });
		} catch (IOException e)
		{
			Log.e("microbridge", "problem sending TCP message", e);
		}	
	}
}