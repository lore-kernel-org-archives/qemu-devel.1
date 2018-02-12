Received: from eggs.gnu.org ([2001:4830:134:3::10]:51391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1elDym-0005Hs-M2
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 08:17:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1elDyl-0003ND-U8
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 08:17:08 -0500
Date: Mon, 12 Feb 2018 14:16:44 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180212131644.GD5103@localhost.localdomain>
References: <20180212124718.21935-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180212124718.21935-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] iotests: Use virtio-blk in 155
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>

Am 12.02.2018 um 13:47 hat Max Reitz geschrieben:
> Only a few select machine types support floppy drives and there is
> actually nothing preventing us from using virtio here, so let's do it.
> 
> Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>

Thanks, applied to the block branch.

Kevin
