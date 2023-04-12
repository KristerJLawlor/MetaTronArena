using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class Ability_Icon_Switcher : MonoBehaviour
{
    public Sprite[] Icons;
    // Start is called before the first frame update
    public int tester = 2;
    void Start()
    {
        setAbility(tester);
    }

    // Update is called once per frame
    void Update()
    {
        setAbility(tester);
    }
    public void setAbility(int a)
    {
        switch (a)
        {
            case 0:
                GameObject.FindGameObjectWithTag("AA").GetComponent<Image>().sprite = Icons[0];
                GameObject.FindGameObjectWithTag("SA").GetComponent<Image>().sprite = Icons[1];
                break;
            case 1:
                GameObject.FindGameObjectWithTag("AA").GetComponent<Image>().sprite = Icons[2];
                GameObject.FindGameObjectWithTag("SA").GetComponent<Image>().sprite = Icons[3];
                break;
            case 2:
                GameObject.FindGameObjectWithTag("AA").GetComponent<Image>().sprite = Icons[4];
                GameObject.FindGameObjectWithTag("SA").GetComponent<Image>().sprite = Icons[5];
                break;
            case 3:
                GameObject.FindGameObjectWithTag("AA").GetComponent<Image>().sprite = Icons[6];
                GameObject.FindGameObjectWithTag("SA").GetComponent<Image>().sprite = Icons[7];
                break;
        }
    }
   
}
 
