Received: from eggs.gnu.org ([209.51.188.92]:59958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hBl5X-0003mB-Iy
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 14:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hBkvb-0004L8-01
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 14:48:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55622)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hBkva-0004KG-PV
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 14:48:02 -0400
Date: Wed, 3 Apr 2019 19:47:57 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190403184757.GB2832@work-vm>
References: <20190403183143.6c98ab4e@luklap>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190403183143.6c98ab4e@luklap>
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 4.0.0-rc2 is now available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Lukas Straub <lukasstraub2@web.de>, quintela@redhat.com
Cc: mdroth@linux.vnet.ibm.com, qemu-devel@nongnu.org

* Lukas Straub (lukasstraub2@web.de) wrote:
> Hello,
> The following Patch which fixes COLO is missing:
> https://lists.nongnu.org/archive/html/qemu-devel/2019-03/msg07909.html

Yep, we need to do a migration pull for it, I've added it to the
planning/4.0 list of 'Not yet fixed in any rc'

Dave

> Regards,
> Lukas Straub
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
