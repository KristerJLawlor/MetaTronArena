using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using NETWORK_ENGINE;

public class HighLevelEntity : NetworkComponent
{
    public float HP=100;
    public float OverShield=50;
    public float DamageScalar = 1;


    
    public void Damage(float DMGMod)
    {
        
        if (OverShield > 0)
        {
            OverShield=OverShield-(5*DMGMod);
            SendUpdate("SHIELD", OverShield.ToString());
        }
        else
        {
            HP=HP-(5*DMGMod);
            SendUpdate("HP", HP.ToString());
        }
    }
    public override void HandleMessage(string flag, string value)
    {
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
       
    }

    public override IEnumerator SlowUpdate()
    {
        yield return new WaitForSeconds(.1f);
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
