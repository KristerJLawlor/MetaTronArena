using System.Collections;
using System.Collections.Generic;
using Unity.VisualScripting.InputSystem;
using UnityEngine;
using UnityEngine.InputSystem;

public class TechnocratScript : NetworkPlayerController
{
    // Start is called before the first frame update
    public override void HandleMessage(string flag, string value)
    {
        base.HandleMessage(flag, value);
        if(IsClient && flag == "PA")
        {
            passiveActive=bool.Parse(value);
        }
        if(IsClient && flag == "SHIELD")
        {
            OverShield=float.Parse(value);
        }
        if(IsClient && flag == "HP")
        {
            HP=float.Parse(value);
        }
        if(IsServer && flag == "APR")
        {
            AbilityinUse = true;
            AbilityCharge = maxCharge;
            SendUpdate("ACHARGE", AbilityCharge.ToString());
            DamageScalar = DamageScalar * .85f;
            AProunds = true;
            SendUpdate("SETAPR", AProunds.ToString());
            StartCoroutine(APRTimer());
        }
        if(IsClient && flag == "SETAPR")
        {
            AProunds = bool.Parse(value);
        }
        if (IsServer && flag == "CLONE")
        {
            SuperCharge = maxSuperCharge;
            GameObject temp = MyCore.NetCreateObject(6, this.Owner, this.transform.position + this.transform.right * .5f);
            GameObject temp2 = MyCore.NetCreateObject(6, this.Owner, this.transform.position + this.transform.right * -.5f);
        }
        if(IsClient && flag == "SCHARGE")
        {
            SuperCharge=int.Parse(value);
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
        passiveActive= true;
        SendUpdate("PA", passiveActive.ToString());
    }

    // Update is called once per frame
    void Update()
    {
        base.Update();
    }
    public override float OnDamage(float d, GameObject o)
    {
        if (passiveActive)
        {
            if(o.GetComponent<HighLevelEntity>().OverShield > 0 && OverShield<maxOverShield && !AProunds)
            {
                OverShield+=1;
                SendUpdate("SHIELD", OverShield.ToString());
            }
            else if(HP<maxHP && (o.GetComponent<HighLevelEntity>().OverShield<=0 || AProunds))
            {
                HP+=1;
                SendUpdate("HP", HP.ToString());
            }
        }
        return d;
    }
    public void APRounds(InputAction.CallbackContext ap)
    {
        if (IsLocalPlayer)
        {
            if(AbilityCharge == 0)
            {
                SendCommand("APR", " ");
            }
        }
    }
    public void Clone(InputAction.CallbackContext cl)
    {
        if (IsLocalPlayer)
        {
            if(SuperCharge == 0)
            {
                SuperCharge = maxSuperCharge;
                SendCommand("CLONE", " ");
            }
        }
    }
    public IEnumerator APRTimer()
    {
        yield return new WaitForSeconds(10);
        DamageScalar = 1;
        AProunds = false;
        SendUpdate("SETAPR", AProunds.ToString());
        AbilityinUse= false;
        SendUpdate("ACHARGE", AbilityCharge.ToString());

    }
}
