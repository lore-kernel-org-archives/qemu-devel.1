Received: from eggs.gnu.org ([2001:4830:134:3::10]:39513)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <swetheendra.t@gmail.com>) id 1e0E7y-0004vp-Dh
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 17:56:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <swetheendra.t@gmail.com>) id 1e0E7x-0003Dn-Lj
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 17:56:22 -0400
Received: from mail-qt0-x234.google.com ([2607:f8b0:400d:c0d::234]:52199)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <swetheendra.t@gmail.com>)
	id 1e0E7x-0003CD-Fo
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 17:56:21 -0400
Received: by mail-qt0-x234.google.com with SMTP id q4so28181484qtq.8
	for <qemu-devel@nongnu.org>; Thu, 05 Oct 2017 14:56:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAMSFjdhUGDQd9sGTFGeP31BCBqoN-tZyO7bmyj63wBfV5d1tBg@mail.gmail.com>
References: <CAMSFjdhUGDQd9sGTFGeP31BCBqoN-tZyO7bmyj63wBfV5d1tBg@mail.gmail.com>
From: Swetheendra Tallamraju <swetheendra.t@gmail.com>
Date: Thu, 5 Oct 2017 17:56:20 -0400
Message-ID: <CAMSFjdi01EzUmy=JYeOkvqK8JUHQ2wM99GSr2Jx1Nf-AbkUgnw@mail.gmail.com>
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
To: qemu-devel@nongnu.org

I want yo add extra functionality of booting from virtual USB through qemu.
I need to write a new block of code in /hw/USB to emulate virtual USB. I
don't have any clue of how to procced. Code documentation of other devices
like hub network would help us understanding and implementing usb

On Thu, Oct 5, 2017 at 12:03 AM, Swetheendra Tallamraju <
swetheendra.t@gmail.com> wrote:

> I am working on qemu source code to provide extra functionality of
> emulating virtual usb. Can I get any  documentation for the qemu source
> code that helps me in implementing this?
>
