Received: from eggs.gnu.org ([2001:4830:134:3::10]:57231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYVmc-0001yp-Ii
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 06:40:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYVmb-0000yc-MP
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 06:40:02 -0500
Received: from mail-oi0-x22c.google.com ([2607:f8b0:4003:c06::22c]:46095)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYVmb-0000yC-Fg
	for qemu-devel@nongnu.org; Mon, 08 Jan 2018 06:40:01 -0500
Received: by mail-oi0-x22c.google.com with SMTP id d124so3006704oib.13
	for <qemu-devel@nongnu.org>; Mon, 08 Jan 2018 03:40:01 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1513973785-14427-1-git-send-email-stefanb@linux.vnet.ibm.com>
References: <1513973785-14427-1-git-send-email-stefanb@linux.vnet.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jan 2018 11:39:40 +0000
Message-ID: <CAFEAcA-7zYeWoqzdgWvBXXdtLk_N1HjtBL7J8cyohE3t-YUbvw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 00/10] Merge tpm 2017/12/22
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Berger <stefanb@linux.vnet.ibm.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 22 December 2017 at 20:16, Stefan Berger <stefanb@linux.vnet.ibm.com> wrote:
> The following series of patches most important parts add a caching layer
> to the TPM emulator backend for reducing the number of control commands sent
> to retrieve the TPMEstablished flag. They also simplify the TPM TIS internal
> usage of buffers and r/w offsets in preparation for adding migration support
> to the device.
>
>     Stefan
>
> The following changes since commit 281f327487c9c9b1599f93c589a408bbf4a651b8:
>
>   Merge remote-tracking branch 'remotes/vivier/tags/m68k-for-2.12-pull-request' into staging (2017-12-22 00:11:36 +0000)
>
> are available in the git repository at:
>
>   git://github.com/stefanberger/qemu-tpm.git tags/pull-tpm-2017-12-22-1
>
> for you to fetch changes up to 4a42fa0ee20b51b326f6494cb50218b52471a261:
>
>   acpi: Update TPM2 ACPI table to more recent specs (2017-12-22 11:03:21 -0500)
>
> ----------------------------------------------------------------
> Merge tpm 2017/12/22 v1
>
> ----------------------------------------------------------------

Applied, thanks.

-- PMM
