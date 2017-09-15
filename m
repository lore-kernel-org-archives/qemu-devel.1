Received: from eggs.gnu.org ([2001:4830:134:3::10]:50800)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dstzc-00070f-Tr
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 13:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dstzY-0005PK-Qn
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 13:01:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40620)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dstzY-0005O3-KU
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 13:01:24 -0400
Date: Fri, 15 Sep 2017 19:01:18 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170915190118.03dc1b57.cohuck@redhat.com>
In-Reply-To: <20170915092758.16ea52fc.cohuck@redhat.com>
References: <20170913132752.8484-1-pasic@linux.vnet.ibm.com>
	<20170913132752.8484-2-pasic@linux.vnet.ibm.com>
	<20170914162603.1cdabd09.cohuck@redhat.com>
	<0b42ef59-4366-175f-8dc7-bc3ed02e2fb4@linux.vnet.ibm.com>
	<20170915092758.16ea52fc.cohuck@redhat.com>
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
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>

On Fri, 15 Sep 2017 09:27:58 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> On Thu, 14 Sep 2017 18:50:29 +0200
> Halil Pasic <pasic@linux.vnet.ibm.com> wrote:
> 
> > On 09/14/2017 04:26 PM, Cornelia Huck wrote:  

> > > There's quite some potential in this. We may want to make this a
> > > permanent addition.
> > >     
> > 
> > I'm happy to contribute! I'm not sure how shall we proceed though.
> > Maybe with making a todo list?  
> 
> I think the first step would be to figure out the ids so we don't step
> on anyone's toes. Then maybe refactor a bit so that other testers can
> be added easily.
> 
> For ideas about things to be tested, maybe put a list into the wiki?

OK, I've created https://wiki.qemu.org/Testing/CCWTestDevice - let me
know if you need an account.
