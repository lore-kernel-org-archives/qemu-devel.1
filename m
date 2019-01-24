Received: from eggs.gnu.org ([209.51.188.92]:47241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmhr3-00060a-Tx
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 11:27:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gmhr3-0000Vq-CQ
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 11:27:49 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gmhr3-0000TI-6J
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 11:27:49 -0500
Received: by mail-ot1-x341.google.com with SMTP id u16so5748130otk.8
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 08:27:47 -0800 (PST)
MIME-Version: 1.0
References: <20170816072104.24420-1-famz@redhat.com>
	<20170816072104.24420-9-famz@redhat.com>
	<ed7262b4-f84e-1405-dbe6-1ea5f11e73f1@redhat.com>
In-Reply-To: <ed7262b4-f84e-1405-dbe6-1ea5f11e73f1@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 24 Jan 2019 16:27:34 +0000
Message-ID: <CAFEAcA9f+AsS0tPFrtOPgxwwa-vud6JDypR2XGcm5_oM0keWGA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 8/9] tests: Add OpenBSD image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Brad Smith <brad@comstyle.com>, "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>

On Thu, 24 Jan 2019 at 15:52, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> After spending various hours trying to fix various issues on OpenBSD, I
> notice that we never ran tests on this OS.

When I was running tests on a custom OpenBSD VM rather than
using the tests/vm one I'm pretty sure I used to run "make check"
on it, so I was a bit surprised to see that tests weren't run
for the tests/vm setup, but I never cared enough to try to
find out why...

thanks
-- PMM
