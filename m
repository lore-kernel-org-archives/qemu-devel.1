Received: from eggs.gnu.org ([209.51.188.92]:35047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1go9P6-00011z-Oe
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:04:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1go9P6-0002y7-5c
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 11:04:56 -0500
Date: Mon, 28 Jan 2019 17:04:39 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190128160439.GG5756@localhost.localdomain>
References: <20190122145132.12571-1-paul.durrant@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122145132.12571-1-paul.durrant@citrix.com>
Subject: Re: [Qemu-devel] [PATCH] hw/block: clean up stake xen_disk trace
 entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paul Durrant <paul.durrant@citrix.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 22.01.2019 um 15:51 hat Paul Durrant geschrieben:
> This should have been removed then xen_disk.c was removed but I missed them.
> 
> Signed-off-by: Paul Durrant <paul.durrant@citrix.com>

Thanks, fixed up the commit message and applied to the block branch.

Kevin
