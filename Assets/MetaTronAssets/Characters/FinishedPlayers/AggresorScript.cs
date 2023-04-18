using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class AggresorScript : NetworkPlayerController
{
    // Start is called before the first frame update
    public GameObject[] Entity;
    public bool SuperinUse = false;
    public override void HandleMessage(string flag, string value)
    {
        base.HandleMessage(flag, value);
        if(IsClient && flag == "PA")
        {
            passiveActive=bool.Parse(value);
            
        }
        if (IsClient && flag == "OH")
        {
            Overheat=float.Parse(value);
        }
        if(IsClient && flag == "SCHARGE")
        {
            SuperCharge=int.Parse(value);
        }
        if(IsServer && flag == "SPRINT")
        {
            AbilityinUse=bool.Parse(value);
        }
        if(IsServer && flag == "RAGE")
        {
            SuperinUse = true;
            StartCoroutine(endRage());
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
            if (AbilityinUse && AbilityCharge<maxCharge)
            {
                AbilityCharge = AbilityCharge + 3;
                speed = 10;
                SendUpdate("ACHARGE", AbilityCharge.ToString());
            }
            else
            {
                speed = 5;
                AbilityinUse= false;
            }
            if(SuperinUse)
            {
                Overheat = 0;
                SendUpdate("OH", Overheat.ToString());
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
                if (AbilityCharge < maxCharge)
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
    public void Rage(InputAction.CallbackContext r)
    {
        if(IsLocalPlayer)
        {
            if(SuperCharge == maxSuperCharge)
            {
                SendCommand("RAGE", " ");
            }
        }
    }
    public IEnumerator endRage()
    {
        yield return new WaitForSeconds(15);
        SuperinUse = false;
        SuperCharge = 0;
        SendUpdate("SCHARGE", SuperCharge.ToString());
    }
}
