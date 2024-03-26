import mpi4py
import mpi4py.MPI
import os
import sys

if __name__=='__main__':
    comm = mpi4py.MPI.COMM_WORLD
    rank = comm.Get_rank()
    nproc = comm.Get_size()
    
    name=mpi4py.MPI.Get_processor_name()
    
    visible_device_list = os.environ.get('ROCR_VISIBLE_DEVICES')

    sys.stdout.write("I am process {0:d} of {1:d} on {2:s}. I see devices {3}.\n".format(rank, nproc, name, visible_device_list))
