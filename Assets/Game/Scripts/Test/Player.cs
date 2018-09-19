using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class Player : MonoBehaviour
{
    #region Event & Awake
    private UnityAction moveAction;
    private void Awake()
    {
        moveAction = new UnityAction(Move);
    }
    private void OnEnable()
    {
        EventManager.StartListening(EventManager.CustomEventType.Move, moveAction);
    }
    private void OnDisable()
    {
        EventManager.StopListening(EventManager.CustomEventType.Move, moveAction);
    }

    private void Move()
    {
        Vector3 dest = OnscreenRay.hitPosition;

        transform.position = dest;
    }
    #endregion
}
