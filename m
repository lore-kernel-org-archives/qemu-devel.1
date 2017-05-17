Received: from eggs.gnu.org ([2001:4830:134:3::10]:50103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dAxcL-00019o-B8
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:59:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dAxcK-0000bF-Lb
	for qemu-devel@nongnu.org; Wed, 17 May 2017 07:59:49 -0400
Date: Wed, 17 May 2017 13:59:32 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170517115932.GC4856@noname.redhat.com>
References: <20170505102153.758-1-famz@redhat.com>
	<20170517021302.GF27669@lemon.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170517021302.GF27669@lemon.lan>
Subject: Re: [Qemu-devel] [PATCH] iotests: 147: Don't test inet6 if not
 available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 17.05.2017 um 04:13 hat Fam Zheng geschrieben:
> On Fri, 05/05 18:21, Fam Zheng wrote:
> > This is the case in our docker tests, as we use --net=none there. Skip
> > this method.
> 
> Ping. Is this patch okay?

I thought you might want to respond to Dan's comment. If you don't plan
to make the change he suggests, let me know and I'll queue the patch as
it is.

Kevin
