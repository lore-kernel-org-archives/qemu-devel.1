Received: from eggs.gnu.org ([2001:4830:134:3::10]:41086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erMji-0006tE-S1
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:50:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1erMji-00074m-7J
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:50:58 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:38143)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1erMji-00074Y-3S
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 06:50:58 -0500
Received: by mail-oi0-x244.google.com with SMTP id 123so4252227oig.5
	for <qemu-devel@nongnu.org>; Thu, 01 Mar 2018 03:50:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1519740425-11270-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1519740425-11270-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Mar 2018 11:50:37 +0000
Message-ID: <CAFEAcA-cCw6iNDeSSgjPos-mJ8A+iAV+egHksYasEzfa+bFCPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/2] Merge tpm 2018/02/21 v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 27 February 2018 at 14:07, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> This patch series adds a test case for the TPM TIS interface.
>
>    Stefan
>
> Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180220-pull-request' into staging (2018-02-20 14:05:00 +0000)
>
> are available in the git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2018-02-21-2
>
> for you to fetch changes up to adb0e917e6ee93631e40265ca145bc31cd3b6c9a:
>
>   tests: add test for TPM TIS device (2018-02-21 07:24:50 -0500)
>
> ----------------------------------------------------------------
> Merge tpm 2018/02/21 v2
>
> ----------------------------------------------------------------
> Stefan Berger (2):
>       tests: Move common TPM test code into tpm-emu.c
>       tests: add test for TPM TIS device

Applied, thanks.

-- PMM
