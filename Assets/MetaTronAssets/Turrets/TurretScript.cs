using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using NETWORK_ENGINE;


public class TurretScript : HighLevelEntity
{
    GameObject[] Players;
    public RaycastHit hit;
    public Rigidbody body;

    public bool isDying = false;
    public bool canShoot = true;
    public bool TargetNear = false;




    //Variables for particle effect
    public GameObject LaserPrefab;
    public GameObject LaserBeam;
    public Transform LaserOrigin;
    public GameObject ExplosionEffect;


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
            //Debug.Log("flag TARGETNEAR = " + value);
            TargetNear = bool.Parse(value);
        }


        if (IsClient && flag == "CANSHOOT")
        {
            //Debug.Log("flag CANSHOOT = " + value);
            canShoot = bool.Parse(value);

        }

        if (flag == "HP")
            //Debug.Log("flag HP = " + value);
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

            body.velocity = new Vector3(0, body.velocity.y, 0);


            if (canShoot)
            {
                foreach (var p in Players)
                {

                    if ((transform.position - p.transform.position).magnitude < 25)
                    {
                        TargetNear = true;
                        SendUpdate("TARGETNEAR", TargetNear.ToString());

                        this.transform.forward = (p.transform.position - transform.position).normalized;


                        //Debug.Log("C1");
                        if (Physics.Raycast(transform.position + transform.up * .5f, (p.transform.position - transform.position).normalized, out hit))
                        {
                            this.transform.forward = (p.transform.position - transform.position).normalized;
                            //Debug.Log("D1" + hit.collider.name);

                            if (hit.collider.tag == "Entity")
                            {
                                //move toward target
                                body.velocity = (p.transform.position - transform.position).normalized;
                                hit.transform.GetComponent<HighLevelEntity>().Damage(.4f, false);
                                this.transform.forward = (p.transform.position - transform.position).normalized;

                                Debug.Log("E1");

                                canShoot = false;
                                SendUpdate("CANSHOOT", canShoot.ToString());
                                StartCoroutine(ROF());
                                Debug.Log("BREAK");
                                break;

                            }
                        }

                    }


                    else if ((transform.position - p.transform.position).magnitude >= 25)
                    {
                        TargetNear = false;
                        SendUpdate("TARGETNEAR", TargetNear.ToString());
                    }


                }

            }

            if (HP <= 0 && !isDying)
            {

                //Debug.Log("Turret deceased");
                isDying = true;
                SendUpdate("ISDYING", isDying.ToString());
                
                StartCoroutine(Death());
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
        }
        if (IsClient)
        {
            
        }
        Players = GameObject.FindGameObjectsWithTag("Entity");
        body = GetComponent<Rigidbody>();
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
            
            if(TargetNear)
            {

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
                SendCommand("ISDYING", false.ToString());
                this.GetComponent<EnemyAudio>().PlayDeathAudio();
                StartCoroutine(DeathEffect());
            }


        }
    }

    public IEnumerator Death()
    {   
        //Debug.Log("In Death");


        yield return new WaitForSeconds(3.0f);
        MyCore.NetDestroyObject(this.NetId);


    }

    public IEnumerator DeathEffect()
    {
        //Debug.Log("In DeathFX");
        this.GetComponent<EnemyAudio>().PlayDeathAudio();
        yield return new WaitForSeconds(0.5f);
        GameObject temp = Instantiate(ExplosionEffect, this.transform);
        yield return new WaitForSeconds(1.5f);
        Destroy(temp);


    }

    public IEnumerator ROF()
    {
        //Debug.Log("IN ROF");
        yield return new WaitForSeconds(1.5f);
        canShoot = true;
        SendUpdate("CANSHOOT", canShoot.ToString());

    }


}
