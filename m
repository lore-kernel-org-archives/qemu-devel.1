Received: from eggs.gnu.org ([2001:4830:134:3::10]:50121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dag3D-0001fR-2i
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 06:29:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dag3C-0007dL-8E
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 06:29:51 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:35470)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dag3C-0007cH-1l
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 06:29:50 -0400
Received: by mail-wr0-x229.google.com with SMTP id k71so88274094wrc.2
	for <qemu-devel@nongnu.org>; Thu, 27 Jul 2017 03:29:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170726184421.1315.42536.stgit@gimli.home>
References: <20170726184421.1315.42536.stgit@gimli.home>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Jul 2017 11:29:28 +0100
Message-ID: <CAFEAcA8=VUjj4+Rk+ooG1RYrRmOAxeueA21Ew9rcQC7_RkdDJw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/2] VFIO fixes for v2.10-rc1
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

On 26 July 2017 at 19:45, Alex Williamson <alex.williamson@redhat.com> wrot=
e:
> The following changes since commit 522fd24ca030c27c591dafedd65c1dfd51e404=
50:
>
>   Update version for v2.10.0-rc0 release (2017-07-25 17:13:09 +0100)
>
> are available in the git repository at:
>
>   git://github.com/awilliam/qemu-vfio.git tags/vfio-fixes-20170726.0
>
> for you to fetch changes up to 96d2c2c57452f8b6bc3decae71435e7230f3432e:
>
>   vfio/pci: fix use of freed memory (2017-07-26 11:38:18 -0600)
>
> ----------------------------------------------------------------
> VFIO fixes 2017-07-26
>
>  - Error path use after free bug fixes (Philippe Mathieu-Daud=C3=A9)
>
> ----------------------------------------------------------------
> Philippe Mathieu-Daud=C3=A9 (2):
>       vfio/platform: fix use of freed memory
>       vfio/pci: fix use of freed memory

Applied, thanks.

-- PMM
