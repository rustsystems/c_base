import sys
sys.path.append(".")
import numpy as np
from main import *
from DDPG import *
from Environment import Environment
from shield import Shield
import argparse

def cartpole(learning_method, number_of_rollouts, simulation_steps, ddpg_learning_eposides, critic_structure, actor_structure, train_dir, \
            nn_test=False, retrain_shield=False, shield_test=False, test_episodes=100, retrain_nn=False):
  l = .22+0.15 # rod length is 2l
  m = (2*l)*(.006**2)*(3.14/4)*(7856) # rod 6 mm diameter, 44cm length, 7856 kg/m^3
  M = .4
  dt = .02 # 20 ms
  g = 9.8

  A = np.matrix([[1, dt, 0, 0],[0,1, -(3*m*g*dt)/(7*M+4*m),0],[0,0,1,dt],[0,0,(3*g*(m+M)*dt)/(l*(7*M+4*m)),1]])
  B = np.matrix([[0],[7*dt/(7*M+4*m)],[0],[-3*dt/(l*(7*M+4*m))]])

  # amount of Gaussian noise in dynamics
  # eq_err = 0

   #intial state space
  s_min = np.array([[ -0.1],[ -0.1], [-0.05], [ -0.05]])
  s_max = np.array([[  0.1],[  0.1], [ 0.05], [  0.05]])

  Q = np.matrix("1 0 0 0; 0 1 0 0 ; 0 0 1 0; 0 0 0 1")
  R = np.matrix(".0005")

  x_min = np.array([[-0.3],[-0.5],[-0.3],[-0.5]])
  x_max = np.array([[ .3],[ .5],[.3],[.5]])
  u_min = np.array([[-15.]])
  u_max = np.array([[ 15.]])

  env = Environment(A, B, u_min, u_max, s_min, s_max, x_min, x_max, Q, R)

  if retrain_nn:
    args = { 'actor_lr': 0.0001,
             'critic_lr': 0.001,
             'actor_structure': actor_structure,
             'critic_structure': critic_structure, 
             'buffer_size': 1000000,
             'gamma': 0.99,
             'max_episode_len': 100,
             'max_episodes': 1000,
             'minibatch_size': 64,
             'random_seed': 6553,
             'tau': 0.005,
             'model_path': train_dir+"retrained_model.chkp",
             'enable_test': nn_test, 
             'test_episodes': test_episodes,
             'test_episodes_len': 5000}
  else:
    args = { 'actor_lr': 0.0001,
             'critic_lr': 0.001,
             'actor_structure': actor_structure,
             'critic_structure': critic_structure, 
             'buffer_size': 1000000,
             'gamma': 0.99,
             'max_episode_len': 1,
             'max_episodes': ddpg_learning_eposides,
             'minibatch_size': 64,
             'random_seed': 6553,
             'tau': 0.005,
             'model_path': train_dir+"model.chkp",
             'enable_test': nn_test, 
             'test_episodes': test_episodes,
             'test_episodes_len': 5000}
  actor = DDPG(env, args)

  #################### Shield #################
  model_path = os.path.split(args['model_path'])[0]+'/'
  linear_func_model_name = 'K.model'
  model_path = model_path+linear_func_model_name+'.npy'

  def rewardf(x, Q, u, R):
    return np.matrix([[env.reward(x, u)]])

  names = {0:"cart position, meters", 1:"cart velocity", 2:"pendulum angle, radians", 3:"pendulum angle velocity"}
  shield = Shield(env, actor, model_path, force_learning=retrain_shield)
  shield.train_shield(learning_method, number_of_rollouts, simulation_steps, rewardf=rewardf, names=names, explore_mag = 2.0, step_size = 2.0)
  if shield_test:
    shield.test_shield(test_episodes, 5000, mode="single")

  actor.sess.close()

if __name__ == "__main__":
  parser = argparse.ArgumentParser(description='Running Options')
  parser.add_argument('--nn_test', action="store_true", dest="nn_test")
  parser.add_argument('--retrain_shield', action="store_true", dest="retrain_shield")
  parser.add_argument('--shield_test', action="store_true", dest="shield_test")
  parser.add_argument('--test_episodes', action="store", dest="test_episodes", type=int)
  parser.add_argument('--retrain_nn', action="store_true", dest="retrain_nn")
  parser_res = parser.parse_args()
  nn_test = parser_res.nn_test
  retrain_shield = parser_res.retrain_shield
  shield_test = parser_res.shield_test
  test_episodes = parser_res.test_episodes if parser_res.test_episodes is not None else 100
  retrain_nn = parser_res.retrain_nn

  cartpole("random_search", 200, 200, 0, [1200,900], [1000,900,800], "ddpg_chkp/perfect_model/cartpole/change_l/", 
    nn_test=nn_test, retrain_shield=retrain_shield, shield_test=shield_test, test_episodes=test_episodes, retrain_nn=retrain_nn)
