Received: from eggs.gnu.org ([2001:4830:134:3::10]:53703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTPxf-0006QW-8B
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:21:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTPxe-000183-2e
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:21:51 -0500
Received: from mail-ua0-x231.google.com ([2607:f8b0:400c:c08::231]:36053)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cTPxd-00017n-V7
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 04:21:49 -0500
Received: by mail-ua0-x231.google.com with SMTP id 96so98317614uaq.3
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 01:21:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170113145633.15384-1-alex.bennee@linaro.org>
References: <20170113145633.15384-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jan 2017 09:21:28 +0000
Message-ID: <CAFEAcA_74zW9Lq7JN3cwoU605O-xA2UGcMcOyQXt3Lx=O=BuYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/3] Common TLB reset changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 13 January 2017 at 14:56, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> The following changes since commit b6c08970bc989bfddcf830684ea7a96b7a4d62=
a7:
>
>   Merge remote-tracking branch 'remotes/bkoppelmann/tags/pull-tricore-201=
7-01-11-2' into staging (2017-01-12 18:29:49 +0000)
>
> are available in the git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-tcg-common-tlb-reset-2017=
0113-r1
>
> for you to fetch changes up to d10eb08f5d8389c814b554d01aa2882ac58221bf:
>
>   cputlb: drop flush_global flag from tlb_flush (2017-01-13 14:24:37 +000=
0)
>
> ----------------------------------------------------------------
> This is the same as the v3 posted except a re-base and a few extra signof=
fs
>
> ----------------------------------------------------------------
> Alex Benn=C3=A9e (3):
>       qom/cpu: move tlb_flush to cpu_common_reset
>       cpu_common_reset: wrap TCG specific code in tcg_enabled()
>       cputlb: drop flush_global flag from tlb_flush
>

Applied, thanks.

-- PMM
