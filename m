Received: from eggs.gnu.org ([2001:4830:134:3::10]:51801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH44Q-0002S2-Nx
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 05:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH44L-0005sf-QH
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 05:42:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51566)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gH44L-0005jC-K9
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 05:42:45 -0400
Date: Mon, 29 Oct 2018 10:42:26 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181029094226.nfnrnietxyjuwjsx@sirius.home.kraxel.org>
References: <1540263618-18344-1-git-send-email-liq3ea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540263618-18344-1-git-send-email-liq3ea@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] usb: ohci: make num_ports to an unsinged
 integer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: qemu-devel@nongnu.org

On Mon, Oct 22, 2018 at 08:00:18PM -0700, Li Qiang wrote:
> This can avoid setting OCHIState.num_ports to a negative num.

Added to usb queue.

thanks,
  Gerd
