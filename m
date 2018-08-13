Received: from eggs.gnu.org ([2001:4830:134:3::10]:45540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fp9xX-0003KR-VW
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:20:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fp9xX-0004fT-11
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:20:23 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:42537)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fp9xW-0004fM-IQ
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 06:20:22 -0400
Received: by mail-oi0-x243.google.com with SMTP id b16-v6so26252409oic.9
	for <qemu-devel@nongnu.org>; Mon, 13 Aug 2018 03:20:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAEgYsbEQpnVn-hWgQxBmCfiTnU7eOdA+sdscpAHo=+KH17bnuA@mail.gmail.com>
References: <5B7054D9.9000209@gmx.com> <20180813083408.GG22904@redhat.com>
	<CAEgYsbEQpnVn-hWgQxBmCfiTnU7eOdA+sdscpAHo=+KH17bnuA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Aug 2018 11:20:01 +0100
Message-ID: <CAFEAcA8wtt4xx3dbcr4dT1c3qxFkdLL2JBHcJ_Ob7rmsPuqJ1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] QEMU on Solaris
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Tribble <peter.tribble@gmail.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Michele Denber <mdenber@gmx.com>, QEMU Developers <qemu-devel@nongnu.org>

On 13 August 2018 at 11:08, Peter Tribble <peter.tribble@gmail.com> wrote:
> You can certainly run illumos (such as OpenIndiana or Tribblix) in a VM
> easily,
> and freely. I can help with that.

A good start would be if we had a wiki page similar to
https://wiki.qemu.org/Hosts/BSD (linked to from the "Building
QEMU from source" subsection of https://wiki.qemu.org/Documentation)
that gave the instructions for how to set up a VM running on
x86 QEMU/KVM on Linux which can build QEMU.

Then we could look at adding it to the tests in tests/vm/

thanks
-- PMM
