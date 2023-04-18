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
                    //npm.transform.GetChild(0).GetComponent<Canvas>().enabled = false;
                    npm.transform.GetChild(0).gameObject.SetActive(false);
                    Debug.Log("SETTING UI INACTIVE");

                    //Start the arena theme music
                    GameObject.FindGameObjectWithTag("NetworkManager").GetComponent<GameMusicScript>().PlayGameMusic();
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
            while (!GameStarted)
            {
                //assume players are ready until the checks prove they are not
                if (MyCore.Connections.Count > 1)
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


            //Spawn Map 
            GameObject Map = MyCore.NetCreateObject(Random.Range(8, 10), -1, Vector3.zero, Quaternion.identity);


            //Spawn Turrets in
            TurretSpawn = GameObject.FindGameObjectsWithTag("TurretSpawn");

            for (int i = 0; i < 4; i++)
            {
                GameObject temp = MyCore.NetCreateObject( 7, -1, TurretSpawn[i].transform.position, Quaternion.identity);
            }

            ChaserSpawn = GameObject.FindGameObjectsWithTag("ChaserSpawn");

            for (int i = 0; i < 4; i++)
            {
                GameObject temp = MyCore.NetCreateObject(7, -1, ChaserSpawn[i].transform.position, Quaternion.identity);
            }
            //Spawn Players in
            SpawnLoc = GameObject.FindGameObjectsWithTag("Respawn");

            foreach (NPMScript npm in GameObject.FindObjectsOfType<NPMScript>())
            {

                GameObject temp = MyCore.NetCreateObject(npm.ClassSelected, npm.Owner, SpawnLoc[npm.Owner].transform.position, Quaternion.identity);
                NetworkPlayerController pc = temp.GetComponent<NetworkPlayerController>();
                pc.pname = npm.PName;
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
        yield return new WaitForSeconds(900);

        StartCoroutine(MyCore.DisconnectServer());
    }

    public IEnumerator TenSecTimer()
    {
        yield return new WaitForSeconds(890);
        GameObject.FindGameObjectWithTag("NetworkManager").GetComponent<TimerAudio>().PlayTimerAudio();

    }

}
