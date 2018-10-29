Received: from eggs.gnu.org ([2001:4830:134:3::10]:53496)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH48Y-0004p5-CM
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 05:47:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH48T-0000zk-Ek
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 05:47:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gH48T-0000zG-7r
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 05:47:01 -0400
Date: Mon, 29 Oct 2018 10:46:59 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181029094659.hz6i4dkm5s3arugs@sirius.home.kraxel.org>
References: <1539946236-18028-1-git-send-email-liq3ea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539946236-18028-1-git-send-email-liq3ea@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] hw: ccid-card-emulated: fix some
 resources leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@gmail.com>
Cc: qemu-devel@nongnu.org, liq3ea@163.com

On Fri, Oct 19, 2018 at 03:50:34AM -0700, Li Qiang wrote:
> 
> Li Qiang (2):
>   hw: ccid-card-emulated: introduce clean_event_notifier
>   hw: ccid-card-emulated: cleanup resource when realize in error path

Added to usb queue.

thanks,
  Gerd
