Received: from eggs.gnu.org ([2001:4830:134:3::10]:45185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqcGg-0002yt-8Y
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:13:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqcGf-0005G1-EX
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:13:54 -0500
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:44543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqcGf-0005Fn-9N
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 05:13:53 -0500
Received: by mail-oi0-x233.google.com with SMTP id b8so12441108oib.11
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 02:13:53 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1519421985-18185-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1519421985-18185-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 10:13:31 +0000
Message-ID: <CAFEAcA84G9BW8bikXYLuu=m6Ca2WRmMH3VXwYvX_x32xJtQVuQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 0/2] Merge tpm 2018/02/21 v1
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

On 23 February 2018 at 21:39, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> This patch series adds a test case for the TPM TIS interface.
>
>    Stefan
>
> The following changes since commit a6e0344fa0e09413324835ae122c4cadd7890231:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/ui-20180220-pull-request' into staging (2018-02-20 14:05:00 +0000)
>
> are available in the git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tpm-pull-2018-02-21
>
> for you to fetch changes up to adb0e917e6ee93631e40265ca145bc31cd3b6c9a:
>
>   tests: add test for TPM TIS device (2018-02-21 07:24:50 -0500)
>

Hi. This doesn't appear to be a signed tag; my scripts complain

error: remotes/stefanberger/tpm-pull-2018-02-21: cannot verify a
non-tag object of type commit.

thanks
-- PMM
