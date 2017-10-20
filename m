Received: from eggs.gnu.org ([2001:4830:134:3::10]:41634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5ZVY-0005Ly-W1
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:46:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e5ZVY-0006O9-94
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:46:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e5ZVY-0006Nq-2V
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:46:48 -0400
Date: Fri, 20 Oct 2017 17:46:42 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171020174642.7e045af4.cohuck@redhat.com>
In-Reply-To: <c17eb441-f22b-2e92-dd39-01c3caddec19@linux.vnet.ibm.com>
References: <20170913132752.8484-1-pasic@linux.vnet.ibm.com>
	<20170913132752.8484-2-pasic@linux.vnet.ibm.com>
	<20170914162603.1cdabd09.cohuck@redhat.com>
	<0b42ef59-4366-175f-8dc7-bc3ed02e2fb4@linux.vnet.ibm.com>
	<20170915092758.16ea52fc.cohuck@redhat.com>
	<711b1e41-693a-de7d-9c13-fbe0f964c53c@linux.vnet.ibm.com>
	<20171020150043.383b2117.cohuck@redhat.com>
	<c17eb441-f22b-2e92-dd39-01c3caddec19@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] s390x/ccs: add ccw-tester emulated
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org

On Fri, 20 Oct 2017 16:33:47 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> OK, I will approach the z/VM guys. About EMULATED_CCW_3270_CHPID_TYPE,
> does it really make sense to have a separate chpid type for 3270? (You
> have missed that question, so I'm asking it again).

I had not. But my resources are depleted.
