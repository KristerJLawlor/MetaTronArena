using UnityEngine;
using UnityEngine.UI;

public class RotateTroughSlider : MonoBehaviour
{
    public Slider slider;
    private Vector3 eulerRotation;

    private void Update ( )
    {
        eulerRotation.y = slider.value;
        transform.eulerAngles = eulerRotation;
    }
}
