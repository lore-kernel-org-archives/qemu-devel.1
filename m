Received: from eggs.gnu.org ([2001:4830:134:3::10]:58782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXjbJ-0006EM-3G
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fXjbH-0001xg-MQ
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:45:25 -0400
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:43428)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fXjbH-0001x4-1K
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 04:45:23 -0400
Received: by mail-oi0-x231.google.com with SMTP id x18-v6so5845480oie.10
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 01:45:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1529957164-4744-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1529957164-4744-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Jun 2018 09:45:01 +0100
Message-ID: <CAFEAcA_FJona1PTrFV1AD8DPL1jZsbaN01Pkrz+ErHuDjE9=Ag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/9] Target MIPS queue, 2018-06-25
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 25 June 2018 at 21:05, Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
> From: Aleksandar Markovic <aleksandar.markovic@mips.com>
>
> The following changes since commit 35e238c9330669882487f9929e0aa97900431853:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/audio-20180625-pull-request' into staging (2018-06-25 15:25:26 +0100)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu.git
>
> for you to fetch changes up to 2209731f338baaad3a1ef419fab1928e1e51ec17:
>
>   target/mips: Fix gdbstub to read/write 64 bit FP registers (2018-06-25 21:21:24 +0200)

Hi -- something odd has happened in the creation of this
pull request email. The URL line should include a tag name,
and this one doesn't...

thanks
-- PMM
