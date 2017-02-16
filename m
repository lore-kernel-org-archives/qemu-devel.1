Received: from eggs.gnu.org ([2001:4830:134:3::10]:38898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cePWO-0008Bq-TK
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:07:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cePWK-00047h-VS
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:07:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:16535)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jcody@redhat.com>) id 1cePWK-00047Z-Pw
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 12:07:04 -0500
Date: Thu, 16 Feb 2017 12:07:02 -0500
From: Jeff Cody <jcody@redhat.com>
Message-ID: <20170216170702.GG8801@localhost.localdomain>
References: <CAJSP0QWX0_stkyrkyL42QFFnnBTaqYD+XYmpMBO0gY2pWFD53g@mail.gmail.com>
	<20170216154707.GE19045@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170216154707.GE19045@localhost.localdomain>
Subject: Re: [Qemu-devel] Missing rewrite rule for qemu.org/images/ links
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com

On Thu, Feb 16, 2017 at 10:47:07AM -0500, Jeff Cody wrote:
> On Thu, Feb 16, 2017 at 03:30:25PM +0000, Stefan Hajnoczi wrote:
> > Hi Jeff,
> > The old qemu.org/images/ links are not being rewritten to
> > wiki.qemu-project.org/images/.
> > 
> > For example, http://www.qemu-project.org/images/4/4e/Q35.pdf no longer works:
> > https://bugs.launchpad.net/qemu/+bug/1665344
> > 
> > I do notice that qemu.org/Features/Q35 is working.  Is it possible to
> > set up a rewrite rule or HTTP redirect so existing /images/ links keep
> > working?
> > 
> > Thanks,
> > Stefan
> 
> Thanks for noticing, and pointing that out.  I'll get right on that.
>

Fixed now.

-Jeff
