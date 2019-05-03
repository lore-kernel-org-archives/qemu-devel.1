Received: from eggs.gnu.org ([209.51.188.92]:45611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMZ7Q-0007fr-LH
	for qemu-devel@nongnu.org; Fri, 03 May 2019 10:24:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hMZ7P-0006ea-L7
	for qemu-devel@nongnu.org; Fri, 03 May 2019 10:24:56 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:36454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hMZ7P-0006dx-EA
	for qemu-devel@nongnu.org; Fri, 03 May 2019 10:24:55 -0400
Received: by mail-oi1-x22c.google.com with SMTP id l203so4562883oia.3
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 07:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190503093118.15700-1-lersek@redhat.com>
In-Reply-To: <20190503093118.15700-1-lersek@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 3 May 2019 15:24:41 +0100
Message-ID: <CAFEAcA8+bnR53GvtNFyPvJKZWufdLSq5DxR33dr_CMLnnsFdpw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] tests/uefi-test-tools: report the
 SMBIOS entry point structures
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Igor Mammedov <imammedo@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On Fri, 3 May 2019 at 10:33, Laszlo Ersek <lersek@redhat.com> wrote:
>
> No changes relative to the original posting at
> <http://mid.mail-archive.com/20190425104326.12835-1-lersek@redhat.com>,
> except for picking up the review/testing tags (also noted separately on
> each patch).
>
> Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
> Cc: Igor Mammedov <imammedo@redhat.com>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM
