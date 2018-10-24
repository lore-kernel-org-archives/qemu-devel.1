Received: from eggs.gnu.org ([2001:4830:134:3::10]:45986)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gFHSH-0000vW-Vt
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:36:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gFHLR-000096-Lm
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:29:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gFHLR-00008q-G2
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 07:29:01 -0400
Date: Wed, 24 Oct 2018 12:28:52 +0100
From: Peter Xu <peterx@redhat.com>
Message-ID: <20181024112852.GC12892@xz-x1.hotspot.internet-for-guests.com>
References: <20181023234112.188140-1-mst@redhat.com>
	<CAFEAcA_SPT=Ypyep9QgdyjKyFCFTjnH_ZG+99H008HCpnhbFqg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA_SPT=Ypyep9QgdyjKyFCFTjnH_ZG+99H008HCpnhbFqg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 00/28] pci, pc, virtio: fixes, features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Wed, Oct 24, 2018 at 07:21:17AM +0100, Peter Maydell wrote:
> >  dtc                                  |   2 +-
> 
> Hi. This pull request seems to include an accidental update
> to the dtc submodule. It's in the "intel_iommu: move ce fetching out
> when sync shadow" commit, and it's not mentioned in the commit
> message, so I am assuming it is unintentional.
> 
> Could you fix that and resubmit, please?

It's my fault.

Michael, please let me know if you want me to post that single patch
again without that.

Regards,

-- 
Peter Xu
