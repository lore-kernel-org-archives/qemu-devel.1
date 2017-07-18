Received: from eggs.gnu.org ([2001:4830:134:3::10]:33636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXSko-000085-QW
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 09:41:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dXSkn-0007Ms-Gu
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 09:41:34 -0400
MIME-Version: 1.0
Sender: philippe.mathieu.daude@gmail.com
In-Reply-To: <87bmoi806u.fsf@linaro.org>
References: <20170718061005.29518-1-f4bug@amsat.org>
	<20170718061005.29518-27-f4bug@amsat.org>
	<CAJ+F1C+WsdUp3Vtx+-FZ9g7URSAQuJWb6h7-w6yJXM+4TKQNjA@mail.gmail.com>
	<87bmoi806u.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 18 Jul 2017 10:41:29 -0300
Message-ID: <CAAdtpL7HcwwpCNjVxpaX=nB72LS_CJjU=VdS_aH0EM6i8QVBOw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 26/29] tests/tcg: use ARRAY_SIZE macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, qemu trival <qemu-trivial@nongnu.org>, QEMU <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>

On Tue, Jul 18, 2017 at 8:16 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>
> Pranith has had a couple of revs at this:
>
>   Subject: [PATCH v5 00/19] Cleanup of TCG tests
>   Date: Thu,  1 Dec 2016 00:14:14 -0500
>   Message-Id: <20161201051433.17168-1-bobby.prani@gmail.com>
>
> We have the cross-compilers available as a fallback via docker although
> not every one can seamlessly use it for building stuff. Is getting a
> working cross-compiler setup too much of a hurdle fore those that want
> to build cross-arch tests?

I have a WiP branch using qemu to cross-run tests it _works_ funny but
when it fails it is not funny to understand what is really buggy...
/to be continued.../

Phil.
