using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AggresorScript : NetworkPlayerController
{
    // Start is called before the first frame update
    public GameObject[] Entity;
    public override void HandleMessage(string flag, string value)
    {
        base.HandleMessage(flag, value);
        if(IsClient && flag == "PA")
        {
            passiveActive=bool.Parse(value);
            Debug.Log("In client passive handle message");
        }
        if(IsClient && flag == "SCALAR")
        {
            DamageScalar=float.Parse(value);
            Debug.Log("In client scalar handle message");
        }
    }
    public override void NetworkedStart()
    {
        base.NetworkedStart();
    }
    public override IEnumerator SlowUpdate()
    {
        return base.SlowUpdate();
    }
    void Start()
    {
        base.Start();
        Entity = GameObject.FindGameObjectsWithTag("Entity");

    }

    // Update is called once per frame
    void Update()
    {
        base.Update();
        if (IsServer)
        {
            foreach (var entity in Entity)
            {
                if (entity != this && (entity.transform.position - transform.position).magnitude < 5)
                {
                    passiveActive = true;
                    DamageScalar = 1.5f;
                    SendUpdate("PA", "true");
                    SendUpdate("SCALAR", DamageScalar.ToString());
                    Debug.Log("Server knows entity is in range");
                }
                else
                {
                    passiveActive = false;
                    DamageScalar = 1;
                    SendUpdate("SCALAR", DamageScalar.ToString());
                    SendUpdate("PA", "false");
                }
            }
        }
    }
}
