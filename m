Received: from eggs.gnu.org ([2001:4830:134:3::10]:33386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceeq0-0007Lf-I0
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 04:28:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ceepz-0001hj-QX
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 04:28:24 -0500
Received: from mail-wm0-x234.google.com ([2a00:1450:400c:c09::234]:36049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ceepz-0001hA-KG
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 04:28:23 -0500
Received: by mail-wm0-x234.google.com with SMTP id c85so9175873wmi.1
	for <qemu-devel@nongnu.org>; Fri, 17 Feb 2017 01:28:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170217064327.GB21716@lemon.lan>
References: <CABHMSTVDnAxAvpp81+z_2fkAFO7tazLJs3cFXpuDuuGQj-Ek-A@mail.gmail.com>
	<1933406e-2576-e687-3545-a72f3b999310@redhat.com>
	<bf1410bc-bc6d-bb29-5591-55634f25d487@redhat.com>
	<CABHMSTUsZy0u4b1b84YC5CgafKvD-Zms5dCQ=31+XnQphUQxLA@mail.gmail.com>
	<20170217064327.GB21716@lemon.lan>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 17 Feb 2017 09:28:01 +0000
Message-ID: <CAFEAcA8_f8SVX+rirAFBJ76ZiXaKUwh9uO0AeBFoR7G_q8pGDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] Fix build break during configuration on musl-libc
 based Linux systems.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: Chad Joan <chadjoan@gmail.com>, QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 17 February 2017 at 06:43, Fam Zheng <famz@redhat.com> wrote:
> But your point is taken, we should make the first (or a one-shot)
> contribution as easy as possible.

Yes; we could do with providing a "This page seems very long..."
introduction section. The absolute bare minimum requirements
for a submitter I think are:
 * Provide a Signed-off-by: line (this is a hard requirement
   because it's how you say "I'm legally OK to contribute this
   and am happy for it to go into QEMU")
 * send patch by email
 * read replies and act on them if you want your patch to go in

The larger your contribution is, the more important the other
requirements detailed on the page are; but personally I'm
happy to manually fix up patches from a first-time submitter,
and I think most other maintainers are too.

thanks
-- PMM
