using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.InputSystem;

public class MarksmanScript : NetworkPlayerController
{// Start is called before the first frame update
    public GameObject[] Entity;
    public override void HandleMessage(string flag, string value)
    {
        base.HandleMessage(flag, value);
        if (IsClient && flag == "PA")
        {
            passiveActive = bool.Parse(value);

        }
        if(IsServer && flag == "MINE")
        {
            AbilityCharge = maxCharge;
            GameObject temp = MyCore.NetCreateObject(5, this.Owner, this.transform.position+this.transform.up*-.3f);
        }
        if(IsServer && flag == "RAIL")
        {
            SuperCharge = maxSuperCharge;
            SendUpdate("SCHARGE", SuperCharge.ToString());
            StartCoroutine(RailShot());
        }
    }
    public override void NetworkedStart()
    {
        base.NetworkedStart();
    }
    public override IEnumerator SlowUpdate()
    {
        return base.SlowUpdate();
    }
    void Start()
    {
        base.Start();
        Entity = GameObject.FindGameObjectsWithTag("Entity");
    }

    // Update is called once per frame
    void Update()
    {
        base.Update();
        if (IsServer)
        {
            passiveActive = false;
            foreach (var entity in Entity)
            {
                if (entity.gameObject == this.gameObject)
                {
                    continue;
                }
                if ((entity.transform.position - this.transform.position).magnitude > 30)
                {
                    passiveActive = true;
                    break;
                }

            }
            SendUpdate("PA", passiveActive.ToString());
        }
    }
    public override float OnDamage(float d, GameObject o)
    {
        if (passiveActive)
        {
            return d * 2.5f;
        }
        return d;
    }
    public void PlaceMine(InputAction.CallbackContext m)
    {
        if (IsLocalPlayer)
        {
            if (AbilityCharge == 0)
            {
                AbilityCharge = maxCharge;
                SendCommand("MINE", " ");
            }
        }
        
    }
    public void Railgun(InputAction.CallbackContext rg)
    {
        if(IsLocalPlayer)
        {
            if(SuperCharge==0)
            {
                SendCommand("RAIL", " ");
            }
        }
    }
    public IEnumerator RailShot()
    {
        yield return new WaitForSeconds(.5f);
        if (Physics.Raycast(AimPosition, AimDirection, out hit))
        {
            if (hit.collider.tag == "Entity")
            {
                hit.transform.GetComponent<HighLevelEntity>().gotRailed();
            }
        }
    }
}
