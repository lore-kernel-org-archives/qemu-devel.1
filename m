Received: from eggs.gnu.org ([2001:4830:134:3::10]:35983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dqCeR-0006CM-6x
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 02:20:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dqCeM-0003vJ-KI
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 02:20:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dqCeM-0003uU-DY
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 02:20:22 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6DF434E4D4
	for <qemu-devel@nongnu.org>; Fri,  8 Sep 2017 06:20:20 +0000 (UTC)
Message-ID: <1504851615.13941.0.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 08 Sep 2017 08:20:15 +0200
In-Reply-To: <20170907114329.GD25123@lemon.lan>
References: <20170907082918.7299-1-famz@redhat.com>
	<1504776868.15653.6.camel@redhat.com>
	<20170907114329.GD25123@lemon.lan>
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
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, 2017-09-07 at 19:43 +0800, Fam Zheng wrote:
> On Thu, 09/07 11:34, Gerd Hoffmann wrote:
> > On Thu, 2017-09-07 at 16:29 +0800, Fam Zheng wrote:
> > > Hi Gerd,
> > > 
> > > This is part two of the QEMU_CFLAGS and libs_softmmu cleanup
> > > series,
> > > including
> > > ui/, audio/ and hw/usb/. Please review.
> > 
> > Looks good, survived a test build.
> > 
> > Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
> 
> Thanks for the quick review! Do you want to queue this in your tree?
> If not I
> can include it in my next pull request for "build and test
> automation" patches.

Feel free do include it in your pull.  I assumed that is your intention
anyway as you've asked for review not merge ;)

cheers,
  Gerd
