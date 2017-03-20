Received: from eggs.gnu.org ([2001:4830:134:3::10]:47764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cpmZJ-0002Df-Do
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 21:57:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cpmZG-00019W-CE
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 21:57:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cpmZG-00018b-6T
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 21:57:06 -0400
Date: Mon, 20 Mar 2017 09:56:54 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170320015654.GI17405@pxdev.xzpeter.org>
References: <1486456099-7345-1-git-send-email-peterx@redhat.com>
	<1486456099-7345-18-git-send-email-peterx@redhat.com>
	<20170316040526.GJ5971@pxdev.xzpeter.org>
	<CAM3WwMiuSG3KGEg7WnN7fhxi-0Yswtsk1Wnh_uVSeuN1HZSLaQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAM3WwMiuSG3KGEg7WnN7fhxi-0Yswtsk1Wnh_uVSeuN1HZSLaQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v7 17/17] intel_iommu: enable vfio devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Aviv B.D." <bd.aviv@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, tianyu.lan@intel.com, kevin.tian@intel.com, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alex Williamson <alex.williamson@redhat.com>

On Sun, Mar 19, 2017 at 05:34:31PM +0200, Aviv B.D. wrote:
> Hi Peter,
> Thanks, I think that I should receive credit for this patch.
> 
> Please attribute it under my technion mail: bdaviv@cs.technion.ac.il.
> 
> The signed-off line should be:
> 
> Signed-off-by: Aviv Ben-David <bdaviv@cs.technion.ac.il>

No problem. I'll update in next post. Thanks,

-- peterx
