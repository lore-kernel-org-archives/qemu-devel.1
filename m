Received: from eggs.gnu.org ([209.51.188.92]:37073)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmZgd-00077n-Rt
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 02:44:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gmZgU-0008Ob-W1
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 02:44:26 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51760)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gmZgS-0008E7-UK
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 02:44:22 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9FD1AC0C8CDB
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 07:44:18 +0000 (UTC)
Date: Thu, 24 Jan 2019 08:44:12 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190124074412.ovppgop2mey3jxeb@sirius.home.kraxel.org>
References: <1548254454-7659-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1548254454-7659-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/usb: Fix LGPL information in the file
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org

On Wed, Jan 23, 2019 at 03:40:54PM +0100, Thomas Huth wrote:
> It's either "GNU *Library* General Public version 2" or "GNU Lesser
> General Public version *2.1*", but there was no "version 2.0" of the
> "Lesser" library. So assume that version 2.1 is meant here.
> Additionally, suggest that the user should have received a copy of
> the LGPL, and not the GPL here.

Added to usb queue.

thanks,
  Gerd
