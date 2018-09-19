using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

#region V6.0
using static EventManager.CustomEventType;
#endregion

public class Player : MonoBehaviour
{
    #region V6.0
    public float MovSpd
    {
        get;
    } = 2.0f;
    #endregion

    #region Event & Awake
    private UnityAction moveAction;
    private UnityAction targetAction;
    private void Awake()
    {
        moveAction = new UnityAction(Move);
        targetAction = new UnityAction(Target);
    }
    private void OnEnable()
    {
        EventManager.StartListening(MOVE, moveAction);
        EventManager.StartListening(ENEMY_TARGETED, targetAction);
    }
    private void OnDisable()
    {
        EventManager.StopListening(MOVE, moveAction);
        EventManager.StopListening(ENEMY_TARGETED, targetAction);
    }
    IEnumerator MoveRoutine(Vector3 source, Vector3 dest, float distance)
    {
        float step = (MovSpd / distance) * Time.fixedDeltaTime;
        float t = 0;
        while (t <= 1.0f)
        {
            t += step;
            transform.position = Vector3.Lerp(source, dest, t);
            yield return new WaitForFixedUpdate();
        }
        transform.position = dest;
    }
    private void Move()
    {
        StopAllCoroutines();

        Vector3 source = transform.position;
        Vector3 dest = OnscreenRay.hitPosition;
        float distance = Vector3.Distance(source, dest);

        Vector3 movVec = dest - source;

        transform.rotation = Quaternion.LookRotation(movVec);

        StartCoroutine(MoveRoutine(source, dest, distance));
    }
    private void Target()
    {

    }
    #endregion
}
