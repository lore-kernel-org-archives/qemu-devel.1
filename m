Received: from eggs.gnu.org ([2001:4830:134:3::10]:50093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dAyav-0001jb-Iv
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:02:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dAyau-0000nr-Oe
	for qemu-devel@nongnu.org; Wed, 17 May 2017 09:02:25 -0400
Date: Wed, 17 May 2017 15:01:56 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170517130156.GB12936@noname.redhat.com>
References: <1494961859-14833-1-git-send-email-sbates@raithlin.com>
	<20170516204327.GB28520@localhost.localdomain>
	<901A5622-D0D7-41E8-9631-0D0B9D657EB3@raithlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <901A5622-D0D7-41E8-9631-0D0B9D657EB3@raithlin.com>
Subject: Re: [Qemu-devel] [PATCH] nvme: Add support for Controller Memory
 Buffers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephen Bates <sbates@raithlin.com>
Cc: Keith Busch <keith.busch@intel.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mreitz@redhat.com" <mreitz@redhat.com>

Am 17.05.2017 um 04:22 hat Stephen  Bates geschrieben:
> > Awesome, this looks great!
> >
> > Acked-by: Keith Busch <keith.busch@intel.com>
> 
> Thanks Keith!
> 
> I still seem to be having issues getting my patches onto the qemu-*
> mailing lists. Does anyone have any idea how I go about rectifying
> that?

This mail seems to have made it to the list, but the patch hasn't.
Looking at the headers, you don't seem to use the same server for
your normal mail client and git send-email. Maybe it's related to this?

Anyway, thanks, applied to the block branch.

Kevin
