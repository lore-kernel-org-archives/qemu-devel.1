Received: from eggs.gnu.org ([2001:4830:134:3::10]:53466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <keith.busch@intel.com>) id 1d86ew-0005Ri-7Z
	for qemu-devel@nongnu.org; Tue, 09 May 2017 11:02:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <keith.busch@intel.com>) id 1d86ev-0006m1-Gd
	for qemu-devel@nongnu.org; Tue, 09 May 2017 11:02:42 -0400
Date: Tue, 9 May 2017 11:09:32 -0400
From: Keith Busch <keith.busch@intel.com>
Message-ID: <20170509150932.GA2572@localhost.localdomain>
References: <20170505095807.3296-1-hch@lst.de>
	<20170509150104.GF5243@noname.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170509150104.GF5243@noname.str.redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] nvme: Implement Write Zeroes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org

On Tue, May 09, 2017 at 05:01:04PM +0200, Kevin Wolf wrote:
> Am 05.05.2017 um 11:58 hat Christoph Hellwig geschrieben:
> > Signed-off-by: Keith Busch <keith.busch@intel.com>
> > [hch: ported over from qemu-nvme.git to mainline]
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> 
> Keith, can you give an Acked-by for this one? (I see that the code is
> originally from you, but just to make sure that you agree with the
> changes made and that it is merged into qemu.git this way.)

No problem, this still looks good to me. Thanks!

Acked-by: Keith Busch <keith.busch@intel.com>
