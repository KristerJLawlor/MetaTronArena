using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using NETWORK_ENGINE;


public class TurretScript : HighLevelEntity
{
    GameObject[] Players;
    public RaycastHit hit;
    public Rigidbody body;
    public Vector3 SpawnLoc;
    public bool isDying = false;
    public bool canShoot = true;
    public bool TargetNear = false;
    public bool isActive = true;
    public Vector3 ForwardVector;


    //Variables for particle effect
    public GameObject LaserPrefab;
    public GameObject LaserBeam;
    public Transform LaserOrigin;



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
        //base.HandleMessage(flag, value);

        if (flag == "ISDYING")
        {
            Debug.Log("flag ISDYING = " + value);
            isDying = bool.Parse(value);
            if (IsServer)
            {
                SendUpdate("ISDYING", isDying.ToString());
            }
        }

        if (IsClient && flag == "TARGETNEAR")
        {
            Debug.Log("flag TARGETNEAR = " + value);
            TargetNear = bool.Parse(value);
        }

        if (IsClient && flag == "ISACTIVE")
        {
            Debug.Log("flag ISACTIVE = " + value);
            isActive = bool.Parse(value);
        }

        if (IsClient && flag == "CANSHOOT")
        {
            Debug.Log("flag CANSHOOT = " + value);
            canShoot = bool.Parse(value);

        }

        if (flag == "HP")
            Debug.Log("flag HP = " + value);
        {
            HP = int.Parse(value);
        }

        if(flag == "FORWARD" && IsClient)
        {
            ForwardVector = ParseV3(value);
        }
    }

    public override void NetworkedStart()
    {
        base.NetworkedStart();

    }

    public override IEnumerator SlowUpdate()
    {
        //base.SlowUpdate();
        while (IsServer)
        {
            body.velocity = Vector3.zero + new Vector3(0, body.velocity.y, 0);
            Debug.Log("A1" + Players.Length);

            if (canShoot)
            {
                foreach (var p in Players)
                {
                    Debug.Log("B1");

                    if ((transform.position - p.transform.position).magnitude < 25)
                    {
                        TargetNear = true;
                        SendUpdate("TARGETNEAR", TargetNear.ToString());

                        this.transform.forward = (p.transform.position - transform.position).normalized;
                        SendUpdate("FORWARD", this.transform.forward.ToString());

                        Debug.Log("C1");
                        if (Physics.Raycast(transform.position + transform.up * .5f, (p.transform.position - transform.position).normalized, out hit))
                        {
                            //this.transform.forward = (p.transform.position - transform.position).normalized;
                            Debug.Log("D1" + hit.collider.name);
                            //Debug.DrawRay(transform.position + transform.up * .5f, (p.transform.position - transform.position).normalized, Color.red);
                            if (hit.collider.tag == "Entity")
                            {
                                //move toward target
                                //body.velocity = (p.transform.position - transform.position).normalized * 1.5f;
                                hit.transform.GetComponent<HighLevelEntity>().Damage(.4f, false);
                                this.transform.forward = (p.transform.position - transform.position).normalized;
                                Debug.Log("Turret forward rotation serverside: " + this.transform.forward.ToString());
                                SendUpdate("FORWARD", this.transform.forward.ToString());
                                Debug.Log("E1");

                            }
                        }

                        canShoot = false;
                        SendUpdate("CANSHOOT", canShoot.ToString());
                        StartCoroutine(ROF());
                        Debug.Log("BREAK");
                        break;
                    }


                    else if ((transform.position - p.transform.position).magnitude >= 25)
                    {
                        TargetNear = false;
                        SendUpdate("TARGETNEAR", TargetNear.ToString());
                    }


                }

            }

            if (HP <= 0)
            {
                Debug.Log("Turret deceased");
                isDying = true;
                SendUpdate("ISDYING", isDying.ToString());
                
                StartCoroutine(Respawn());
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
            HP = 50;
            SendUpdate("HP", HP.ToString());
            body = GetComponent<Rigidbody>();
        }
        if (IsClient)
        {
            this.transform.forward = (this.transform.position - Vector3.zero).normalized;
        }
    }

    // Update is called once per frame
    void Update()
    {
        //base.Update();
        if (IsServer)
        {

        }

        if (IsClient)
        {
            
            if(TargetNear)
            {
                Debug.Log("Forward vector" + ForwardVector);
                this.transform.forward = ForwardVector;
                if (canShoot)
                {
                    Destroy(LaserBeam);
                    LaserBeam = Instantiate(LaserPrefab, LaserOrigin.transform.position, transform.rotation);

                    this.GetComponent<EnemyAudio>().PlayLazerAudio();
                }
                else
                {
                    Destroy(LaserBeam, 0.5f);
                }
            }

            if (isDying)
            {
                isDying = false;
                this.GetComponent<EnemyAudio>().PlayDeathAudio();
            }

            if(isActive)
            {
                this.transform.gameObject.SetActive(true);
            }
            if (!isActive)
            {
                this.transform.gameObject.SetActive(false);
            }

        }
    }

    public IEnumerator Respawn()
    {   
        Debug.Log("In Respawn");
        isActive = false;
        SendUpdate("ISACTIVE", false.ToString());
        
        this.transform.gameObject.SetActive(false);
        Debug.Log("Starting Wait");
        yield return new WaitForSeconds(5.0f);
        Debug.Log("Wait finished");
        HP = 50;
        SendUpdate("HP", HP.ToString());
        isDying = false;
        SendUpdate("ISACTIVE", true.ToString());
        this.transform.gameObject.SetActive(true);
        Debug.Log("Exiting Respawn");
    }

    public IEnumerator ROF()
    {
        Debug.Log("IN ROF");
        yield return new WaitForSeconds(1.5f);
        canShoot = true;
        SendUpdate("CANSHOOT", canShoot.ToString());

    }
}
