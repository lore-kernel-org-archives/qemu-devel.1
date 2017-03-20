Received: from eggs.gnu.org ([2001:4830:134:3::10]:53676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cpnGr-0006Hj-EF
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 22:42:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cpnGn-0004RA-Ed
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 22:42:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35690)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cpnGn-0004Qy-8K
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 22:42:05 -0400
Date: Mon, 20 Mar 2017 10:41:53 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170320024153.GJ17405@pxdev.xzpeter.org>
References: <1486456099-7345-1-git-send-email-peterx@redhat.com>
	<1486456099-7345-18-git-send-email-peterx@redhat.com>
	<20170316040526.GJ5971@pxdev.xzpeter.org>
	<CAM3WwMiuSG3KGEg7WnN7fhxi-0Yswtsk1Wnh_uVSeuN1HZSLaQ@mail.gmail.com>
	<20170320015654.GI17405@pxdev.xzpeter.org>
	<A2975661238FB949B60364EF0F2C25743901F039@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C25743901F039@shsmsx102.ccr.corp.intel.com>
Subject: Re: [Qemu-devel] [PATCH v7 17/17] intel_iommu: enable vfio devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: "Aviv B.D." <bd.aviv@gmail.com>, "Lan, Tianyu" <tianyu.lan@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Alex Williamson <alex.williamson@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Mon, Mar 20, 2017 at 02:12:15AM +0000, Liu, Yi L wrote:
> Hi Peter,
> 
> How about the merge of this series? I'm also trying to rebase my work and prepare to send
> out RFC patch.

We may need to wait until QEMU 2.10. I have no plan of content change
in next repost (just remove some merged patches, and some tweaks in
commit messages), so even another rebase shouldn't be too hard.

If you have RFC already for your work, IMHO it's okay you just post it
out, mark "RFC for 2.10" in subject, and mention that the series will
be pending on v7 of vtd vfio series, so that review can start earlier.

Thanks,

-- peterx
