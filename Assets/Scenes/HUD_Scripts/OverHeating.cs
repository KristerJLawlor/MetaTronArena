using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class OverHeating : MonoBehaviour
{
    public Image OVBar;
    

    float LerpSpeed;
    //temp values
    public float MaxHeat = 100;
    public float Heatlvl;

    // Start is called before the first frame update
    void Start()
    {
        Heatlvl = 0;
    }

    // Update is called once per frame
    void Update()
    {
        if (Heatlvl > MaxHeat) Heatlvl = MaxHeat;

        LerpSpeed = 3f * Time.deltaTime;

        HeatbarFill();
    }
    public void HeatbarFill()
    {
        OVBar.fillAmount = Mathf.Lerp(OVBar.fillAmount, Heatlvl / MaxHeat, LerpSpeed);
    }
}
