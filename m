Received: from eggs.gnu.org ([209.51.188.92]:52115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gs3Ez-0000x6-Lz
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 05:18:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gs3Et-00062e-VR
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 05:18:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38946)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gs3Ej-0005zW-F0
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 05:18:23 -0500
Date: Fri, 8 Feb 2019 11:18:17 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190208101817.i46xkvyw2fxqgzot@sirius.home.kraxel.org>
References: <1549460216-25808-1-git-send-email-liam.merwick@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1549460216-25808-1-git-send-email-liam.merwick@oracle.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/9] Dealing with Null devices in
 usb_ep_get()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Liam Merwick <liam.merwick@oracle.com>
Cc: qemu-devel@nongnu.org, darren.kenny@oracle.com

On Wed, Feb 06, 2019 at 01:36:47PM +0000, Liam Merwick wrote:
> This series is in response to feedback from Gerd Hoffman (below) on 
> <1548859022-3969-1-git-send-email-liam.merwick@oracle.com>
> 
> Instead of checking if usb_ep_get() returns NULL, ensure it never is passed
> a NULL device.

Added all to usb queue.

thanks,
  Gerd
