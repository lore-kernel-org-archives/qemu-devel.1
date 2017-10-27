Received: from eggs.gnu.org ([2001:4830:134:3::10]:42204)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1e8DoR-0007Wk-SW
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 19:13:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kevin@koconnor.net>) id 1e8DoN-0008HA-Q3
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 19:13:15 -0400
Received: from mail-qk0-x236.google.com ([2607:f8b0:400d:c09::236]:46861)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kevin@koconnor.net>) id 1e8DoN-0008GM-K7
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 19:13:11 -0400
Received: by mail-qk0-x236.google.com with SMTP id k123so10201669qke.3
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 16:13:11 -0700 (PDT)
Date: Fri, 27 Oct 2017 19:13:08 -0400
From: Kevin O'Connor <kevin@koconnor.net>
Message-ID: <20171027231308.GA11440@morn.lan>
References: <1506411189.32072.14.camel@redhat.com>
	<20170927135119.GA15789@morn.lan>
	<1506586083.6902.1.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1506586083.6902.1.camel@redhat.com>
Subject: Re: [Qemu-devel] [SeaBIOS] Time for a seabios 1.11 release?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: seabios <seabios@seabios.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Thu, Sep 28, 2017 at 10:08:03AM +0200, Gerd Hoffmann wrote:
> On Wed, 2017-09-27 at 09:51 -0400, Kevin O'Connor wrote:
> > On Tue, Sep 26, 2017 at 09:33:09AM +0200, Gerd Hoffmann wrote:
> > >    Hi,
> > > 
> > > Quite a few changes accumulated in master.  Time to plan a new
> > > release
> > > I think, so we can pick up the improvements in qemu 2.11.
> > > 
> > > Comments?
> > 
> > Makes sense.  How about freezing SeaBIOS on October 13th and target a
> > release on October 27th?
> 
> Looks good to me.

Hi,

I think we should delay the release for a week - just to see if we can
track down this issue with sd cards.  Let me know if there are any
concerns with that.

-Kevin
