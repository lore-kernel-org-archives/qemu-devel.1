Received: from eggs.gnu.org ([2001:4830:134:3::10]:50855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ej0oh-0006FW-BX
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:49:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ej0og-0007MX-IO
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:49:35 -0500
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:41702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ej0og-0007LC-D1
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 05:49:34 -0500
Received: by mail-oi0-x230.google.com with SMTP id m83so995651oik.8
	for <qemu-devel@nongnu.org>; Tue, 06 Feb 2018 02:49:34 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1517666981-9339-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1517666981-9339-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Feb 2018 10:49:13 +0000
Message-ID: <CAFEAcA87GCt8eFgdzm=eh1oOvDJAbLXqNPGF6b_JoQkSjZ+EnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] Merge tpm 2018/02/03
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

On 3 February 2018 at 14:09, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> The following patches do some cleanups and fix the resetting of the TPM
> CRB device and add my tpm-next git tree reference to MAINTAINERS.
>
> The following changes since commit e486b528229ed4ed5dfdac790c8152bfb2a265c9:
>
>   Merge remote-tracking branch 'remotes/elmarco/tags/dump-pull-request' into staging (2018-02-02 10:57:50 +0000)
>
> are available in the git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2018-02-03-1
>
> for you to fetch changes up to 3bd9e16149de3965a9880a20826a28b7b94bd4a7:
>
>   tpm: tis: move one-line function into caller (2018-02-03 09:01:56 -0500)
>
> ----------------------------------------------------------------
> Merge tpm 2018/02/03 v1
>
> ----------------------------------------------------------------
> Stefan Berger (4):
>       tpm: Split off tpm_crb_reset function
>       tpm: wrap stX_be_p in tpm_cmd_set_XYZ functions
>       MAINTAINERS: add pointer to tpm-next repository
>       tpm: tis: move one-line function into caller

Applied, thanks.

-- PMM
