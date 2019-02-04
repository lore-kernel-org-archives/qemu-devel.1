Received: from eggs.gnu.org ([209.51.188.92]:40176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gqRmE-0005r7-KK
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 19:06:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmathieu@redhat.com>) id 1gqRmD-0001Ex-To
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 19:06:18 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1gqRmD-0001B6-Ml
	for qemu-devel@nongnu.org; Sun, 03 Feb 2019 19:06:17 -0500
Received: by mail-wr1-f67.google.com with SMTP id v13so12636528wrw.5
	for <qemu-devel@nongnu.org>; Sun, 03 Feb 2019 16:06:15 -0800 (PST)
MIME-Version: 1.0
References: <20190203220744.11734-1-philmd@redhat.com>
In-Reply-To: <20190203220744.11734-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Mon, 4 Feb 2019 01:06:03 +0100
Message-ID: <CAP+75-Ve9NwAfgmXoXDGuK5ykZWn-9+Y8Wj1+M91noNFtuVNDw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/6] Kconfig dependencies for MIPS machines
 (but Malta)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, James Hogan <jhogan@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>, Thomas Huth <thuth@redhat.com>, Yang Zhong <yang.zhong@intel.com>, Paul Burton <pburton@wavecomp.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>

On Sun, Feb 3, 2019 at 11:07 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
>
> Express the MIPS machine dependencies with Kconfig.

I forgot this serie misses a rule such "depends of MIPS64".
Asked here: https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg00064.=
html
