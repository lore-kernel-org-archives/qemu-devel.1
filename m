Received: from eggs.gnu.org ([2001:4830:134:3::10]:42890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1cErVc-00063E-I7
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 00:44:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1cErVZ-0002Av-J6
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 00:44:44 -0500
Received: from mga02.intel.com ([134.134.136.20]:22982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1cErVZ-0002AJ-AR
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 00:44:41 -0500
References: <20161202065214.GF21601@pxdev.xzpeter.org>
	<088c2afd-575e-99af-1686-023c116352ab@intel.com>
	<20161206065155.GB4344@pxdev.xzpeter.org>
	<6d37d046-8e5a-7662-baa6-445d3985fde7@intel.com>
	<20161206072228.GC4344@pxdev.xzpeter.org>
	<f9f9daab-519d-381b-c9e8-c6dcc139f1d3@intel.com>
	<20161206105914.GB3469@pxdev.xzpeter.org>
	<1b348745-3135-e28c-88f3-f45ed1855de3@intel.com>
	<20161207064322.GA28693@pxdev.xzpeter.org>
	<c1f4b99f-1bfd-9742-b8ca-360fa6fa609c@intel.com>
	<20161208023849.GF28693@pxdev.xzpeter.org>
From: Lan Tianyu <tianyu.lan@intel.com>
Message-ID: <bcdff4de-8c4a-f213-3e22-bcc17227ef02@intel.com>
Date: Thu, 8 Dec 2016 13:41:19 +0800
MIME-Version: 1.0
In-Reply-To: <20161208023849.GF28693@pxdev.xzpeter.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v7 0/5] IOMMU: intel_iommu support map and
 unmap notifications
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: "Aviv B.D" <bd.aviv@gmail.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, Alex Williamson <alex.williamson@redhat.com>, Jason Wang <jasowang@redhat.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Wu, Fengguang" <fengguang.wu@intel.com>

On 2016年12月08日 10:39, Peter Xu wrote:
> Btw, do you have time to help review my RFC series for "vt-d replay"?
> :) I'd like to receive any further review comments besides the issues
> mentioned above since IMHO they can be seperated from current series,
> I have noted them down in my pending list.
Sure. I have reviewed some patches. It looks good for me :)

-- 
Best regards
Tianyu Lan
