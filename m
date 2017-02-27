Received: from eggs.gnu.org ([2001:4830:134:3::10]:54411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciI6T-0005xE-GN
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:00:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ciI6S-0007MU-KY
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:00:25 -0500
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:35853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ciI6S-0007Lw-ET
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 05:00:24 -0500
Received: by mail-wr0-x22d.google.com with SMTP id u108so18536204wrb.3
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 02:00:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1488148156-2036-1-git-send-email-atar4qemu@gmail.com>
References: <1488148156-2036-1-git-send-email-atar4qemu@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Feb 2017 10:00:02 +0000
Message-ID: <CAFEAcA_PH-PKU5=ni8VRoO6EizYKo_gqqAFxPZfBwGxyOyz58w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PULL 0/2] sun4v queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

On 26 February 2017 at 22:29, Artyom Tarasenko <atar4qemu@gmail.com> wrote:
> The following changes since commit a951316b8a5c3c63254f20a826afeed940dd4cba:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2017-02-03 14:41:49 +0000)
>
> are available in the git repository at:
>
>   https://github.com/artyom-tarasenko/qemu tags/pull-sun4v-20170226
>
> for you to fetch changes up to a5a08302d44a8b1a8c5819b1411002f85bb5f847:
>
>   niagara: check if a serial port is available (2017-02-26 22:46:08 +0100)
>
> ----------------------------------------------------------------
> Pull request for Niagara patches 2017 02 26
>
> ----------------------------------------------------------------
> Artyom Tarasenko (2):
>       niagara: fail if a firmware file is missing
>       niagara: check if a serial port is available
>
>  hw/sparc64/niagara.c | 33 +++++++++++++++++++++++----------
>  1 file changed, 23 insertions(+), 10 deletions(-)

Applied, thanks.

-- PMM
