Received: from eggs.gnu.org ([2001:4830:134:3::10]:44918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1einfK-0007Xr-FB
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 15:47:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1einfJ-0001A9-N5
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 15:47:02 -0500
Date: Mon, 5 Feb 2018 20:46:55 +0000
From: "Richard W.M. Jones" <rjones@redhat.com>
Message-ID: <20180205204655.GQ2787@redhat.com>
References: <20180205202232.19254-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180205202232.19254-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] block/ssh: Implement
 .bdrv_refresh_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>


I assume the context of all this is making relative backing file names work
in qcow2 files?

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html
