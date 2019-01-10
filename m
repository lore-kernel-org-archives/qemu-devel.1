Received: from eggs.gnu.org ([209.51.188.92]:42980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghVDS-0004ju-78
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 02:57:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghVCI-0004Cr-Go
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 02:56:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36078)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ghVCI-0004BZ-BU
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 02:56:14 -0500
Date: Thu, 10 Jan 2019 08:56:11 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190110075611.bylgxwm6gsdwuzms@sirius.home.kraxel.org>
References: <20190107184404.31993-1-fziglio@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190107184404.31993-1-fziglio@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] spice: Remove unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frediano Ziglio <fziglio@redhat.com>
Cc: qemu-devel@nongnu.org, spice-devel@lists.freedesktop.org

On Mon, Jan 07, 2019 at 06:44:04PM +0000, Frediano Ziglio wrote:
> The definitions in the header are not  used.
> Also this fixes porting SPICE to Windows where the header is not
> available.

Added to ui queue.

thanks,
  Gerd
