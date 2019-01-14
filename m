Received: from eggs.gnu.org ([209.51.188.92]:58526)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1givfJ-0006Bx-LO
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 01:24:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1givfJ-0003WG-0y
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 01:24:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1givfI-0003VD-R8
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 01:24:04 -0500
Date: Mon, 14 Jan 2019 07:15:45 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190114061545.w27vjvwxbf3ucnds@sirius.home.kraxel.org>
References: <20190111093116.17188-1-kraxel@redhat.com>
	<20190111093116.17188-2-kraxel@redhat.com>
	<fe14541c-8b57-014c-3972-113ce60161a1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe14541c-8b57-014c-3972-113ce60161a1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] vfio: update kernel headers.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, intel-gvt-dev@lists.freedesktop.org

On Fri, Jan 11, 2019 at 09:32:43AM -0600, Eric Blake wrote:
> On 1/11/19 3:31 AM, Gerd Hoffmann wrote:
> > Temporary, for testing convinience.
> 
> convenience
> 
> > 
> > Once qemu master is synced with the linux 5.0-rc1 headers
> > this is not needed any more.
> 
> What's the timeline for when that patch will happen, compared to whether
> we want this one now followed by a revert?

Paolo already posted patches to the list, I expect it to be merged within
days.  So, easiest would be to just wait for that to happen, then drop
the patch.

cheers,
  Gerd
