Received: from eggs.gnu.org ([2001:4830:134:3::10]:53102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <swetheendra.t@gmail.com>) id 1e0W0S-0007Vj-Ct
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 13:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <swetheendra.t@gmail.com>) id 1e0W0R-0000Ky-Fv
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 13:01:48 -0400
Received: from mail-qk0-x232.google.com ([2607:f8b0:400d:c09::232]:54340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <swetheendra.t@gmail.com>)
	id 1e0W0R-0000Ke-Aq
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 13:01:47 -0400
Received: by mail-qk0-x232.google.com with SMTP id n5so16255312qke.11
	for <qemu-devel@nongnu.org>; Fri, 06 Oct 2017 10:01:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20171006162838.GD4325@localhost.localdomain>
References: <CAMSFjdhUGDQd9sGTFGeP31BCBqoN-tZyO7bmyj63wBfV5d1tBg@mail.gmail.com>
	<CAMSFjdi01EzUmy=JYeOkvqK8JUHQ2wM99GSr2Jx1Nf-AbkUgnw@mail.gmail.com>
	<20171006162838.GD4325@localhost.localdomain>
From: Swetheendra Tallamraju <swetheendra.t@gmail.com>
Date: Fri, 6 Oct 2017 13:01:45 -0400
Message-ID: <CAMSFjdgsAUNknNRvBWWt1HBSmWiKOY+iz7+o4dc5gwS3FCs9wg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] Qemu Documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org

I want to write a new virtual USB code and boot from USB by attaching at
command line. This functionality exists for hard drive CDROM network
devices but not for USB right. If it exists can you please tell me
directory path for code ?

On Oct 6, 2017 12:28 PM, "Kevin Wolf" <kwolf@redhat.com> wrote:

> Am 05.10.2017 um 23:56 hat Swetheendra Tallamraju geschrieben:
> > I want yo add extra functionality of booting from virtual USB through
> qemu.
> > I need to write a new block of code in /hw/USB to emulate virtual USB. I
> > don't have any clue of how to procced. Code documentation of other
> devices
> > like hub network would help us understanding and implementing usb
>
> QEMU already has support for emulating USB devices. What is it
> specifically that the existing code doesn't provide and you want to add?
>
> Kevin
>
> > On Thu, Oct 5, 2017 at 12:03 AM, Swetheendra Tallamraju <
> > swetheendra.t@gmail.com> wrote:
> >
> > > I am working on qemu source code to provide extra functionality of
> > > emulating virtual usb. Can I get any  documentation for the qemu source
> > > code that helps me in implementing this?
> > >
>
