using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using NETWORK_ENGINE;

public class GameMasterScript : NetworkComponent
{
    public bool GameStarted = false;

    public GameObject[] SpawnLoc;
    public override void HandleMessage(string flag, string value)
    {
        //will only affect clientside
        if (flag == "GAMESTART")
        {
            GameStarted = true;
            foreach (NPMScript npm in GameObject.FindObjectsOfType<NPMScript>())
            {
                //disable lobby UI
                npm.transform.GetChild(0).gameObject.SetActive(false);
            }
        }
    }

    public override void NetworkedStart()
    {
        SpawnLoc = GameObject.FindGameObjectsWithTag("Respawn");
    }

    public override IEnumerator SlowUpdate()
    {
        while (!GameStarted && IsServer)
        {
            //assume players are ready until the checks prove they are not
            bool readyGo = true;
            int count = 0;
            foreach (NPMScript npm in GameObject.FindObjectsOfType<NPMScript>())
            {
                if (!npm.IsReady)
                {
                    readyGo = false;
                    break;
                }
                count++;
            }
            if (count < 1)
            {
                readyGo = false;
            }
            GameStarted = readyGo;

            yield return new WaitForSeconds(.1f);
        }

        if (IsServer)
        {
            SendUpdate("GAMESTART", GameStarted.ToString());
            Debug.Log("Sending Update GameStart");

            foreach (NPMScript npm in GameObject.FindObjectsOfType<NPMScript>())
            {

                GameObject temp = MyCore.NetCreateObject(npm.ClassSelected, npm.Owner, SpawnLoc[npm.Owner].transform.position, Quaternion.identity);
            }

        }

        while (IsServer)
        {
            if (IsDirty)
            {
                SendUpdate("GAMESTART", GameStarted.ToString());
                IsDirty = false;
            }
            //delay by 5 seconds
            yield return new WaitForSeconds(5);
        }
    }

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
