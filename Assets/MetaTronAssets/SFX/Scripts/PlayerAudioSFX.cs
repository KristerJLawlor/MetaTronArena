using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlayerAudioSFX : MonoBehaviour
{
    public AudioSource PlayerAudio;
    public AudioClip LazerAudio;
    public AudioClip OverheatAudio;
    public AudioClip ShieldHitAudio;
    public AudioClip ShieldBreakAudio;
    public AudioClip ShieldRegenAudio;
    public AudioClip WalkAudio;
    public AudioClip RunAudio;
    public AudioClip HealthLowAudio;
    public AudioClip DeathAudio;
    public AudioClip TimerAudio;
    public AudioClip PickupAudio;
    public AudioClip ScoreUpAudio;


    // Start is called before the first frame update
    void Start()
    {
        PlayerAudio = GetComponent<AudioSource>();
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void PlayLazerAudio()
    {
        PlayerAudio.PlayOneShot(LazerAudio);
    }

    public void PlayOverheatAudio()
    {
        PlayerAudio.PlayOneShot(OverheatAudio);
    }

    public void PlayShieldHitAudio()
    {
        PlayerAudio.PlayOneShot(ShieldHitAudio);
    }

    public void PlayShieldBreakAudio()
    {
        PlayerAudio.PlayOneShot(ShieldBreakAudio);
    }

    public void PlayShieldRegenAudio()
    {
        PlayerAudio.PlayOneShot(ShieldRegenAudio);
    }

    public void PlayWalkAudio()
    {
        PlayerAudio.PlayOneShot(WalkAudio);
    }

    public void PlayRunAudio()
    {
        PlayerAudio.PlayOneShot(RunAudio);
    }

    public void PlayHealthLowAudio()
    {
        PlayerAudio.PlayOneShot(HealthLowAudio);
    }

    public void PlayDeathAudio()
    {
        PlayerAudio.PlayOneShot(DeathAudio);
    }

    public void PlayTimerAudio()
    {
        PlayerAudio.PlayOneShot(TimerAudio);
    }

    public void PlayPickupAudio()
    {
        PlayerAudio.PlayOneShot(PickupAudio);
    }

    public void PlayScoreUpAudio()
    {
        PlayerAudio.PlayOneShot(ScoreUpAudio);
    }
}
