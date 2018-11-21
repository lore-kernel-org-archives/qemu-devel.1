Received: from eggs.gnu.org ([2001:4830:134:3::10]:56588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gPPeI-0001wy-A6
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 05:22:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gPPeE-00005E-Cc
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 05:22:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48494)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gPPeE-0008S6-7R
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 05:22:18 -0500
Date: Wed, 21 Nov 2018 11:22:15 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181121102215.ctlw6yy45dzic3cq@sirius.home.kraxel.org>
References: <B328F08581D714418202ABF306D3781C3B774417@dggeml509-mbx.china.huawei.com>
	<20181120152325.ekxhvjndzgflijvb@sirius.home.kraxel.org>
	<B328F08581D714418202ABF306D3781C3B776FA6@dggeml509-mbx.china.huawei.com>
	<20181121082307.3fa3nd7cuu3canx4@sirius.home.kraxel.org>
	<994425cd-c99e-f69f-9fac-fbd7d2edf470@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <994425cd-c99e-f69f-9fac-fbd7d2edf470@huawei.com>
Subject: Re: [Qemu-devel]
 =?utf-8?b?562U5aSNOiAgQ2FuJ3Qgc2VlIG1vdXNlIGN1cnNv?=
 =?utf-8?q?r_on_VNC_viewer?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Heyi Guo <guoheyi@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Wed, Nov 21, 2018 at 04:54:15PM +0800, Heyi Guo wrote:
> Hi Gerd,
> 
> Is there any hacking way to turn off hardware cursor support for virtio-gpu, and make the cursor also be rendered to the framebuffer?

Well, you can configure xorg in the guest to force software cursor mode.

cheers,
  Gerd
