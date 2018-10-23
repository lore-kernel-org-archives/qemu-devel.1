Received: from eggs.gnu.org ([2001:4830:134:3::10]:52010)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gEsVF-0005EL-Pm
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 04:57:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gEsVE-0003nR-S7
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 04:57:29 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:44507)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gEsVE-0003jq-A9
	for qemu-devel@nongnu.org; Tue, 23 Oct 2018 04:57:28 -0400
Received: by mail-ot1-x330.google.com with SMTP id p23so573497otf.11
	for <qemu-devel@nongnu.org>; Tue, 23 Oct 2018 01:57:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20181019121910.29726-1-laurent@vivier.eu>
References: <20181019121910.29726-1-laurent@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 23 Oct 2018 09:57:04 +0100
Message-ID: <CAFEAcA-41PSSXcrbRha22d=mMSHetcikSq9bUUYtJ=XCOexjYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/3] Linux user for 3.1 patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>

On 19 October 2018 at 13:19, Laurent Vivier <laurent@vivier.eu> wrote:
> The following changes since commit 1b7490446bf41f54130c2d495dd4c8768c8e1c=
e3:
>
>   Merge remote-tracking branch 'remotes/vivier2/tags/linux-user-for-3.1-p=
ull-request' into staging (2018-10-19 11:20:05 +0100)
>
> are available in the Git repository at:
>
>   git://github.com/vivier/qemu.git tags/linux-user-for-3.1-pull-request
>
> for you to fetch changes up to a133367ec1b689410f1e7427921e33bb1b569bd7:
>
>   linux-user: Implement special usbfs ioctls. (2018-10-19 14:05:10 +0200)
>
> ----------------------------------------------------------------
> A series to enable ioctl usbfs in linux-user
>
> ----------------------------------------------------------------
>
> Cortland T=C3=B6lva (3):
>   linux-user: Check for Linux USBFS in configure
>   linux-user: Define ordinary usbfs ioctls.
>   linux-user: Implement special usbfs ioctls.
>

Applied, thanks.

-- PMM
