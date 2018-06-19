Received: from eggs.gnu.org ([2001:4830:134:3::10]:59411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fVIaG-0007qb-QN
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:30:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fVIaD-0000lr-Iv
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:30:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:40796 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fVIaD-0000lQ-Cq
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 11:30:13 -0400
Date: Tue, 19 Jun 2018 18:30:10 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180619182948-mutt-send-email-mst@kernel.org>
References: <cover.1528921468.git.alifm@linux.ibm.com>
	<44ccc5db-e1d4-27b7-8942-c77f467f422e@linux.ibm.com>
	<0c5d7e42-e6c5-6aa2-8c1b-487c8cc9eb21@de.ibm.com>
	<20180619143230.zjemmhhz7embs2li@gondor.apana.org.au>
	<4301ac2e-a8f5-7432-cdd9-f39d30a9fb5e@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4301ac2e-a8f5-7432-cdd9-f39d30a9fb5e@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/2] Detect & register virtio-crypto
 algos only if it can be supported by backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, arei.gonglei@huawei.com, longpeng2@huawei.com, pasic@linux.ibm.com, frankja@linux.ibm.com, Jason Wang <jasowang@redhat.com>, linux-crypto@vger.kernel.org

On Tue, Jun 19, 2018 at 10:57:54AM -0400, Farhan Ali wrote:
> 
> 
> On 06/19/2018 10:32 AM, Herbert Xu wrote:
> > On Tue, Jun 19, 2018 at 04:08:05PM +0200, Christian Borntraeger wrote:
> > > On 06/19/2018 03:26 PM, Farhan Ali wrote:
> > > > A polite ping :)
> > > > 
> > > > If no one has any more comments/feedback then I would like to how to merge these patches to the mainline kernel tree.
> > > 
> > > I think it should go via Michael Tsirkin or Jason Wang (Adding Jason).
> > > Also adding Herbert Xu as FYI.
> > > 
> > > 
> > > I have not looked into the details of the patch, but I like the idea.
> > > Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > 
> > Please post crypto patches to linux-crypto.
> > 
> > Thanks,
> > 
> 
> I have cc'ed linux-crypto folks. Sorry I missed them
> 
> Thanks
> Farhan

Yes but not just the header. you want to repost the whole
patchset.
