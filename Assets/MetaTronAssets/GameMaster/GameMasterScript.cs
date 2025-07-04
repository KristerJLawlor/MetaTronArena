using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using NETWORK_ENGINE;

public class GameMasterScript : NetworkComponent
{
    public bool GameStarted = false;

    public GameObject[] SpawnLoc;
    public GameObject[] TurretSpawn;
    public GameObject[] ChaserSpawn;
    public override void HandleMessage(string flag, string value)
    {
        //will only affect clientside
        if (flag == "GAMESTART")
        {
            Debug.Log("In handlemessage for GAMESTART");
            GameStarted = bool.Parse(value);
            if (GameStarted && IsClient)
            {
                foreach (NPMScript npm in GameObject.FindObjectsOfType<NPMScript>())
                {
                    //disable lobby UI
                    npm.transform.GetChild(0).GetComponent<Canvas>().enabled = false;
                    if(npm.transform.GetChild(0) != null)
                    {
                        npm.transform.GetChild(0).gameObject.SetActive(false);
                        Debug.Log("SETTING UI INACTIVE");
                    }
                    //Start the arena theme music
                    GameObject.Find("WANNetworkManager").GetComponent<GameMusicScript>().PlayGameMusic();
                    Debug.Log("STARTING GAME MUSIC");
                }
            }
        }
    }

    public override void NetworkedStart()
    {
        SpawnLoc = GameObject.FindGameObjectsWithTag("Respawn");
    }

    public override IEnumerator SlowUpdate()
    {
        if (IsServer)
        {
            /*
            while (!GameStarted)
            {
                //assume players are ready until the checks prove they are not
                if (GameObject.FindObjectsOfType<NPMScript>().Length > 1)
                {

                    GameStarted = true;
                    foreach (NPMScript npm in GameObject.FindObjectsOfType<NPMScript>())
                    {
                        
                        if (!npm.IsReady)
                        {
                            GameStarted = false;
                            break;
                        }
                    }
                    
                }
                yield return new WaitForSeconds(.1f);
            }
            */

            NPMScript[] players = FindObjectsOfType<NPMScript>();
            while (!GameStarted)
            {
                players = FindObjectsOfType<NPMScript>();
                //if(MyCore.Connections.Count> 0)
                if (players.Length > 1)
                {
                    GameStarted = true;
                    foreach (NPMScript p in players)
                    {
                        if (!p.IsReady)
                        {
                            GameStarted = false;
                            break;
                        }
                    }
                }
                yield return new WaitForSeconds(.1f);
            }

            //This code will remove the game room from the lobby.
            //And prevent people from joining the game once it starts.
            if (FindObjectOfType<LobbyManager>() != null)
            {
                FindObjectOfType<LobbyManager>().NotifyGameStarted();
            }
            MyCore.StopListening();
            //End of code snippit.

            //Spawn Map 
            GameObject Map = MyCore.NetCreateObject(Random.Range(8, 10), -1, Vector3.zero, Quaternion.identity);


            //Spawn Turrets in
            TurretSpawn = GameObject.FindGameObjectsWithTag("TurretSpawn");

            for (int i = 0; i < 4; i++)
            {
                GameObject temp = MyCore.NetCreateObject( 7, -1, TurretSpawn[i].transform.position, Quaternion.identity);
            }

            //ChaserSpawn = GameObject.FindGameObjectsWithTag("ChaserSpawn");
            ChaserSpawn = TurretSpawn;

            for (int i = 0; i < 4; i++)
            {
                GameObject temp = MyCore.NetCreateObject(11, -1, ChaserSpawn[i].transform.position + new Vector3(3, 0, 3), Quaternion.identity);
            }
            //Spawn Players in
            SpawnLoc = GameObject.FindGameObjectsWithTag("Respawn");

            foreach (NPMScript npm in GameObject.FindObjectsOfType<NPMScript>())
            {

                GameObject temp = MyCore.NetCreateObject(npm.ClassSelected, npm.Owner, SpawnLoc[npm.Owner].transform.position, Quaternion.identity);
                NetworkPlayerController pc = temp.GetComponent<NetworkPlayerController>();
                pc.pname = npm.PName;
                Debug.Log(npm.PName);
            }


            SendUpdate("GAMESTART", GameStarted.ToString());
        }
        if (GameStarted)
        {
            StartCoroutine(Playing());
            StartCoroutine(TenSecTimer());
        }
    }

    // Start is called before the first frame update
    void Start()
    {
        
    }

    public IEnumerator Playing()
    {
        yield return new WaitForSeconds(615);

        //StartCoroutine(MyCore.DisconnectServer());
        MyCore.UI_Quit();
    }

    public IEnumerator TenSecTimer()
    {
        yield return new WaitForSeconds(590);
        GameObject.FindGameObjectWithTag("NetworkManager").GetComponent<TimerAudio>().PlayTimerAudio();

    }

}
