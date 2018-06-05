Received: from eggs.gnu.org ([2001:4830:134:3::10]:47066)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQ9U8-0003eE-ME
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:46:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fQ9U7-0002ys-Rg
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:46:40 -0400
Received: from mail-ot0-x22d.google.com ([2607:f8b0:4003:c0f::22d]:36337)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fQ9U7-0002yd-La
	for qemu-devel@nongnu.org; Tue, 05 Jun 2018 06:46:39 -0400
Received: by mail-ot0-x22d.google.com with SMTP id m11-v6so2220859otf.3
	for <qemu-devel@nongnu.org>; Tue, 05 Jun 2018 03:46:39 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180604152015.13359-1-laurent@vivier.eu>
References: <20180604152015.13359-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Jun 2018 11:46:18 +0100
Message-ID: <CAFEAcA_m4GxFJfThSDh6-GMXcVeZUb-r8E-Oj-eLUQpb9=6PsQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/17] Linux user for 3.0 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>

On 4 June 2018 at 16:19, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit 392fba9f583223786f844dce9b2e7f9a0ce0147a:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-travis-updates-010618-1' into staging (2018-06-01 17:32:30 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-3.0-pull-request
>
> for you to fetch changes up to 7ea65371ee6ba714c5b369b38dd608b128dab57c:
>
>   linux-user: remove useless #if (2018-06-04 01:30:44 +0200)
>
> ----------------------------------------------------------------
> move more data to arch specific files
> fix SPARC %tick
> replace strcpy() by g_strlcpy() in syscall.c
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
