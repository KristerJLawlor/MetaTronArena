using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using NETWORK_ENGINE;

public class TurretAIScript : HighLevelEntity
{

    GameObject[] Players;
    GameObject Target;
    Vector3 TargetLoc;



    public Vector2 ParseV2(string v)
    {
        Vector2 temp = new Vector2();
        string[] args = v.Trim('(').Trim(')').Split(',');
        temp.x = float.Parse(args[0]);
        temp.y = float.Parse(args[1]);
        return temp;
    }
    public Vector3 ParseV3(string v)
    {
        Vector3 temp = new Vector3();
        string[] args = v.Trim('(').Trim(')').Split(',');
        temp.x = float.Parse(args[0]);
        temp.y = float.Parse(args[1]);
        temp.z = float.Parse(args[2]);
        return temp;
    }

    public override void HandleMessage(string flag, string value)
    {
        base.HandleMessage(flag, value);

        if(IsClient && flag == "TARGET")
        {
            TargetLoc = ParseV3(value);
        }
    }

    public override void NetworkedStart()
    {
        base.NetworkedStart();
        if (IsServer)
        {
            Players = GameObject.FindGameObjectsWithTag("Entity");
            OverShield = 0;
            SendUpdate("SHIELD", OverShield.ToString());
            HP = 50;
            SendUpdate("HP", HP.ToString());
        }
    }

    public override IEnumerator SlowUpdate()
    {
        base.SlowUpdate();
        while (IsServer)
        {
            foreach (var p in Players)
            {

                if ((transform.position - p.transform.position).magnitude < 20)
                {
                    Target = p;
                    
                }
            }
            yield return new WaitForSeconds(.1f);

            SendUpdate("TARGET", Target.transform.position.ToString());
            this.transform.LookAt(Target.transform);
        }

    }

    // Start is called before the first frame update
    void Start()
    {
        this.transform.LookAt(Vector3.zero);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
