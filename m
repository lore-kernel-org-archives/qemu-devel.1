Received: from eggs.gnu.org ([2001:4830:134:3::10]:49233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cwR9T-0001LI-9p
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 06:30:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cwR9P-0002Uz-2r
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 06:29:59 -0400
Message-ID: <1491560992.26308.42.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 07 Apr 2017 12:29:52 +0200
In-Reply-To: <20170403114044.15762-1-lvivier@redhat.com>
References: <20170403114044.15762-1-lvivier@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] virtio-gpu: replace PIXMAN_* by PIXMAN_BE_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On Mo, 2017-04-03 at 13:40 +0200, Laurent Vivier wrote:
> This avoids a "#ifdef HOST_WORDS_BIGENDIAN" and this is the purpose
> of PIXMAN_BE_* macros.

Added to vga queue (for 2.10).

thanks,
  Gerd
