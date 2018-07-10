Received: from eggs.gnu.org ([2001:4830:134:3::10]:60712)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcpJA-00010o-UQ
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 05:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcpJA-0001SZ-4H
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 05:51:44 -0400
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:42812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fcpJ9-0001ST-UB
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 05:51:44 -0400
Received: by mail-oi0-x235.google.com with SMTP id n84-v6so41432292oib.9
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 02:51:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180710062352.9843-1-laurent@vivier.eu>
References: <20180710062352.9843-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Jul 2018 10:51:22 +0100
Message-ID: <CAFEAcA8so_HkzMN9mMeHjB2FMho6Gzp0ZySUiTTCiYfQ8dO9Ng@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/3] Linux user for 3.0 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 10 July 2018 at 07:23, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit 43a473993fd9378bf850dcafa68eb6dee8c300=
f8:
>
>   Merge remote-tracking branch 'remotes/bonzini/tags/for-upstream' into s=
taging (2018-07-06 18:18:08 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-3.0-pull-request
>
> for you to fetch changes up to 84ca4fa99d7b6c83ce31e1e41300d55cb4e97dcb:
>
>   linux-user: Report error message on stderr, rather than stdout (2018-07=
-09 00:52:50 +0200)
>
> ----------------------------------------------------------------
> Sanitize linux-user stdout
>
> ----------------------------------------------------------------
>
> Philippe Mathieu-Daud=C3=A9 (3):
>   linux-user: Do not report "Unsupported syscall" by default
>   linux-user: Do not report "syscall not implemented" by default
>   linux-user: Report error message on stderr, rather than stdout
>

Applied, thanks.

-- PMM
