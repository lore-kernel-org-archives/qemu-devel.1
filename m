Received: from eggs.gnu.org ([2001:4830:134:3::10]:57162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejSXj-0007Ab-C0
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:25:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejSXe-0005Ix-Qy
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:25:55 -0500
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:40210)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ejSXe-0005In-N6
	for qemu-devel@nongnu.org; Wed, 07 Feb 2018 11:25:50 -0500
Received: by mail-ot0-x230.google.com with SMTP id s4so1323932oth.7
	for <qemu-devel@nongnu.org>; Wed, 07 Feb 2018 08:25:50 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180206184101.14644.84734.stgit@gimli.home>
References: <20180206184101.14644.84734.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Feb 2018 16:25:29 +0000
Message-ID: <CAFEAcA-FTTdfwOrKQtRf3A2DRnNCgd=J0MUSX5E-e_F74dGFjg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 00/11] VFIO updates 2018-02-06
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

On 6 February 2018 at 18:42, Alex Williamson <alex.williamson@redhat.com> wrote:
> The following changes since commit 20e0d439a6ded635ec89f6135c08cd5541c68962:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-hppa-20180204' into staging (2018-02-06 14:21:41 +0000)
>
> are available in the Git repository at:
>
>   git://github.com/awilliam/qemu-vfio.git tags/vfio-update-20180206.0
>
> for you to fetch changes up to db32d0f43839627f54a1a7f8eee17baa770f52d2:
>
>   vfio/pci: Add option to disable GeForce quirks (2018-02-06 11:08:27 -0700)
>
> ----------------------------------------------------------------
> VFIO updates 2018-02-06
>
>  - SPAPR in-kernel TCE accleration (Alexey Kardashevskiy)
>
>  - MSI-X relocation (Alex Williamson)
>
>  - Add missing platform mutex init (Eric Auger)
>
>  - Redundant variable cleanup (Alexey Kardashevskiy)
>
>  - Option to disable GeForce quirks (Alex Williamson)

Applied, thanks.

-- PMM
