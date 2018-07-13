Received: from eggs.gnu.org ([2001:4830:134:3::10]:37240)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdvP9-0005HQ-HI
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 06:34:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdvP8-0003py-DL
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 06:34:27 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:39368)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fdvP7-0003pR-Us
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 06:34:26 -0400
Received: by mail-oi0-x242.google.com with SMTP id d189-v6so61340923oib.6
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 03:34:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180612065150.21110-1-ville.skytta@iki.fi>
References: <20180612065150.21110-1-ville.skytta@iki.fi>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jul 2018 11:34:04 +0100
Message-ID: <CAFEAcA8LOH5=RowJ-0GF-nNt-g-CcbNbAhJGGpw1ba4NOxK1jg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] docs: Grammar and spelling fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Ville_Skytt=C3=A4?= <ville.skytta@iki.fi>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 12 June 2018 at 07:51, Ville Skytt=C3=A4 <ville.skytta@iki.fi> wrote:
> Signed-off-by: Ville Skytt=C3=A4 <ville.skytta@iki.fi>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>  docs/colo-proxy.txt                  | 2 +-
>  docs/config/mach-virt-graphical.cfg  | 2 +-
>  docs/config/mach-virt-serial.cfg     | 2 +-
>  docs/config/q35-emulated.cfg         | 2 +-
>  docs/config/q35-virtio-graphical.cfg | 2 +-
>  docs/config/q35-virtio-serial.cfg    | 2 +-
>  docs/devel/migration.rst             | 2 +-
>  docs/devel/multi-thread-tcg.txt      | 2 +-
>  docs/interop/qcow2.txt               | 6 +++---
>  docs/interop/vhost-user.txt          | 4 ++--
>  docs/memory-hotplug.txt              | 2 +-
>  docs/multiseat.txt                   | 2 +-
>  docs/qemu-block-drivers.texi         | 2 +-
>  docs/qemupciserial.inf               | 2 +-
>  docs/specs/acpi_nvdimm.txt           | 3 ++-
>  docs/specs/ppc-spapr-hcalls.txt      | 2 +-
>  docs/specs/tpm.txt                   | 2 +-
>  docs/usb2.txt                        | 2 +-
>  18 files changed, 22 insertions(+), 21 deletions(-)
>

Applied to master; sorry this patch slipped through the cracks
in our process.

-- PMM
