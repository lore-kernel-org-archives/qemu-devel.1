Received: from eggs.gnu.org ([2001:4830:134:3::10]:40573)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0VUT-0005Hf-FL
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 12:28:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0VUQ-0003uI-3l
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 12:28:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60746)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1e0VUP-0003tq-U5
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 12:28:42 -0400
Date: Fri, 6 Oct 2017 18:28:38 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171006162838.GD4325@localhost.localdomain>
References: <CAMSFjdhUGDQd9sGTFGeP31BCBqoN-tZyO7bmyj63wBfV5d1tBg@mail.gmail.com>
	<CAMSFjdi01EzUmy=JYeOkvqK8JUHQ2wM99GSr2Jx1Nf-AbkUgnw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMSFjdi01EzUmy=JYeOkvqK8JUHQ2wM99GSr2Jx1Nf-AbkUgnw@mail.gmail.com>
Subject: Re: [Qemu-devel] Qemu Documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Swetheendra Tallamraju <swetheendra.t@gmail.com>
Cc: qemu-devel@nongnu.org

Am 05.10.2017 um 23:56 hat Swetheendra Tallamraju geschrieben:
> I want yo add extra functionality of booting from virtual USB through qemu.
> I need to write a new block of code in /hw/USB to emulate virtual USB. I
> don't have any clue of how to procced. Code documentation of other devices
> like hub network would help us understanding and implementing usb

QEMU already has support for emulating USB devices. What is it
specifically that the existing code doesn't provide and you want to add?

Kevin

> On Thu, Oct 5, 2017 at 12:03 AM, Swetheendra Tallamraju <
> swetheendra.t@gmail.com> wrote:
> 
> > I am working on qemu source code to provide extra functionality of
> > emulating virtual usb. Can I get any  documentation for the qemu source
> > code that helps me in implementing this?
> >
