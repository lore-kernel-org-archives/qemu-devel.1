Received: from eggs.gnu.org ([2001:4830:134:3::10]:38493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dKiyR-0002Pb-0w
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:22:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dKiyN-00063T-3l
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:22:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54408)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dKiyM-00063A-TX
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 06:22:55 -0400
Message-ID: <1497349375.8068.3.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 13 Jun 2017 12:22:55 +0200
In-Reply-To: <dc2d2f2f-0c82-fa8f-9da1-b183fc203110@accelerated.com>
References: <dc2d2f2f-0c82-fa8f-9da1-b183fc203110@accelerated.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] usb-host: support devices with
 sparse/non-sequential USB interfaces
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Brian <sam.brian@accelerated.com>, qemu-devel@nongnu.org

On Tue, 2017-06-13 at 14:17 +1000, Samuel Brian wrote:
> This change allows sparse USB interface numbering.
> Instead of only claiming the interfaces in the range reported by the
> USB
> device through bNumInterfaces, QEMU attempts to claim all possible
> interfaces.

Patch looks good but fails to apply.  Thunderbird wrapped lines and
corrupted the patch.

Please resend using "git send-email" to avoid that.

thanks,
  Gerd
