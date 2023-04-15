using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class HUD_Script : MonoBehaviour
{
    //UI and Owner
    public Image ShieldBar;
    public Image[] HPoints;
    public Sprite[] Icons;
    public Image OVBar;
    public NetworkPlayerController Owner;
    public Text MTimer;
    public Text IndScore;
    public Text ScoreBoard;
    public Slider A_Ability;
    public Slider S_Ability;

    //maybe temp
    public float StartTime = 900f;
    public float timer = 0f;

    //keep
    float LerpSpeed;
    public SortedList<string, int> ScoreList;
    //temp values
    public int billScore = 1;
    public float MaxHealth = 100;
    public float CurHealth;

    public float MaxShields = 50;
    public float CurShields;

    public float MaxHeatTemp = 100;
    public float Heatlvl = 0;
    // Start is called before the first frame update
    void Start()
    {
        Owner = transform.parent.gameObject.GetComponent<NetworkPlayerController>();
        ScoreList = new SortedList<string, int>();
        CurHealth = MaxHealth;
        CurShields = MaxShields;
        setAbility(Owner.Type);
        StartCoroutine(Timing());

        ActiveMax(Owner.maxCharge);
    }

    // Update is called once per frame
    void Update()
    {

        setAbility(Owner.Type);
        /*//Just in case
        if(CurShields > MaxShields) CurShields = MaxShields;
        if (CurHealth > MaxHealth) CurHealth = MaxHealth;
        if (CurShields < 0) CurShields = 0;
        if (CurHealth < 0) CurHealth = 0;
        if (Heatlvl > MaxHeat) Heatlvl = MaxHeat;
        if (Heatlvl < 0) Heatlvl = 0;
        Owner.MyId.IsInit &&
        */
        if (Owner.MyId.IsInit && !Owner.IsLocalPlayer)
        {
            this.gameObject.SetActive(false);
        }
        LerpSpeed = 3f * Time.deltaTime;

        billScore++;
        HealthbarFill();
        //setAbility(Owner.Type);
        HeatbarFill();
        ActiveValue(Owner.AbilityCharge);
        ChangeScore();
        //Add owner values going to active ability and super abilities cooldowns here

        ScoreList.Add(Owner.pname, Owner.Score);
        ScoreList.Add("Bill", billScore);
        foreach (KeyValuePair<string, int> t in ScoreList)
        {
            Debug.Log(t.Key + "," + t.Value);
        }
        MakeScore();

    }
    public void MakeScore()
    {
        ScoreBoard.text = "ScoreBoard: \n";
        foreach(KeyValuePair<string, int> scores in ScoreList)
        {
            ScoreBoard.text += scores.Key + ":" + scores.Value + "\n";
        }
    }
    public void ChangeScore()
    {
        IndScore.text = "Score: " + Owner.Score;
    }
    public void HeatbarFill()
    {
        OVBar.fillAmount = Mathf.Lerp(OVBar.fillAmount, Owner.Overheat / Owner.MaxHeat, LerpSpeed);
    }
    public void HealthbarFill()
    {
        ShieldBar.fillAmount = Mathf.Lerp(ShieldBar.fillAmount, Owner.OverShield/ Owner.maxOverShield, LerpSpeed);
        
        for(int i = 0; i< HPoints.Length; i++)
        {
            HPoints[i].enabled = !DisplayHitPoint(Owner.HP, i);
        }
    }
    public bool DisplayHitPoint(float health, int Hpoint)
    {
        return ((Hpoint * (Owner.maxHP/10)) >= health);
        //Owner.NetId =tester
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
    public IEnumerator Timing()
    {
        timer = StartTime;
        do
        {
            timer -= Time.deltaTime;
            FormatText();
            yield return null;
        }
        while (timer > 0);
    }
    public void FormatText()
    {
        int minutes = (int)(timer / 60) % 60;
        int seconds = (int)(timer % 60);

        MTimer.text = minutes + ":" + seconds;
    }
    public void ActiveValue(float Acooldown)
    {
        A_Ability.value = Acooldown;
    }
    public void ActiveMax(float ACTime)
    {
        A_Ability.maxValue = ACTime;
    }
    public void SuperValue(float Scooldown)
    {
        A_Ability.value = Scooldown;
    }
    public void SuperMax(float SCTime)
    {
        A_Ability.maxValue = SCTime;
    }
}
