Received: from eggs.gnu.org ([2001:4830:134:3::10]:41759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5rlz-0005wk-Uu
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 07:49:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5rlz-0007p2-Ah
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 07:49:16 -0400
Received: from mail-ot0-x234.google.com ([2607:f8b0:4003:c0f::234]:37386)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f5rlz-0007or-5h
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 07:49:15 -0400
Received: by mail-ot0-x234.google.com with SMTP id y46-v6so12356401otd.4
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 04:49:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180410021745.32378-1-jcmvbkbc@gmail.com>
References: <20180410021745.32378-1-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Apr 2018 12:48:54 +0100
Message-ID: <CAFEAcA-SJuDbyy3=S01yUUuGJC+3YhHbgr5xdWv7stizYTO8yg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/1] linux-user: fix file offset for
 preadv/pwritev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Richard Henderson <richard.henderson@linaro.org>

On 10 April 2018 at 03:17, Max Filippov <jcmvbkbc@gmail.com> wrote:
> Hi Peter,
>
> please pull the following linux-user fix for QEMU-2.12.
>
> The following changes since commit 9abfc88af3ffd3b33c7fab4471da86462ee71d95:
>
>   Merge remote-tracking branch 'remotes/xtensa/tags/20180402-xtensa' into staging (2018-04-03 19:02:46 +0100)
>
> are available in the git repository at:
>
>   git://github.com/OSLL/qemu-xtensa.git tags/20180409-xtensa
>
> for you to fetch changes up to 9ac225171c9d6b2a1cba35a94ae7eeaa0106cf7d:
>
>   linux-user: fix preadv/pwritev offsets (2018-04-09 18:57:49 -0700)
>
> ----------------------------------------------------------------
> Fix file offset for preadv/pwritev linux-user syscalls.
>
> ----------------------------------------------------------------
> Max Filippov (1):
>       linux-user: fix preadv/pwritev offsets

Applied, thanks.

-- PMM
