Received: from eggs.gnu.org ([2001:4830:134:3::10]:38792)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dtxcX-0004CV-FS
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:06:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dtxcR-0003rK-LS
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:06:01 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:45738)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dtxcR-0003rA-F2
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 11:05:55 -0400
Received: by mail-wm0-x230.google.com with SMTP id g206so3615119wme.0
	for <qemu-devel@nongnu.org>; Mon, 18 Sep 2017 08:05:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170918145936.GE4141@stefanha-x1.localdomain>
References: <1504729728-23279-1-git-send-email-cota@braap.org>
	<20170918145936.GE4141@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Sep 2017 16:05:31 +0100
Message-ID: <CAFEAcA9i5UhGP+J=DynPkvz3=t+uAEXTbwEXYoB4nOLXrjhzhA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 0/6] initial plugin support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>, Stefan Hajnoczi <stefanha@redhat.com>

On 18 September 2017 at 15:59, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> Thanks for sending this!  Could you and Llu=C3=ADs collaborate on a singl=
e
> instrumentation plugin API?
>
> Let's have a discussion with Llu=C3=ADs, Peter, myself, and potentially
> others then we can use the QEMU Developer Conference Call that is
> scheduled every 2 weeks.
>
> The next call time slot is Tue 26 Sept at 13:00 UTC:
> https://www.timeanddate.com/worldclock/fixedtime.html?iso=3D20170926T1400=
00&p1=3D136

I can't make that, I'm afraid, it's Linaro Connect that week.

>From my point of view, it would be helpful to start with
just designing the API that we're trying to implement.
I care a lot that we get that API correct, I don't care much
at all about the implementation...

thanks
-- PMM
