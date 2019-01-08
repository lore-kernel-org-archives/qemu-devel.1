Received: from eggs.gnu.org ([209.51.188.92]:40176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=904c6e83a=anthony.perard@citrix.com>)
	id 1ggsZX-0001Qg-HE
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:41:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=904c6e83a=anthony.perard@citrix.com>)
	id 1ggsZU-0001HY-Dd
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 09:41:38 -0500
Date: Tue, 8 Jan 2019 14:41:10 +0000
From: Anthony PERARD <anthony.perard@citrix.com>
Message-ID: <20190108144110.GG1508@perard.uk.xensource.com>
References: <20181220171439.11159-1-paul.durrant@citrix.com>
	<20181220171439.11159-17-paul.durrant@citrix.com>
	<20190104163124.GE1508@perard.uk.xensource.com>
	<da727b0b8a9a4f9baa47a660298a9cba@AMSPEX02CL03.citrite.net>
	<20190108125321.GD11492@linux.fritz.box>
	<904d305f8c0f4aac8e60fb7ea14ebd41@AMSPEX02CL03.citrite.net>
	<20190108132823.GF1508@perard.uk.xensource.com>
	<4198c56b893a4539a4d27eea5dad71ec@AMSPEX02CL03.citrite.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4198c56b893a4539a4d27eea5dad71ec@AMSPEX02CL03.citrite.net>
Subject: Re: [Qemu-devel] [PATCH v7 16/18] xen: automatically create
 XenBlockDevice-s
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <Paul.Durrant@citrix.com>
Cc: 'Kevin Wolf' <kwolf@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, Max Reitz <mreitz@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>

> I've tested your patch and it does seem like the best way forward. I'll squash it in. Do you want me to put your S-o-b on the combined patch?

You can, I'll have to add it anyway when I'll prepare the pull request.

Thanks,

-- 
Anthony PERARD
