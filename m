Received: from eggs.gnu.org ([2001:4830:134:3::10]:36319)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dcbPq-0007LM-5f
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 13:57:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dcbPp-0006vY-9M
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 13:57:10 -0400
Received: from mail-wr0-x22a.google.com ([2a00:1450:400c:c0c::22a]:35364)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dcbPp-0006ua-3A
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 13:57:09 -0400
Received: by mail-wr0-x22a.google.com with SMTP id k71so9840166wrc.2
	for <qemu-devel@nongnu.org>; Tue, 01 Aug 2017 10:57:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
References: <1501604245-33460-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Aug 2017 18:56:47 +0100
Message-ID: <CAFEAcA-VkU5tG9fV16+vSKkQCgZ2BSoHLtwe-VhDOsbOsm9Vww@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 00/17] Misc changes for QEMU 2.10-rc1 (?)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 1 August 2017 at 17:17, Paolo Bonzini <pbonzini@redhat.com> wrote:
> The following changes since commit 7d48cf8102a10e4a54333811bafb5eb5665092=
68:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-reques=
t' into staging (2017-08-01 14:33:56 +0100)
>
> are available in the git repository at:
>
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 33f21e4f044ac1c37f60edc1f1aee628be8f463b:
>
>   mc146818rtc: implement UIP latching as intended (2017-08-01 17:27:34 +0=
200)
>
> ----------------------------------------------------------------
> * Xen fix (Anthony)
> * chardev fixes (Anton, Marc-Andr=C3=A9)
> * small dead code removal (Zhongyi)
> * documentation (Dan)
> * bugfixes (David)
> * decrease migration downtime (Jay)
> * improved error output (Laurent)
> * RTC tests and bugfix (me)
> * Bluetooth clang analyzer fix (me)
> * KVM CPU hotplug race (Peng Hao)
> * Two other patches from Philippe's clang analyzer series
>

Applied, thanks, but can you check whatever it is in your
workflow that's mangling non-ascii characters?

thanks
-- PMM
