Received: from eggs.gnu.org ([209.51.188.92]:53644)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkASL-0008Sw-9p
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:23:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkASJ-0002RP-Ea
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:23:49 -0500
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:38445)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkASG-0002Na-8o
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 11:23:45 -0500
Received: by mail-ot1-x335.google.com with SMTP id e12so11646096otl.5
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 08:23:43 -0800 (PST)
MIME-Version: 1.0
References: <20190117161355.18204-1-philmd@redhat.com>
In-Reply-To: <20190117161355.18204-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 17 Jan 2019 16:23:30 +0000
Message-ID: <CAFEAcA84VVc399dv3HT7PYBCPA6CvyL8jp+MtytAEbTVK9QtNg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: Fix utf-8 mangling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, QEMU Trivial <qemu-trivial@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

On Thu, 17 Jan 2019 at 16:15, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
>
> Patch incorrectly applied as 15ffb43cbf4.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> Paolo can this be a patchew bug?

Putting a suitable check into checkpatch would probably
be a good idea.

thanks
-- PMM
