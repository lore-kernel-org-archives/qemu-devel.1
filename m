Received: from eggs.gnu.org ([2001:4830:134:3::10]:41419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eQgaf-0005NY-Gr
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 16:35:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eQgae-0007RN-Lj
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 16:35:21 -0500
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:37394)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eQgae-0007R7-GL
	for qemu-devel@nongnu.org; Sun, 17 Dec 2017 16:35:20 -0500
Received: by mail-oi0-x231.google.com with SMTP id y75so9438818oie.4
	for <qemu-devel@nongnu.org>; Sun, 17 Dec 2017 13:35:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1513446109-9013-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 17 Dec 2017 21:34:59 +0000
Message-ID: <CAFEAcA96q6RGAmWJj=jYgYBC_yrP-NcZ6A4_w=S7vgn=-pL3Jw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 00/32] Merge tpm 2017/12/15
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 16 December 2017 at 17:41, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> The following patch series refactors the TPM TIS and backend drivers for
> easier addition of new front-end devices. Further, the TPM buffer sizes
> are read from the backend and the backend's buffer size can be adjusted
> by the frontend, if necessary.
>
>
> The following changes since commit 0ef0583d5adceb9138bdb47494dabd1549ac5b6d:
>
>   Merge remote-tracking branch 'remotes/dgilbert/tags/pull-hmp-20171214' into staging (2017-12-14 15:32:32 +0000)
>
> are available in the git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2017-12-15-1
>
> for you to fetch changes up to 683c4b775355cc7acd301e8efe7d4c1c9acdafd8:
>
>   tpm: tpm_passthrough: Fail startup if FE buffer size < BE buffer size (2017-12-14 23:39:15 -0500)
>
> ----------------------------------------------------------------
> Merge tpm 2017/12/15 v1

Applied, thanks.

-- PMM
