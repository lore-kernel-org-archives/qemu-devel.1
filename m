Received: from eggs.gnu.org ([209.51.188.92]:35549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqwUs-0004gp-9i
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 03:54:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqwUp-0003iq-W4
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 03:54:25 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36200)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gqwUp-0003iD-M9
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 03:54:23 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DBF14C05B032
	for <qemu-devel@nongnu.org>; Tue,  5 Feb 2019 08:54:22 +0000 (UTC)
Date: Tue, 5 Feb 2019 09:54:18 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190205085418.ada2ndvknni7czgn@sirius.home.kraxel.org>
References: <20190204120823.41333-1-slp@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190204120823.41333-1-slp@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] ui: listen for GDK_SMOOTH_SCROLL events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sergio Lopez <slp@redhat.com>
Cc: qemu-devel@nongnu.org

On Mon, Feb 04, 2019 at 01:08:23PM +0100, Sergio Lopez wrote:
> On Wayland, without grabbing focus, two-finger scrolling generates
> GDK_SMOOTH_SCROLL events instead of GDK_SCROLL_*, so listen for them.
> 
> Signed-off-by: Sergio Lopez <slp@redhat.com>

Added to UI queue.

thanks,
  Gerd
