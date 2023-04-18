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


    //Variables for particle effect
    public GameObject LaserPrefab;
    public GameObject LaserBeam;
    public Transform LaserOrigin;

    public override void HandleMessage(string flag, string value)
    {
        base.HandleMessage(flag, value);

        if (flag == "ISDYING")
        {
            //Debug.Log("flag ISDYING = " + value);
            isDying = bool.Parse(value);
            if (IsServer)
            {
                SendUpdate("ISDYING", isDying.ToString());
            }
        }

        if (IsClient && flag == "TARGETNEAR")
        {
            TargetNear = bool.Parse(value);
        }

        if (IsClient && flag == "ISACTIVE")
        {
            isActive = bool.Parse(value);
        }

        if (IsClient && flag == "CANSHOOT")
        {
            canShoot = bool.Parse(value);

        }

        if (flag == "HP")
        {
            HP = int.Parse(value);
        }
    }

    public override void NetworkedStart()
    {
        base.NetworkedStart();

    }

    public override IEnumerator SlowUpdate()
    {
        base.SlowUpdate();
        while (IsServer)
        {
            body.velocity = Vector3.zero + new Vector3(0, body.velocity.y, 0);
            Debug.Log("A1" + Players.Length);
            foreach (var p in Players)
            {
                Debug.Log("B1");
                
                if ((transform.position - p.transform.position).magnitude < 25 && canShoot)
                {
                    this.transform.forward = (p.transform.position - transform.position).normalized;
                    TargetNear = true;
                    SendUpdate("TARGETNEAR", TargetNear.ToString());
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
                            Debug.Log("E1");
                            
                        }
                    }

                    canShoot = false;
                    SendUpdate("CANSHOOT", canShoot.ToString());
                    StartCoroutine(ROF());
                    Debug.Log("BREAK");
                    break;
                }
                

                else if((transform.position - p.transform.position).magnitude >= 25)
                {
                    TargetNear = false;
                    SendUpdate("TARGETNEAR", TargetNear.ToString());
                }
                

            }

            if (HP <= 0)
            {
                Debug.Log("Turret deceased");
                isDying = true;
                SendUpdate("ISDYING", isDying.ToString());
                isActive = false;
                SendUpdate("ISACTIVE", false.ToString());
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
            this.transform.forward = Vector3.zero;
        }
    }

    // Update is called once per frame
    void Update()
    {
        base.Update();
        if (IsServer)
        {

        }

        if (IsClient)
        {
            

            if (canShoot && TargetNear)
            {
                Destroy(LaserBeam);
                LaserBeam = Instantiate(LaserPrefab, LaserOrigin.transform.position, transform.rotation);

                this.GetComponent<EnemyAudio>().PlayLazerAudio();
            }
            else
            {
                Destroy(LaserBeam, 0.5f);
            }

            if (isDying)
            {
                isDying = false;
                this.GetComponent<EnemyAudio>().PlayDeathAudio();
            }

            if(isActive)
            {
                this.gameObject.SetActive(true);
            }
            if (!isActive)
            {
                this.gameObject.SetActive(false);
            }

        }
    }

    public IEnumerator Respawn()
    {
        Debug.Log("In Respawn");
        this.gameObject.SetActive(false);
        yield return new WaitForSeconds(20);
        HP = 50;
        SendUpdate("HP", HP.ToString());
        isDying = false;
        SendUpdate("ISACTIVE", true.ToString());
        this.gameObject.SetActive(true);

    }

    public IEnumerator ROF()
    {
        Debug.Log("IN ROF");
        yield return new WaitForSeconds(1.5f);
        canShoot = true;
        SendUpdate("CANSHOOT", canShoot.ToString());

    }
}
