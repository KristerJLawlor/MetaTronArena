using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using NETWORK_ENGINE;


public class CloneScript : HighLevelEntity
{
    GameObject[] Players;
    public RaycastHit hit;
    public Rigidbody body;
    public override void HandleMessage(string flag, string value)
    {
        base.HandleMessage(flag, value);
    }

    public override void NetworkedStart()
    {
        base.NetworkedStart();
        
    }

    public override IEnumerator SlowUpdate()
    {
        base.SlowUpdate();
        while(IsServer)
        {
            foreach(var p in Players)
            {
                body.velocity = Vector3.zero;
                Debug.Log("A"+ Players.Length);
                if(this.Owner == p.GetComponent<NetworkID>().Owner)
                {
                    Debug.Log("B");
                    continue;
                }
                Debug.Log("B2");
                if ((transform.position - p.transform.position).magnitude < 25)
                {
                    Debug.Log("C");
                    if(Physics.Raycast(transform.position+transform.up*.5f, (p.transform.position-transform.position).normalized, out hit))
                    {
                       Debug.Log("D" + hit.collider.name);
                        Debug.DrawRay(transform.position + transform.up * .5f, (p.transform.position - transform.position).normalized, Color.blue);
                        if (hit.collider.tag == "Entity")
                        {
                            //move toward target
                            body.velocity = (p.transform.position - transform.position).normalized * 1.5f;
                            hit.transform.GetComponent<HighLevelEntity>().Damage(.4f, false);
                            this.transform.forward = (p.transform.position - transform.position).normalized;
                            Debug.Log("E");
                            break;
                        }
                    }
                }
            }
            yield return new WaitForSeconds(.1f);
        }
        
    }

    // Start is called before the first frame update
    void Start()
    {
        if (IsServer)
        {
            Players = GameObject.FindGameObjectsWithTag("Entity");
            OverShield = 0;
            SendUpdate("SHIELD", OverShield.ToString());
            HP = 25;
            SendUpdate("HP", HP.ToString());
            body=GetComponent<Rigidbody>();
        }
    }

    // Update is called once per frame
    void Update()
    {
        base.Update();
        if (IsServer)
        {
            if (HP <= 0)
            {
                MyCore.NetDestroyObject(this.NetId);
            }
        }
    }
}
