Received: from eggs.gnu.org ([2001:4830:134:3::10]:48111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etvoW-0006Qt-RE
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 08:42:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etvoV-0002oB-I1
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 08:42:32 -0500
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:39046)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1etvoV-0002o6-Ch
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 08:42:31 -0500
Received: by mail-oi0-x230.google.com with SMTP id t185so4350611oif.6
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 05:42:31 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1520427119-6236-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1520427119-6236-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Mar 2018 13:42:09 +0000
Message-ID: <CAFEAcA-JDxpW0jhSGEuEkxkOfw5cZeW3VZ+_8gAs4+KPLTN3Yg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 0/5] Merge tpm 2018/03/07
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

On 7 March 2018 at 12:51, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> This series of patches converts the TPM code to use trace-events rather than
> debug #define's.
>
>     Stefan
>
> The following changes since commit 8cb340c613ee3e626b070e0429c589f8a60ac657:
>
>   Merge remote-tracking branch 'remotes/famz/tags/staging-pull-request' into staging (2018-03-01 12:32:31 +0000)
>
> are available in the git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2018-03-07-1
>
> for you to fetch changes up to fcbed221ff7230c6a5ebfb2ed27dc114ff5a30b0:
>
>   tpm: convert tpm_tis.c to use trace-events (2018-03-06 13:00:41 -0500)
>
> ----------------------------------------------------------------
> Stefan Berger (5):
>       tpm: convert tpm_crb.c to use trace-events
>       tpm: convert tpm_passthrough.c to use trace-events
>       tpm: convert tpm_util.c to use trace-events
>       tpm: convert tpm_emulator.c to use trace-events
>       tpm: convert tpm_tis.c to use trace-events
Applied, thanks.

-- PMM
