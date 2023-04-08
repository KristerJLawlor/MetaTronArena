using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

using NETWORK_ENGINE;




public class NetworkPlayerController : HighLevelEntity
{


    public Vector2 LastInput;
    public Vector2 AimVector;
    public Rigidbody myRig;
    public float speed = 5;
    public float Overheat = 0;
    public bool canShoot = true;
    public bool lastFire=false;
    public string pname;

    public Vector2 ParseV2(string v)
    {
        Vector2 temp = new Vector2();
        string[] args = v.Trim('(').Trim(')').Split(',');
        temp.x = float.Parse(args[0]); 
        temp.y = float.Parse(args[1]);
        return temp;
    }

    public void ActionHandler(InputAction.CallbackContext c)
    {
       if(IsLocalPlayer)
        {
            if (c.started || c.performed)
            {
                //Send input
                SendCommand("MVC", c.ReadValue<Vector2>().ToString("F2"));
            }
            else if (c.canceled)
            {
                //Send vector 2.zero.
                SendCommand("MVC", Vector2.zero.ToString("F2"));
            }
        }
    }
    public void Aiming(InputAction.CallbackContext a)
    {
        if(IsLocalPlayer)
        {
            SendCommand("AIM", a.ReadValue<Vector2>().ToString());
        }
    }
    public void Shoot(InputAction.CallbackContext s)
    {
        if (IsLocalPlayer && canShoot)
        {
            if (s.started)
            {
                SendCommand("FIRE", "True");
                
            }

            else if (s.canceled)
            {
                SendCommand("FIRE", "False");
            }
        }
    }
    public void HeatVent(InputAction.CallbackContext h)
    {
        if (IsLocalPlayer && Overheat<100) 
        {
            canShoot = false;
            SendUpdate("CANSHOOT", canShoot.ToString());
            StartCoroutine(Reload());
        }
    }
    public IEnumerator Reload()
    {
        yield return new WaitForSeconds(2);
        canShoot = true;
        SendUpdate("CANSHOOT", canShoot.ToString());
        Overheat = 0;
    }
    public IEnumerator ROF()
    {
        yield return new WaitForSeconds(.5f);
        canShoot = true;
        Overheat++;
        SendUpdate("CANSHOOT", canShoot.ToString());
    }
    public IEnumerator OH()
    {
        yield return new WaitForSeconds(4);
        Overheat= 0;
        canShoot= true;
        SendUpdate("CANSHOOT", canShoot.ToString());
    }
    
    public override void HandleMessage(string flag, string value)
    {
        if(IsServer && flag == "MVC")
        {
            LastInput = ParseV2(value);
        }
        if(IsServer && flag == "AIM")
        {
            AimVector = ParseV2(value);
        }
        if(IsServer && flag == "FIRE")
        {
            lastFire = bool.Parse(value);
            SendUpdate("FIRE", value);
        }
        if(IsClient && flag == "CANSHOOT")
        {
            canShoot= bool.Parse(value);
        }
        
        if(flag == "PN")
        {
            pname = value;
        }
    }

    public override void NetworkedStart()
    {
      
    }

    public override IEnumerator SlowUpdate()
    {
        while(IsServer)
        {
            if(lastFire && canShoot)
            {
                RaycastHit hit;
                if(Physics.Raycast(Camera.main.transform.position, Camera.main.transform.forward,out hit))
                {
                    if(hit.collider == GameObject.FindGameObjectWithTag("Entity"))
                    {
                        hit.transform.GetComponent<HighLevelEntity>().Damage();
                    }
                }
                canShoot= false;
                SendUpdate("CANSHOOT", canShoot.ToString());
                StartCoroutine(ROF());
            }
            if(IsDirty)
            {
                SendUpdate("PN", pname);
                SendUpdate("MVC", myRig.velocity.ToString());
                IsDirty= false;
            }
            yield return new WaitForSeconds(.05f);
        }
    }

    // Start is called before the first frame update
    void Start()
    {
        myRig = GetComponent<Rigidbody>();
    }

    // Update is called once per frame
    void Update()
    {
        if (IsServer)
        {
            myRig.velocity = transform.forward * LastInput.y * speed + transform.right * LastInput.x *speed;
            
            myRig.angularVelocity = new Vector3(0, AimVector.x, 0);
            
        }
        if (IsLocalPlayer)
        {
            Camera.main.transform.position = transform.position + transform.forward * .5f + this.transform.up;
            Camera.main.transform.forward = transform.forward;
            if(Overheat >= 100)
            {
                canShoot = false;
                SendCommand("CANSHOOT", canShoot.ToString());
                StartCoroutine(OH());
            }
            if (!lastFire && Overheat>0)
            {
                Overheat--;
            }
        }
    }
}
