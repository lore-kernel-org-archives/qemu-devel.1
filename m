Received: from eggs.gnu.org ([2001:4830:134:3::10]:42879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <herbert@gondor.apana.org.au>) id 1fVHgc-0005Mq-Ih
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 10:32:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <herbert@gondor.apana.org.au>) id 1fVHgY-0003pJ-Fb
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 10:32:46 -0400
Received: from orcrist.hmeau.com ([104.223.48.154]:39642
	helo=deadmen.hmeau.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <herbert@gondor.apana.org.au>)
	id 1fVHgY-0003gn-1X
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 10:32:42 -0400
Date: Tue, 19 Jun 2018 22:32:30 +0800
From: Herbert Xu <herbert@gondor.apana.org.au>
Message-ID: <20180619143230.zjemmhhz7embs2li@gondor.apana.org.au>
References: <cover.1528921468.git.alifm@linux.ibm.com>
	<44ccc5db-e1d4-27b7-8942-c77f467f422e@linux.ibm.com>
	<0c5d7e42-e6c5-6aa2-8c1b-487c8cc9eb21@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c5d7e42-e6c5-6aa2-8c1b-487c8cc9eb21@de.ibm.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Farhan Ali <alifm@linux.ibm.com>, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com, qemu-devel@nongnu.org, arei.gonglei@huawei.com, longpeng2@huawei.com, pasic@linux.ibm.com, frankja@linux.ibm.com, Jason Wang <jasowang@redhat.com>

On Tue, Jun 19, 2018 at 04:08:05PM +0200, Christian Borntraeger wrote:
> On 06/19/2018 03:26 PM, Farhan Ali wrote:
> > A polite ping :)
> > 
> > If no one has any more comments/feedback then I would like to how to merge these patches to the mainline kernel tree.
> 
> I think it should go via Michael Tsirkin or Jason Wang (Adding Jason).
> Also adding Herbert Xu as FYI.
> 
> 
> I have not looked into the details of the patch, but I like the idea.
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

Please post crypto patches to linux-crypto.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
