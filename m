Received: from eggs.gnu.org ([2001:4830:134:3::10]:60502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evKNN-0008NB-L6
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:08:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1evKNM-000319-Mn
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:08:17 -0400
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:41837)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1evKNM-0002zT-HJ
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 06:08:16 -0400
Received: by mail-oi0-x22c.google.com with SMTP id g5so11809691oiy.8
	for <qemu-devel@nongnu.org>; Mon, 12 Mar 2018 03:08:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180309145717.9603-1-laurent@vivier.eu>
References: <20180309145717.9603-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Mar 2018 10:07:55 +0000
Message-ID: <CAFEAcA9cQz0PjHn_G-Y3oMigAz2SjOaaPVxHNOXJaK26T3__2w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/8] M68k for 2.12 patches
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

On 9 March 2018 at 14:57, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit e1ee9ee139ed7091c2c592d5b784fbb7227bfc0d:
>
>   Merge remote-tracking branch 'remotes/dgibson/tags/ppc-for-2.12-20180306' into staging (2018-03-06 10:21:35 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu-m68k.git tags/m68k-for-2.12-pull-request
>
> for you to fetch changes up to 6c25be6e30bda0e470f8f0b6b93d53a6efe469e8:
>
>   target/m68k: implement ftentox (2018-03-09 15:50:38 +0100)
>
> ----------------------------------------------------------------
> v2 fixes permissions of file target/m68k/softfloat_fpsp_tables.h
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
