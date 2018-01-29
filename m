Received: from eggs.gnu.org ([2001:4830:134:3::10]:44188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ghammer@redhat.com>) id 1eg4BE-0001lf-BY
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 02:48:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ghammer@redhat.com>) id 1eg4BB-0002MC-Ae
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 02:48:40 -0500
Received: from mail-oi0-f54.google.com ([209.85.218.54]:40819)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ghammer@redhat.com>) id 1eg4BB-0002L2-5S
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 02:48:37 -0500
Received: by mail-oi0-f54.google.com with SMTP id a184so4389504oif.7
	for <qemu-devel@nongnu.org>; Sun, 28 Jan 2018 23:48:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180129064446-mutt-send-email-mst@kernel.org>
References: <1516747387-31760-1-git-send-email-mst@redhat.com>
	<1516747387-31760-2-git-send-email-mst@redhat.com>
	<20180124094621.46ff2f43@bahia.lan>
	<20180124100500.1f9bf54a@bahia.lan>
	<d0698024-65ae-fb6b-397d-cccdc1fb36f4@redhat.com>
	<20180124103402.6ef42523@bahia.lan>
	<20180124190820-mutt-send-email-mst@kernel.org>
	<CAA2ifQybqzCYC48fjzT9mztn=3iTS+3uO0DUF8bxAF5jt3u-Vg@mail.gmail.com>
	<20180129064446-mutt-send-email-mst@kernel.org>
From: Gal Hammer <ghammer@redhat.com>
Date: Mon, 29 Jan 2018 09:48:35 +0200
Message-ID: <CAA2ifQzzECJqRPJRMD35Ama=dHD29XiYzXFCCp0eM48mB4FODQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 1/1] kvm-all: Partially reverts 4fe6d78b2e
 to remove the cleanup call
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Greg Kurz <groug@kaod.org>, Peter Maydell <peter.maydell@linaro.org>, kvm@vger.kernel.org, Jose Ricardo Ziviani <joserz@linux.vnet.ibm.com>, qemu-devel@nongnu.org, Anton Blanchard <anton@samba.org>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

On Mon, Jan 29, 2018 at 6:45 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Sun, Jan 28, 2018 at 04:07:27PM +0200, Gal Hammer wrote:
>> Hi,
>>
>> Sorry for a bad patch and the problems it may have caused.
>
> Not at all, these things happen.  Do you have short term plans to work
> on a new version?

I already have a solution for it (which I abandoned because I liked
the "cleanup" option), I'll submit a patch for a review later today.

    Gal.
