using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

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
        if(IsServer && flag == "SPRINT")
        {
            AbilityinUse=bool.Parse(value);
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
                    break;
                }

            }
            SendUpdate("PA", passiveActive.ToString());
            if (AbilityinUse && AbilityCharge>0)
            {
                AbilityCharge = AbilityCharge - 3;
                speed = 10;
                SendUpdate("ACHARGE", AbilityCharge.ToString());
            }
            else
            {
                speed = 5;
                AbilityinUse= false;
            }
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
    public void Sprint(InputAction.CallbackContext sp)
    {
        if (IsLocalPlayer)
        {
            if(sp.started)
            {
                if (AbilityCharge > 0)
                {
                    SendCommand("SPRINT", "true");
                }
            }
            if(sp.canceled)
            {
                SendCommand("SPRINT", "false");
            }
        }
    }
}
