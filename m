Received: from eggs.gnu.org ([209.51.188.92]:40295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqwoU-0003Tv-NO
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 04:14:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gqwoS-0006By-R6
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 04:14:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53026)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gqwoP-0005ih-4D
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 04:14:38 -0500
Date: Tue, 5 Feb 2019 10:14:18 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190205091418.h7ajw5sscy4dg3nr@sirius.home.kraxel.org>
References: <23B229B3-3095-4DFB-8369-866784808D30@me.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23B229B3-3095-4DFB-8369-866784808D30@me.com>
Subject: Re: [Qemu-devel] [PATCH v2] ui/egl-helpers: Augment parameter list
 of egl_texture_blend() to convey scales of viewport
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chen Zhang <tgfbeta@me.com>
Cc: qemu-devel@nongnu.org

On Fri, Jan 25, 2019 at 03:47:23PM +0800, Chen Zhang wrote:
> From 0be823a56682be57fe0370bb91e4062ec7b47be5 Mon Sep 17 00:00:00 2001
> From: Chen Zhang <tgfbeta@me.com>
> Date: Fri, 25 Jan 2019 15:33:08 +0800
> Subject: [PATCH v2] ui/egl-helpers: Augment parameter list of
>  egl_texture_blend() to convey scales of viewport.
> 
>  This would help gtk-egl display showing scaled DMABuf cursor images when
>  gtk window was zoomed. A default scale of (1.0, 1.0) was presumed for
>  call sites where no scaling is needed.

Added to UI patch queue.

thanks,
  Gerd
