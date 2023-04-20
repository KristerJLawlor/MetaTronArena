using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using NETWORK_ENGINE;

public class LandmineScript : NetworkComponent
{

    public bool isTriggered = false;
    public GameObject TripMineEffect;
    public override void HandleMessage(string flag, string value)
    {
        if (IsClient && flag == "MINE")
        {
            isTriggered = bool.Parse(value);
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
        if(IsClient)
        {
            if(isTriggered)
            {
                isTriggered = false;
                GameObject temp = Instantiate(TripMineEffect, this.transform);

                Destroy(temp, 1.5f);
            }
        }
    }
    public void OnTriggerEnter(Collider c)
    {
        if (c.gameObject.tag == "Entity" && this.Owner!=c.gameObject.GetComponent<NetworkID>().Owner)
        {
            c.GetComponent<HighLevelEntity>().trippedMine();

            isTriggered = true;
            SendUpdate("MINE", isTriggered.ToString());
            StartCoroutine(DestroyRoutine());
        }
    }

    public IEnumerator DestroyRoutine()
    {
        yield return new WaitForSeconds(2.0f);
        MyCore.NetDestroyObject(this.NetId);
    }

}
