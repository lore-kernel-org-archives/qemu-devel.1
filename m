Received: from eggs.gnu.org ([209.51.188.92]:35559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gzV2T-0004EB-5l
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 18:24:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1gzV2L-0008RV-OO
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 18:24:25 -0500
MIME-Version: 1.0
References: <20190228202537.4638-1-alex.bennee@linaro.org>
	<20190228202537.4638-8-alex.bennee@linaro.org>
	<71a55c0c-3c09-edea-82a5-63fb0cfb4f12@redhat.com>
In-Reply-To: <71a55c0c-3c09-edea-82a5-63fb0cfb4f12@redhat.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Thu, 28 Feb 2019 15:24:06 -0800
Message-ID: <CAMo8BfKvQZyp3ri356LoqCDhsFszU5proLGH2MBbBi2pgRZ4rw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/16] tests/tcg/xtensa: enable system
 tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-devel <qemu-devel@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm <qemu-arm@nongnu.org>

On Thu, Feb 28, 2019 at 2:54 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
> Max: I think it should be quite easy to port your simulator to Alex's
> new Makefile.

I agree.

> BTW is this simulator downloadable? I see the Zephyr project also uses
> it, and I looked for it on https://ip.cadence.com/swdev but couldnt find
> a (public) link.

There's a site https://www.tensilicatools.com/
with tools for various end-user-programmable xtensa cores,
but I'm pretty sure that neither dc232b nor dc233c are available
there.

--=20
Thanks.
-- Max
