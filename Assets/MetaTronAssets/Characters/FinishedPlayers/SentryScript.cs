using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class SentryScript : NetworkPlayerController
{
    // Start is called before the first frame update
    public override void HandleMessage(string flag, string value)
    {
        base.HandleMessage(flag, value);
        if (IsClient && flag == "PA")
        {
            passiveActive = bool.Parse(value);

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
        passiveActive = true;
        SendUpdate("PA", "true");
    }

    // Update is called once per frame
    void Update()
    {
        base.Update();
        if(IsServer)
        {
            if (passiveActive && OverShield < maxOverShield)
            {
                OverShield++;
                SendUpdate("SHIELD", OverShield.ToString());
            }
            if (RegenTimer>0.0f)
            {
                passiveActive = false;
                SendUpdate("PA", passiveActive.ToString());
            }
            RegenTimer -= Time.deltaTime;
            if (RegenTimer <= 0.0f)
            { 
                passiveActive = true;
                SendUpdate("PA", passiveActive.ToString());
            }
        }
    }
}
