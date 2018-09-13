Received: from eggs.gnu.org ([2001:4830:134:3::10]:33305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g0QCe-00089D-7F
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 07:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1g0QCb-0006XI-18
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 07:54:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1g0QCa-0006Ut-QA
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 07:54:28 -0400
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com
	[10.5.11.25])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3DE75CAA9C
	for <qemu-devel@nongnu.org>; Thu, 13 Sep 2018 11:54:27 +0000 (UTC)
Date: Thu, 13 Sep 2018 13:54:22 +0200
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20180913115422.6tkhn2rppksrxej7@sirius.home.kraxel.org>
References: <20180907220851.9658-1-bsd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907220851.9658-1-bsd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] Misc usb-mtp fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bandan Das <bsd@redhat.com>
Cc: qemu-devel@nongnu.org

On Fri, Sep 07, 2018 at 06:08:48PM -0400, Bandan Das wrote:
> v2:
> Same as v1 but with another minor cleanup
> patch. The write buffer breakup is still WIP.
> 
> A documentation fix and changes to return the
> right error code on write failures.

Added to usb queue.

thanks,
  Gerd
