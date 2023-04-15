using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using NETWORK_ENGINE;

public class LandmineScript : NetworkComponent
{
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
    public void OnTriggerEnter(Collider c)
    {
        if (c.gameObject.tag == "Entity" && this.Owner!=c.gameObject.GetComponent<NetworkID>().Owner)
        {
            c.GetComponent<HighLevelEntity>().trippedMine();
            MyCore.NetDestroyObject(this.NetId);
        }
    }

}
