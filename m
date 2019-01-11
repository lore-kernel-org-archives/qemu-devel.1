Received: from eggs.gnu.org ([209.51.188.92]:48957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghuIV-0007Uc-Rp
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:44:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghuIV-0001C4-7a
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:44:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ghuIV-0001Bz-1o
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 05:44:19 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 54C221B7A
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 10:44:18 +0000 (UTC)
Date: Fri, 11 Jan 2019 11:44:14 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20190111104414.dlzzbc7djkn2va2f@sirius.home.kraxel.org>
References: <20190111082043.31412-1-bsd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190111082043.31412-1-bsd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/2 v2] Break down the MTP write operation
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

On Fri, Jan 11, 2019 at 03:20:41AM -0500, Bandan Das wrote:
> v2:
>   Rebased on top of master and retested

Thanks.  Added to usb queue.

cheers,
  Gerd
