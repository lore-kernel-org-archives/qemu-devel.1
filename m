Received: from eggs.gnu.org ([2001:4830:134:3::10]:37123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eEEt4-00070a-PO
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:34:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eEEt0-0004Qa-RD
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:34:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51504)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eEEt0-0004P5-JC
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 08:34:50 -0500
Date: Mon, 13 Nov 2017 14:34:48 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20171113133448.wordoerf5cakol4h@sirius.home.kraxel.org>
References: <903d8048-77e9-4a30-d8e1-56ccd8b6a6bc@amsat.org>
	<20171112193032.9724-1-makovick@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171112193032.9724-1-makovick@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3] SDL2 various fixes
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

On Sun, Nov 12, 2017 at 08:30:24PM +0100, Jindrich Makovicka wrote:
> Hi,
> 
> here is an identical patchset with Signed-off-by.

Please post a new version without reply-to.

Queued up four patches:
  sdl2: Do not leave grab when fullscreen
  sdl2: Fix dead keyboard after fullsceen
  sdl2: Use the same pointer show/hide logic for absolute and relative mode
  sdl2: Do not quit the emulator when an auxilliary window is closed

See: https://www.kraxel.org/cgit/qemu/log/?h=queue/ui

The other ones need some clarification / testing / fixups, see
individual replies.

cheers,
  Gerd
