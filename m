Received: from eggs.gnu.org ([2001:4830:134:3::10]:48330)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH3mf-0004m0-Iu
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 05:24:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH3mc-0002XX-Eu
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 05:24:29 -0400
Date: Mon, 29 Oct 2018 10:24:20 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181029092420.oevomnhk2uvg3xdp@sirius.home.kraxel.org>
References: <20181024143748.4425-1-dos@dosowisko.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024143748.4425-1-dos@dosowisko.net>
Subject: Re: [Qemu-devel] [PATCH] SDL: set a hint to not bypass the window
 compositor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Sebastian Krzyszkowiak <dos@dosowisko.net>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org

On Wed, Oct 24, 2018 at 04:37:48PM +0200, Sebastian Krzyszkowiak wrote:
> Without that, window effects in KWin get suspended as soon as any
> qemu-sdl window becomes visible. While the SDL default makes sense
> for games, it's not really suitable for QEMU.
> 
> Signed-off-by: Sebastian Krzyszkowiak <dos@dosowisko.net>

Added to UI patch queue.

thanks,
  Gerd
