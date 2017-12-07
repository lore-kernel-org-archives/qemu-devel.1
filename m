Received: from eggs.gnu.org ([2001:4830:134:3::10]:60508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eN0Mt-0005U1-Ss
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 12:53:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eN0Mq-0007zw-P9
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 12:53:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35782)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eN0Mq-0007yA-J1
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 12:53:52 -0500
Date: Thu, 7 Dec 2017 19:53:45 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171207195327-mutt-send-email-mst@kernel.org>
References: <20171129174428.27548-1-ppandit@redhat.com>
	<20171130145420.GB15942@stefanha-x1.localdomain>
	<nycvar.YSQ.7.76.1711302341010.9413@wniryva>
	<nycvar.YSQ.7.76.1712071234520.16858@wniryva>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.1712071234520.16858@wniryva>
Subject: Re: [Qemu-devel] [PATCH v4 0/2] check VirtiQueue Vring objects
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: P J P <ppandit@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, zhangboxian <zhangboxian@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Dec 07, 2017 at 12:37:42PM +0530, P J P wrote:
> +-- On Thu, 30 Nov 2017, P J P wrote --+
> | +-- On Thu, 30 Nov 2017, Stefan Hajnoczi wrote --+
> | | Michael is the virtio maintainer.  I have added him to this email
> | | thread so the patch series can be merged.
> 
>   -> https://lists.gnu.org/archive/html/qemu-devel/2017-11/msg05473.html
> 
> @mst: this qtest is not pulled in it seems.
> 
> Thank you.

That can wait until after the release, pls ping me then.

> --
> Prasad J Pandit / Red Hat Product Security Team
> 47AF CE69 3A90 54AA 9045 1053 DD13 3D32 FE5B 041F
