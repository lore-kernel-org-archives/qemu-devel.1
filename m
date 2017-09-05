Received: from eggs.gnu.org ([2001:4830:134:3::10]:46781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dpCta-0004KQ-Tj
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:24:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dpCtW-0003XK-As
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 08:23:58 -0400
Date: Tue, 5 Sep 2017 13:23:51 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170905122351.GM17449@stefanha-x1.localdomain>
References: <20170904162622.12137-1-stefanha@redhat.com>
	<20170905090303.GB4633@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170905090303.GB4633@localhost.localdomain>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v4] docs: add
 qemu-block-drivers(7) man page
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org

On Tue, Sep 05, 2017 at 11:03:03AM +0200, Kevin Wolf wrote:
> Am 04.09.2017 um 18:26 hat Stefan Hajnoczi geschrieben:
> > Block driver documentation is available in qemu-doc.html.  It would be
> > convenient to have documentation for formats, protocols, and filter
> > drivers in a man page.
> > 
> > Extract the relevant part of qemu-doc.html into a new file called
> > docs/qemu-block-drivers.texi.  This file can also be built as a
> > stand-alone document (man, html, etc).
> > 
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> 
> I'm getting a few warning during the build:
> 
> docs/qemu-block-drivers.texi:790: warning: @setfilename after the first element
> docs/qemu-block-drivers.texi:790: warning: @setfilename after the first element
> docs/qemu-block-drivers.texi:791: warning: multiple @settitle
> docs/qemu-block-drivers.texi:791: warning: multiple @settitle

Thanks, will fix!

Stefan
