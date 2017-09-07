Received: from eggs.gnu.org ([2001:4830:134:3::10]:49199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpvDf-0006ML-V6
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 07:43:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpvDb-0004Ju-41
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 07:43:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53132)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dpvDa-0004Jc-U2
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 07:43:35 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id ECFA834CD
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 11:43:33 +0000 (UTC)
Date: Thu, 7 Sep 2017 19:43:29 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170907114329.GD25123@lemon.lan>
References: <20170907082918.7299-1-famz@redhat.com>
	<1504776868.15653.6.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504776868.15653.6.camel@redhat.com>
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
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, 09/07 11:34, Gerd Hoffmann wrote:
> On Thu, 2017-09-07 at 16:29 +0800, Fam Zheng wrote:
> > Hi Gerd,
> > 
> > This is part two of the QEMU_CFLAGS and libs_softmmu cleanup series,
> > including
> > ui/, audio/ and hw/usb/. Please review.
> 
> Looks good, survived a test build.
> 
> Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>

Thanks for the quick review! Do you want to queue this in your tree? If not I
can include it in my next pull request for "build and test automation" patches.

Fam
