Received: from eggs.gnu.org ([2001:4830:134:3::10]:52040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdZmu-000422-7r
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:29:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdZmt-0008Ld-5V
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:29:32 -0400
Received: from mail-oi0-x236.google.com ([2607:f8b0:4003:c06::236]:46194)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fdZms-0008LN-Uc
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 07:29:31 -0400
Received: by mail-oi0-x236.google.com with SMTP id y207-v6so55118941oie.13
	for <qemu-devel@nongnu.org>; Thu, 12 Jul 2018 04:29:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <153133890557.31530.586346402906852972.stgit@w520.home>
References: <153133890557.31530.586346402906852972.stgit@w520.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jul 2018 12:29:08 +0100
Message-ID: <CAFEAcA-D_TvFVqdfrA86Ze7=2jjLgjgmbKgAirw4asvoPGCMag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/1] VFIO fixes for qemu-3.0-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 11 July 2018 at 20:55, Alex Williamson <alex.williamson@redhat.com> wrot=
e:
> The following changes since commit c447afd5783b9237fa51b7a85777007d8d568b=
fc:
>
>   Update version for v3.0.0-rc0 release (2018-07-10 18:19:50 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/awilliam/qemu-vfio.git tags/vfio-fixes-20180711.1
>
> for you to fetch changes up to 26c0ae56386edacc8b0da40264748f59afedb1bb:
>
>   vfio/pci: do not set the PCIDevice 'has_rom' attribute (2018-07-11 13:4=
3:57 -0600)
>
> ----------------------------------------------------------------
> VFIO fixes 2018-07-11
>
>  - Avoid RAMBlock segfault in option ROM teardown for vfio-pci devices
>    (C=C3=A9dric Le Goater)
>
> ----------------------------------------------------------------
> C=C3=A9dric Le Goater (1):
>       vfio/pci: do not set the PCIDevice 'has_rom' attribute
>
>  hw/vfio/pci.c | 1 -
>  1 file changed, 1 deletion(-)
>


Applied, thanks.

-- PMM
