Received: from eggs.gnu.org ([2001:4830:134:3::10]:50175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTRna-0002Zz-2S
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:19:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cTRnZ-0002Uk-2g
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:19:34 -0500
Received: from mail-ua0-x22a.google.com ([2607:f8b0:400c:c08::22a]:35034)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cTRnY-0002UT-M0
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 06:19:32 -0500
Received: by mail-ua0-x22a.google.com with SMTP id y9so100747219uae.2
	for <qemu-devel@nongnu.org>; Tue, 17 Jan 2017 03:19:32 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1484384878-29179-1-git-send-email-laurent@vivier.eu>
References: <1484384878-29179-1-git-send-email-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Jan 2017 11:19:11 +0000
Message-ID: <CAFEAcA_g96s3-3yMV3-4JKrMqja0LWr4jgWbL2m-Rzni8s2G+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL v2 0/9] M68k for 2.9 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 14 January 2017 at 09:07, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit b6af8ea60282df514f87d32e36afd1c9aeee28c8:
>
>   Merge remote-tracking branch 'remotes/ehabkost/tags/x86-and-machine-pull-request' into staging (2017-01-13 14:38:21 +0000)
>
> are available in the git repository at:
>
>   git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.9-pull-request
>
> for you to fetch changes up to 727d937b59f1f722f983e20f9cd23b0e7ef60165:
>
>   target-m68k: increment/decrement with SP (2017-01-14 10:06:21 +0100)
>
> ----------------------------------------------------------------
> This is the list of the remaining patches that was part of series
> reviewed during the freeze period. They use the new new deposit
> and extract ops.
> There is also a cleanup patch from Thomas.
>
> The v2 includes various fixes I've sent and that have been reviewed
> since the first pull request.
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
