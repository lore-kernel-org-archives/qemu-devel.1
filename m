Received: from eggs.gnu.org ([208.118.235.92]:41756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfUiP-0002CS-8J
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 14:01:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gfUiO-0003A9-8q
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 14:01:05 -0500
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:39721)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gfUiO-00039y-48
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 14:01:04 -0500
Received: by mail-oi1-x22b.google.com with SMTP id i6so31118435oia.6
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 11:01:04 -0800 (PST)
MIME-Version: 1.0
References: <20190104162559.20760-1-philmd@redhat.com>
In-Reply-To: <20190104162559.20760-1-philmd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 4 Jan 2019 19:00:52 +0000
Message-ID: <CAFEAcA_FrDO7Aw7Z607H+SEtSL0AdqxtzSRATTXmKggbRA_1jg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/4] fw_cfg 20190104 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

On Fri, 4 Jan 2019 at 16:32, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com=
> wrote:
>
> Hi Peter,
>
> The following changes since commit 6395fe0c2c7d9f336d87960a7c9924b630c57c=
91:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'=
 into staging (2019-01-04 13:22:51 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/fw_cfg-20190104-pull-request
>
> for you to fetch changes up to 19bcc4bc3213e78c303ad480a7a578f62258252d:
>
>   fw_cfg: Make qemu_extra_params_fw locally (2019-01-04 15:30:52 +0100)
>
> ----------------------------------------------------------------
>
> fw_cfg patches for 2019-01-04
>
> Two fixes from Li Qiang:
> - Improve error message when can't load splash file
> - Fix boot bootsplash and reboot-timeout error checking
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.0
for any user-visible changes.

-- PMM
