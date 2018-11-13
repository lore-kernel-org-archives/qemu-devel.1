Received: from eggs.gnu.org ([2001:4830:134:3::10]:35002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMYrx-0002Ec-CK
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 08:36:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMYru-00030X-Ur
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 08:36:41 -0500
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336]:35302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gMYru-0002si-I0
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 08:36:38 -0500
Received: by mail-ot1-x336.google.com with SMTP id 81so11315880otj.2
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 05:36:38 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20181113030047.11711-1-mdroth@linux.vnet.ibm.com>
References: <20181113030047.11711-1-mdroth@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Nov 2018 13:36:17 +0000
Message-ID: <CAFEAcA-RuqQexEVpS5vD4wSN6Av2XG=chxdaxAq-n4teRF=qLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL for-3.1 0/2] qemu-ga patch queue for 3.1.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 13 November 2018 at 03:00, Michael Roth <mdroth@linux.vnet.ibm.com> wrot=
e:
> The following changes since commit 160e5c22e55b3f775c2003dfc626fa872ee4a7=
a1:
>
>   Merge remote-tracking branch 'remotes/gkurz/tags/for-upstream' into sta=
ging (2018-11-09 10:54:10 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/mdroth/qemu.git tags/qga-pull-2018-11-12-tag
>
> for you to fetch changes up to 61baac2fdb7ad3891fb00bbd3c9e8b8ca87f0f62:
>
>   qga: Add multiple include guard to guest-agent-core.h (2018-11-09 07:55=
:13 -0600)
>
> ----------------------------------------------------------------
> qemu-ga patch queue for 3.1.0
>
> * add missing #include guards for guest-agent-core.h
> * fix leaks introduced with recent win32 enablement of disk info in
>   guest-get-fsinfo
>
> ----------------------------------------------------------------
> Marc-Andr=C3=A9 Lureau (1):
>       qga-win: fix leaks of build_guest_disk_info()
>
> Peter Maydell (1):
>       qga: Add multiple include guard to guest-agent-core.h

Applied, thanks.

-- PMM
