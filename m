Received: from eggs.gnu.org ([209.51.188.92]:60027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEujx-0001dK-7h
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:53:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hEujw-0007iU-8V
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:53:05 -0400
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233]:44956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hEuju-0007g0-8Y
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 07:53:02 -0400
Received: by mail-oi1-x233.google.com with SMTP id i21so7664835oib.11
	for <qemu-devel@nongnu.org>; Fri, 12 Apr 2019 04:53:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190412113730.28828-1-otubo@redhat.com>
In-Reply-To: <20190412113730.28828-1-otubo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 12 Apr 2019 12:52:48 +0100
Message-ID: <CAFEAcA9k=rnQtJXsQ7D4EM6HeSnpJEyBHMTRp4SFb0_G7r+7uA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] seccomp branch queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Otubo <otubo@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>, "Daniel P. Berrange" <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On Fri, 12 Apr 2019 at 12:37, Eduardo Otubo <otubo@redhat.com> wrote:
>
> The following changes since commit 532cc6da74ec25b5ba6893b5757c977d54582949:
>
>   Update version for v4.0.0-rc3 release (2019-04-10 15:38:59 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/otubo/qemu.git tags/pull-seccomp-20190412
>
> for you to fetch changes up to ee352b53b3e49ba9621149f9de7279a5cadd606c:
>
>   configure: Relax check for libseccomp (2019-04-12 13:30:40 +0200)
>
> ----------------------------------------------------------------
> pull-seccomp-20190412
>
> ----------------------------------------------------------------
> Helge Deller (1):
>       configure: Relax check for libseccomp

Is this really release critical? If you're sending pull
requests for rc3/rc4 it is extremely helpful if you can
give the justification for why they need to go into this
release. (As it happens we're going to need an rc4, but
I want to keep the set of changes in it to a minimum.)

thanks
-- PMM
