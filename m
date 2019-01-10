Received: from eggs.gnu.org ([209.51.188.92]:55667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghW4S-0000yj-Sq
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:52:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghW4S-0000Dn-Aq
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 03:52:12 -0500
Date: Thu, 10 Jan 2019 09:52:06 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190110085206.ain25ervr4aduqyb@sirius.home.kraxel.org>
References: <1546614146-10525-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1546614146-10525-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/audio/marvell: Don't include
 unnecessary i2c.h header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Jan Kiszka <jan.kiszka@web.de>, qemu-arm@nongnu.org

On Fri, Jan 04, 2019 at 04:02:26PM +0100, Thomas Huth wrote:
> This device does not use I2C, so no need to include the header file here.

Added to audio queue.

thanks,
  Gerd
