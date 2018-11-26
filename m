Received: from eggs.gnu.org ([208.118.235.92]:43750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRFKy-00016G-PM
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 06:46:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gRFKy-00080P-5E
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 06:46:00 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:33186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gRFKx-0007zl-W8
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 06:46:00 -0500
Received: by mail-oi1-x22c.google.com with SMTP id c206so15534822oib.0
	for <qemu-devel@nongnu.org>; Mon, 26 Nov 2018 03:45:59 -0800 (PST)
MIME-Version: 1.0
References: <20181125231236.22252-1-jcmvbkbc@gmail.com>
In-Reply-To: <20181125231236.22252-1-jcmvbkbc@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Nov 2018 11:45:47 +0000
Message-ID: <CAFEAcA-ueQ6_=8J-4Y45Dm1RU1zM01uiNL1+x66xKi9BD7TTgg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/4] target/xtensa fixes for 3.1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On Sun, 25 Nov 2018 at 23:12, Max Filippov <jcmvbkbc@gmail.com> wrote:
>
> Hi Peter,
>
> please pull the following batch of fixes for target/xtensa.
>
> The following changes since commit 47c1cc30e440860aa695358f7c2dd0b9d7b53d16:
>
>   Update version for v3.1.0-rc2 release (2018-11-20 18:10:26 +0000)
>
> are available in the git repository at:
>
>   git://github.com/OSLL/qemu-xtensa.git tags/20181125-xtensa
>
> for you to fetch changes up to 895e4897e278572e5265e0333f5e9864be2704a6:
>
>   MAINTAINERS: add missing xtensa patterns (2018-11-22 21:16:43 -0800)
>
> ----------------------------------------------------------------
> xtensa fixes for 3.1:
>
> - fix register counting logic for linux-user gdbserver;
> - provide default memory sizes for XTFPGA boards;
> - add missing xtensa patterns to MAINTAINTERS.
>

Applied, thanks.

-- PMM
