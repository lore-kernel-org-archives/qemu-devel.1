Received: from eggs.gnu.org ([2001:4830:134:3::10]:34989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dptCq-0002j7-Iz
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dptCm-00064Z-1P
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:34:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dptCl-00064O-Sz
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 05:34:35 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 05B5D81DEF
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 09:34:35 +0000 (UTC)
Message-ID: <1504776868.15653.6.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 07 Sep 2017 11:34:28 +0200
In-Reply-To: <20170907082918.7299-1-famz@redhat.com>
References: <20170907082918.7299-1-famz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 0/9] buildsys: Move ui/usb library
 cflags/libs to per object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org

On Thu, 2017-09-07 at 16:29 +0800, Fam Zheng wrote:
> Hi Gerd,
> 
> This is part two of the QEMU_CFLAGS and libs_softmmu cleanup series,
> including
> ui/, audio/ and hw/usb/. Please review.

Looks good, survived a test build.

Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

cheers,
  Gerd
