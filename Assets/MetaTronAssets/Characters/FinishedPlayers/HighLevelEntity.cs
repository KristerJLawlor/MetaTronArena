using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using NETWORK_ENGINE;

public class HighLevelEntity : NetworkComponent
{
    public int HP=100;
    public int OverShield=50;


    public void Damage()
    {
        if (OverShield > 0)
        {
            OverShield--;
        }
        else
        {
            HP--;
        }
    }
    public override void HandleMessage(string flag, string value)
    {
        
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
