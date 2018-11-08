Received: from eggs.gnu.org ([2001:4830:134:3::10]:47172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKosr-0003nG-9m
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:18:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gKosq-0008W8-EF
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:18:25 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:38110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gKosp-0008Qc-MK
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 13:18:24 -0500
Received: by mail-ot1-x343.google.com with SMTP id f24so19020626otl.5
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 10:18:23 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5f495bd7-8489-4e8f-8fd5-d0bb28787fa4@redhat.com>
References: <20181108143422.15955-1-philmd@redhat.com>
	<20181108171716.GN12503@habkost.net>
	<CAFEAcA-t5qOHngv9ciTkuakmT84N7QV4c0=TYMD-NUgh5uT_DA@mail.gmail.com>
	<CAP+75-WTmYUAWgOZ7cf2jsaqvQVv+atBzatUgDOhudz1kqPg4g@mail.gmail.com>
	<CAFEAcA8XK51Uun6MUQDSOMAN7aCQ0TtKzQBWtVXtBx9=A5yECw@mail.gmail.com>
	<5f495bd7-8489-4e8f-8fd5-d0bb28787fa4@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Nov 2018 18:18:02 +0000
Message-ID: <CAFEAcA-CtBWk-JYBw=Jk3Pqp_U1e_aA9Rcvs=mtwOqjZK0AX=g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] scripts: Remove unused python imports
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>, Cleber Rosa <crosa@redhat.com>

On 8 November 2018 at 18:08, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
> Anyway there are no information about merge window in the wiki.
> When I started it was not easy to understand it and why patches sent when
> 'merge window is close' fall under the crap and are unnoticed, thus it is
> better to wait before to send, or resend them.

The intention (not always something we succeed at) is that
maintainers should respond to patches, do review, etc, at
any point in our release cycle. During a release they might
reply to say "I won't get to reviewing this for a little while"
or "I'll take this patch once the trunk reopens for releases",
but they shouldn't just leave patch submitters with no response
at all...

> Also you could add the expected dates for the next releases there.

We only work out dates for the next release when we've got the
previous one out. They're roughly April/August/December, though.

thanks
-- PMM
