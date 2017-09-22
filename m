Received: from eggs.gnu.org ([2001:4830:134:3::10]:47924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dvO9i-0007i7-ST
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:38:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dvO9f-0005vF-25
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:38:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dvO9e-0005uy-RL
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 09:38:06 -0400
Date: Fri, 22 Sep 2017 15:38:01 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170922153801.709fd692.cohuck@redhat.com>
In-Reply-To: <a426d7bc-c1c8-0eb5-0a31-464468010259@linux.vnet.ibm.com>
References: <20170920172314.102710-1-pasic@linux.vnet.ibm.com>
	<20170920172314.102710-2-pasic@linux.vnet.ibm.com>
	<20170921111552.41167e80.cohuck@redhat.com>
	<efa7f105-78c4-1ec0-dcf5-9b97678cd7e5@linux.vnet.ibm.com>
	<20170921140506.42c5f7f6.cohuck@redhat.com>
	<a426d7bc-c1c8-0eb5-0a31-464468010259@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] s390x/3270: IDA support for 3270 via
 CcwDataStream
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J . Herne" <jjherne@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Richard Henderson <rth@twiddle.net>

On Thu, 21 Sep 2017 18:11:06 +0200
Halil Pasic <pasic@linux.vnet.ibm.com> wrote:

> So, there is nothing to be addressed about about this series so far.
> Does this mean good for inclusion once prerequisites are met -- unless
> somebody finds something?

It is in my pipeline, and I currently don't see anything wrong with it.

More reviews are still welcome, though, as always :)
