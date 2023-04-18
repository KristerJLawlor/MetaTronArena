using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.InputSystem;

public class SentryScript : NetworkPlayerController
{
    // Start is called before the first frame update
    public GameObject RiotShields;
    public bool SentryPassive;
    public bool isRegen = false;
    RaycastHit[] allHit;
    public override void HandleMessage(string flag, string value)
    {
        base.HandleMessage(flag, value);
        if (IsClient && flag == "PA")
        {
            passiveActive = bool.Parse(value);

        }
        if(IsServer && flag == "RIOT")
        {
            AbilityinUse= bool.Parse(value);
        }
        if(IsClient && flag == "ISREGEN")
        {
            isRegen = bool.Parse(value);
        }
        if(IsClient && flag == "SHACTIVE")
        {
            RiotShields.SetActive(bool.Parse(value));
        }
        if(IsServer && flag == "BURST")
        {
            SuperCharge = 0;
            allHit = Physics.SphereCastAll(AimPosition, 15, AimDirection);
            foreach(var h in allHit)
            {
                if(h.collider.gameObject==this.gameObject) continue;
                if(h.collider.tag=="Entity" || h.collider.tag == "Clone" || hit.collider.tag=="Turret")
                {
                    h.transform.GetComponent<HighLevelEntity>().gotBusted();
                }
            }
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
        SentryPassive = true;
        SendUpdate("SP", "true");
        isSentry = true;
    }

    // Update is called once per frame
    void Update()
    {
        base.Update();
        if(IsServer)
        {
            if (SentryPassive && OverShield < maxOverShield)
            {
                OverShield++;
                SendUpdate("SHIELD", OverShield.ToString());
                SendUpdate("ISREGEN", true.ToString());
            }
            if (RegenTimer>0.0f)
            {
                SentryPassive = false;
                SendUpdate("SP", SentryPassive.ToString());
            }
            RegenTimer -= Time.deltaTime;
            if (RegenTimer <= 0.0f)
            { 
                SentryPassive = true;
                SendUpdate("SP", SentryPassive.ToString());
            }
            if (AbilityinUse && AbilityCharge > 0)
            {
                AbilityCharge = AbilityCharge - 3;
                SendUpdate("ACHARGE", AbilityCharge.ToString());
                RiotShields.SetActive(true);
                SendUpdate("SHACTIVE", "true");
            }
            else
            {
                AbilityinUse = false;
                RiotShields.SetActive(false);
                SendUpdate("SHACTIVE", "false");
            }
        }
        if(IsLocalPlayer)
        {
            if(isRegen)
            {
                isRegen = false;
                this.GetComponent<PlayerAudioSFX>().PlayShieldRegenAudio();
            }
        }
    }
    public void RiotShield(InputAction.CallbackContext rs)
    {
        if(IsLocalPlayer)
        {
            if(rs.started)
            {
                if (AbilityCharge > 0)
                {
                    SendCommand("RIOT", "true");
                }
            }
            
            if(rs.canceled)
            {
                SendCommand("RIOT", "false");
            }
        }
    }
    public void CapacitorBurst(InputAction.CallbackContext cb)
    {
        if (IsLocalPlayer) 
        { 
            if(SuperCharge==maxSuperCharge)
            {
                SuperCharge = 0;
                SendCommand("BURST", " ");
            }
        }
    }
}
