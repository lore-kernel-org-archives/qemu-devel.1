Received: from eggs.gnu.org ([2001:4830:134:3::10]:48371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dttMe-0000uz-OE
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:33:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dttMa-0002oi-S1
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:33:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dttMa-0002oE-Kw
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 06:33:16 -0400
Message-ID: <1505730794.10119.9.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 18 Sep 2017 12:33:14 +0200
In-Reply-To: <20170918120536.6186c7fe.cohuck@redhat.com>
References: <cover.1505485574.git.alifm@linux.vnet.ibm.com>
	<6c53f939cf2d64b66d2a6878b29c9bf3820f3d5b.1505485574.git.alifm@linux.vnet.ibm.com>
	<20170918120536.6186c7fe.cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 2/2] virtio-gpu-ccw: Create a virtio gpu
 device for the ccw bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Farhan Ali <alifm@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com

  Hi,

> Gerd, if the first patch looks good to you, I can take both patches
> through the s390 tree.

Yes, please.  Just sent a reviewed-by for patch #1.

thanks,
  Gerd
