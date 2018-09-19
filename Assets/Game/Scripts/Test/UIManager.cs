using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.Events;

#region V6.0
using static EventManager.CustomEventType;
#endregion

public class UIManager : MonoBehaviour
{
    public Slider targetSlider;
    #region Event & Awake
    private UnityAction targetUICloseAction;
    private UnityAction targetUIAction;
    private void Awake()
    {
        targetSlider.gameObject.SetActive(false);
        targetUICloseAction = new UnityAction(TargetUIClose);
        targetUIAction = new UnityAction(TargetUI);
    }
    private void OnEnable()
    {
        EventManager.StartListening(MOVE, targetUICloseAction);
        EventManager.StartListening(ENEMY_TARGETED_UI, targetUIAction);
    }
    private void OnDisable()
    {
        EventManager.StopListening(MOVE, targetUICloseAction);
        EventManager.StopListening(ENEMY_TARGETED_UI, targetUIAction);
    }
    private void TargetUIClose()
    {
        targetSlider.gameObject.SetActive(false);
    }
    private void TargetUI()
    {
        Enemy enemy = OnscreenRay.hitObject.GetComponent<Enemy>();

        targetSlider.gameObject.SetActive(true);
        targetSlider.minValue = 0;
        targetSlider.maxValue = enemy.MaxHP;
        targetSlider.value = enemy.CurHP;

        #region V6.0
        string targetString = $"{enemy.Name}\n{enemy.CurHP}/{enemy.MaxHP}";
        #endregion

        targetSlider.GetComponentInChildren<Text>().text = targetString;
    }
    #endregion
}
