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
            
        }
        if(IsClient && flag == "SCALAR")
        {
            DamageScalar=float.Parse(value);
            
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
            passiveActive = false;
            foreach (var entity in Entity)
            {
                if (entity.gameObject == this.gameObject)
                {
                    continue;
                }
                if ((entity.transform.position - this.transform.position).magnitude < 15)
                {
                    passiveActive = true;
                    Debug.Log(entity.transform.name);
                    break;
                }

            }
            SendUpdate("PA", passiveActive.ToString());
        }
    }
    public override float OnDamage(float d, GameObject o)
    {
        if (passiveActive)
        {
            return d * 1.5f;
        }
        return d;
        
       
      
    }
}
