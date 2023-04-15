using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using NETWORK_ENGINE;


public class CloneScript : HighLevelEntity
{
    GameObject[] Players;
    public override void HandleMessage(string flag, string value)
    {
        base.HandleMessage(flag, value);
    }

    public override void NetworkedStart()
    {
        base.NetworkedStart();
        if(IsServer)
        {
            Players = GameObject.FindGameObjectsWithTag("Entity");
            OverShield = 0;
            SendUpdate("SHIELD", OverShield.ToString());
            HP = 25;
            SendUpdate("HP", HP.ToString());
        }
    }

    public override IEnumerator SlowUpdate()
    {
        base.SlowUpdate();
        while(IsServer)
        {
            foreach(var p in Players)
            {
                if(this.Owner == p.GetComponent<NetworkID>().Owner)
                {
                    continue;
                }
                if ((transform.position - p.transform.position).magnitude < 20)
                {

                }
            }
            yield return new WaitForSeconds(.1f);
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
