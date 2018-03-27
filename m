Received: from eggs.gnu.org ([2001:4830:134:3::10]:49314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f0uyi-0004dq-VR
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 16:13:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f0uyi-0005q0-3q
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 16:13:56 -0400
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:35641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f0uyh-0005ph-TZ
	for qemu-devel@nongnu.org; Tue, 27 Mar 2018 16:13:56 -0400
Received: by mail-oi0-x231.google.com with SMTP id z8-v6so157941oix.2
	for <qemu-devel@nongnu.org>; Tue, 27 Mar 2018 13:13:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180327152114.1776925-1-eblake@redhat.com>
References: <20180327152114.1776925-1-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Mar 2018 21:13:34 +0100
Message-ID: <CAFEAcA-4XX9ZLFgWC6ApRvXguXBFg4NdKPv4zq_Jzmkf=2kf2g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL v2 00/14] QAPI changes for 2018-03-27,
 2.12-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 27 March 2018 at 16:21, Eric Blake <eblake@redhat.com> wrote:
> The following changes since commit bdc408e91b14cedfc29be8ff703408936e5757=
21:
>
>   Merge remote-tracking branch 'remotes/maxreitz/tags/pull-block-2018-03-=
26' into staging (2018-03-27 14:11:30 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/ericb.git tags/pull-qapi-2018-03-27-v2
>
> for you to fetch changes up to 0dfddbb537fcb0fbd045e1c890bc0e95f2ea5177:
>
>   hmp.c: Revert hmp_info_cpus output format change (2018-03-27 10:17:48 -=
0500)
>
> v2: fix some R-b tags in 6/14, 14/14 (no code changes, so no patches re-s=
ent)
>
> ----------------------------------------------------------------
> qapi patches for 2018-03-27, 2.12-rc1
>
> - Marc-Andr=C3=A9 Lureau: qmp-test: fix response leak
> - Eric Blake: tests: Silence false positive warning on generated test nam=
e
> - Laurent Vivier: 0/4 (partial) coccinelle: re-run scripts from scripst/c=
occinelle
> - Peter Xu: 0/8 Monitor: some oob related patches (fixes, new param, test=
s)
> - Satheesh Rajendran: hmp.c: Revert hmp_info_cpus output format change
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
