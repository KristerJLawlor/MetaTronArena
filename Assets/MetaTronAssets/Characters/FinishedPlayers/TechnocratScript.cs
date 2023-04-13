using System.Collections;
using System.Collections.Generic;
using UnityEngine;

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
            if(o.GetComponent<HighLevelEntity>().OverShield > 0 && OverShield<maxOverShield)
            {
                OverShield++;
                SendUpdate("SHIELD", OverShield.ToString());
            }
            else if(HP<maxHP)
            {
                HP++;
                SendUpdate("HP", HP.ToString());
            }
        }
        return d;
    }
}
