Received: from eggs.gnu.org ([2001:4830:134:3::10]:59297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gP7sG-0002J5-Uw
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:23:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gP7sC-0001Vj-Vw
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:23:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gP7sC-0001V1-Oa
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 10:23:32 -0500
Date: Tue, 20 Nov 2018 16:23:25 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181120152325.ekxhvjndzgflijvb@sirius.home.kraxel.org>
References: <B328F08581D714418202ABF306D3781C3B774417@dggeml509-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B328F08581D714418202ABF306D3781C3B774417@dggeml509-mbx.china.huawei.com>
Subject: Re: [Qemu-devel] Can't see mouse cursor on VNC viewer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Guoheyi <guoheyi@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Tue, Nov 20, 2018 at 12:37:13PM +0000, Guoheyi wrote:
> Hi folks,
> 
> I'm using qemu 2.8 on ARM64 with KVM enabled, and TightVNC on MS
> Windows as a VNC viewer. We can see the graphic screen on VNC viewer,
> but we can't see the mouse cursor after we enable "Mouse Cursor -> Let
> remote server deal with cursor".

And with that option disabled?

cheers,
  Gerd
