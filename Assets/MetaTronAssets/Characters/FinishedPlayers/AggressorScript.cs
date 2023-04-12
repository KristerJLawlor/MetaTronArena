using System.Collections;
using System.Collections.Generic;
using UnityEngine;


public class AggressorScript : NetworkPlayerController
{
    /*
    // Start is called before the first frame update
    public GameObject[] Enemies;
    public override void HandleMessage(string flag, string value)
    {
        base.HandleMessage(flag, value);
        if(IsClient && flag == "PA")
        {
            passiveActive = bool.Parse(value);
        }
        if(IsClient && flag == "SCALAR")
        {
            DamageScalar=float.Parse(value);
            Debug.Log("Client knows it is in range");
        }
    }

    public override void NetworkedStart()
    {
        
    }
    public override IEnumerator SlowUpdate()
    {
        yield return new WaitForSeconds(.1f);
    }
    void Start()
    {
        Enemies = GameObject.FindGameObjectsWithTag("Entity");
    }

    // Update is called once per frame
    void Update()
    {
        if(IsServer)
        {
            foreach(var enemy in Enemies)
            {
                if((enemy.transform.position-transform.position).magnitude <= 5)
                {
                    passiveActive= true;
                    DamageScalar = 1.5f;
                    SendUpdate("PA", "true");
                    SendUpdate("SCALAR", DamageScalar.ToString());
                    Debug.Log("Server knows it is in range");
                }
                else
                {
                    passiveActive = false;
                    SendUpdate("PA", "false");
                }
            }
        }
    }
    */
}
