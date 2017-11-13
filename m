Received: from eggs.gnu.org ([2001:4830:134:3::10]:59465)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eEEhX-0008Ed-LJ
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:23:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eEEhS-0006Ze-Ov
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:22:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eEEhS-0006Y3-IJ
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:22:54 -0500
Date: Mon, 13 Nov 2017 14:22:52 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20171113132252.utcrduc6djrhk35s@sirius.home.kraxel.org>
References: <903d8048-77e9-4a30-d8e1-56ccd8b6a6bc@amsat.org>
	<20171112193032.9724-1-makovick@gmail.com>
	<20171112193032.9724-6-makovick@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171112193032.9724-6-makovick@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 5/8] sdl2 uses surface relative coordinates
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jindrich Makovicka <makovick@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Cole Robinson <crobinso@redhat.com>

On Sun, Nov 12, 2017 at 08:30:29PM +0100, Jindrich Makovicka wrote:
> This patch fixes mouse positioning with -device usb-tablet and fullscreen
> or resized window.

Fails checkpatch too (long lines).

Also: can you add a "Fixes: 46522a82236ea0cf9011b89896d2d8f8ddaf2443"
line (that is the commit which added the bug).

thanks,
  Gerd
