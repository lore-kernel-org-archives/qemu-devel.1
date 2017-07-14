Received: from eggs.gnu.org ([2001:4830:134:3::10]:33546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dW2If-0007nR-NQ
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:14:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dW2Ia-0002KN-3E
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:14:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dW2IZ-0002KF-Su
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 11:14:32 -0400
Date: Fri, 14 Jul 2017 18:14:29 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170714181403-mutt-send-email-mst@kernel.org>
References: <20170711220915-mutt-send-email-mst@kernel.org>
	<CAFEAcA_-hCV2Ogy3BS2RV4_AWYYQDT+fCNChVcz8uKZ8-VxhWA@mail.gmail.com>
	<273a7da7-2243-171f-e96d-39e8e8031984@redhat.com>
	<3CA8C399-80D0-4BC8-ACC6-FD72A09D9685@skyportsystems.com>
	<CAFEAcA8ZiTqAGS01Rtu8Vv9FHKXtUXwfc9mULkCkanQzirB14Q@mail.gmail.com>
	<06cbc0c4-73bc-d527-a466-de5a05b0641e@redhat.com>
	<CAJ+F1CJaRE2hAJUxfeqLYi3Bj46E9nRUOdyWxPHbHQS6oDoQEg@mail.gmail.com>
	<00D9C394-98C2-4AC0-99A9-427117B678F9@skyportsystems.com>
	<20170713191304-mutt-send-email-mst@kernel.org>
	<CAFEAcA_=35WNC=u9+ZWp4d798b-UPtni=+9vQxpzge7=UxoQhA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_=35WNC=u9+ZWp4d798b-UPtni=+9vQxpzge7=UxoQhA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL 19/21] tests: Add unit tests for the VM
 Generation ID feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Ben Warren <ben@skyportsystems.com>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Fri, Jul 14, 2017 at 02:11:27PM +0100, Peter Maydell wrote:
> On 13 July 2017 at 17:38, Michael S. Tsirkin <mst@redhat.com> wrote:
> > It's already a library, I don't think you need changes or refactoring.
> > You can just link boot_sector.c and call boot_sector_test like the pxe
> > test does. If this passes you know all acpi tables are in memory.
> >
> > I'll post a patch.
> 
> Hi -- you asked me on IRC if I could test that "use boot_sector_test"
> patch, but I can't find it in my email archive or in patchwork.
> Did you forget to send it, or has it got lost in transit? If you can
> provide a pointer to a copy I'll give it a test...
> 
> thanks
> -- PMM

Strange - neither can I. I was sure I sent it.
I just resent - pls take a look.

-- 
MST
