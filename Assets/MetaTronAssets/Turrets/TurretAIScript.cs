using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using NETWORK_ENGINE;

public class TurretAIScript : HighLevelEntity
{

    GameObject[] Players;
    GameObject Target;
    Vector3 TargetLoc;
    public Transform LaserOrigin;
    public float Range = 20f;
    public float LaserDuration = 0.05f;
    LineRenderer LaserLine;
    public Vector3 AimPosition;
    public Vector3 AimDirection;
    public bool canShoot = true;
    public RaycastHit hit;
    public Vector3 SpawnLoc;
    public bool TargetNear = false;

    //Variables for particle effect
    public GameObject LaserPrefab;
    public GameObject LaserBeam;



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

        if (IsClient && flag == "TARGETNEAR")
        {
            TargetNear = bool.Parse(value);
        }


        if (IsClient && flag == "CANSHOOT")
        {
            canShoot = bool.Parse(value);

        }


        if (IsServer && flag == "AP")
        {
            AimPosition = ParseV3(value);

        }

        if (IsServer && flag == "AD")
        {
            AimDirection = ParseV3(value);

        }

    }

    public override void NetworkedStart()
    {
        base.NetworkedStart();
        if (IsServer)
        {
            Players = GameObject.FindGameObjectsWithTag("Entity");
            OverShield = 0;
            HP = 50;
        }
    }

    public IEnumerator ROF()
    {

            yield return new WaitForSeconds(1.5f);
            canShoot = true;
            SendUpdate("CANSHOOT", canShoot.ToString());

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
                    TargetNear = true;
                    SendUpdate("TARGETNEAR", TargetNear.ToString());
                }
                else
                {
                    TargetNear = false;
                    SendUpdate("TARGETNEAR", TargetNear.ToString());
                }
            }
            yield return new WaitForSeconds(.1f);

            SendUpdate("TARGET", Target.transform.position.ToString());
            this.transform.LookAt(Target.transform);

            AimPosition = this.transform.position;
            AimDirection = this.transform.forward;

            if (canShoot && TargetNear)
            {
                //LaserLine.SetPosition(0, LaserOrigin.position);
                if (Physics.Raycast(AimPosition, AimDirection, out hit, Range))
                {
                    if (hit.collider.tag == "Entity")
                    {
                        //LaserLine.SetPosition(1, hit.point);
                        hit.transform.GetComponent<HighLevelEntity>().Damage(OnDamage(this.DamageScalar, hit.transform.gameObject), this.AProunds);
                    }


                }
      
                canShoot = false;
                SendUpdate("CANSHOOT", canShoot.ToString());

                StartCoroutine(ROF());

            }

        }

    }

    public virtual float OnDamage(float d, GameObject o)
    {
        return d;
    }


    // Start is called before the first frame update
    void Start()
    {
        this.transform.LookAt(Vector3.zero);
    }

    // Update is called once per frame
    void Update()
    {
        if(IsClient)
        {
            this.transform.LookAt(TargetLoc);

            if(canShoot && TargetNear)
            {
                Destroy(LaserBeam);
                LaserBeam = Instantiate(LaserPrefab, LaserOrigin.transform.position, transform.rotation);
            }
            else
            {
                Destroy(LaserBeam, 0.5f);
            }

        }
        
    }
}
