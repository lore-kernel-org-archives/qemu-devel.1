Received: from eggs.gnu.org ([2001:4830:134:3::10]:37766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPWCr-0002P0-TM
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:13:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPWCr-0000Si-04
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:13:25 -0500
Received: from mail-ua0-x234.google.com ([2607:f8b0:400c:c08::234]:33802)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cPWCq-0000SE-SO
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:13:24 -0500
Received: by mail-ua0-x234.google.com with SMTP id 34so368744769uac.1
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 07:13:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1483673544-10663-1-git-send-email-jasowang@redhat.com>
References: <1483673544-10663-1-git-send-email-jasowang@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jan 2017 15:13:03 +0000
Message-ID: <CAFEAcA-JUN_1cPdGbbgQjLnw0EB0sNAENBcaLV6_0puQ3a5Aug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/3] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On 6 January 2017 at 03:32, Jason Wang <jasowang@redhat.com> wrote:
> The following changes since commit e92fbc753df4fab9ee524b5ea07a51bee8b6ba=
e4:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2017-01-05 12:44:23 +0000)
>
> are available in the git repository at:
>
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>
> for you to fetch changes up to 7e354ed4df9787ff95cdb189374739e476be4f9a:
>
>   fsl_etsec: Fix Tx BD ring wrapping handling (2017-01-06 10:38:21 +0800)
>
> ----------------------------------------------------------------
>
> - network support for record/replay
>
> ----------------------------------------------------------------
> Andrey Smirnov (1):
>       fsl_etsec: Fix Tx BD ring wrapping handling
>
> Herv=C3=A9 Poussineau (1):
>       rtl8139: correctly handle PHY reset
>
> Pavel Dovgalyuk (1):
>       record/replay: add network support

Applied, thanks.

-- PMM
